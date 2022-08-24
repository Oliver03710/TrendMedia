//
//  TrendTableViewController.swift
//  TrendMedia
//
//  Created by Junhee Yoon on 2022/07/19.
//

import UIKit
import PhotosUI

import RealmSwift

struct ListStatus {
    var checkButton: Bool
    var title: String
    var favouriteButton: Bool
}

protocol TransferDataDelegate {
    func listInfo(checked: Bool, Favourite: Bool, list: String, date: Date, objectId: ObjectId)
}


class TrendTableViewController: UITableViewController {

    // MARK: - Properties
    
//    var list: [ListStatus] = [] {
//        didSet {
//            tableView.reloadData()
//            print("list가 변경됨! \(list), \(oldValue)")
//        }
//    }
    
    lazy var phPicker: PHPickerViewController = {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        configuration.selectionLimit = 1
        
        let phPicker = PHPickerViewController(configuration: configuration)
        phPicker.delegate = self
        return phPicker
    }()
    
    let localRealm = try! Realm()
    var tasks: Results<ShoppingList>! {
        didSet {
            tableView.reloadData()
        }
    }

    var delegate: TransferDataDelegate?
    var selectedImage: UIImage?
    var objectID: ObjectId?
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        handlingSavedData()
    }
    
    
    // MARK: - Selectors
    
    @objc func checkboxButtonClicked(sender: UIButton) {
        
        try! localRealm.write {
            tasks[sender.tag].checkButton.toggle()
        }
        tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 1)], with: .fade)
    }
    
    @objc func favouriteButtonClicked(sender: UIButton) {
                                                     
        try! localRealm.write {
            tasks[sender.tag].favouriteButton.toggle()
        }
        tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 1)], with: .fade)
    }
    
    
    // MARK: - Helper Functions
    
    func handlingSavedData() {
        tasks = localRealm.objects(ShoppingList.self).sorted(byKeyPath: "registeredDate", ascending: true)
    }
    
    
    // MARK: - Table View Functions
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 1
        } else {
            return tasks.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if indexPath.section == 0 {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TextFieldTableViewCell", for: indexPath) as? TextFieldTableViewCell else { return UITableViewCell() }
            
            cell.setUI()

            cell.addButtonAction = {
                
                guard let text = cell.shoppingTextField.text else { return }
                guard !text.isEmpty else { return }
                let task = ShoppingList(contents: text, registeredDate: Date())
                self.objectID = task.objectId
                try! self.localRealm.write {
                    self.localRealm.add(task)
                    print("Realm Succeed")
                    self.tableView.reloadData()
                }
                self.present(self.phPicker, animated: true)
                
                cell.shoppingTextField.text = nil
                
            }
            
            cell.reloadAction = {
                
                let sortByChecked = UIAction(title: "선택 기준 정렬", image: UIImage(systemName: "checklist")) { _ in
                    self.tasks = self.localRealm.objects(ShoppingList.self).sorted(byKeyPath: "checkButton", ascending: false)
                }
                
                let sortByFavourite = UIAction(title: "즐겨찾기 기준 정렬", image: UIImage(systemName: "list.star")) { _ in
                    self.tasks = self.localRealm.objects(ShoppingList.self).sorted(byKeyPath: "favouriteButton", ascending: false)
                }
                
                let sortByTodo = UIAction(title: "할일 기준 정렬", image: UIImage(systemName: "list.bullet.rectangle.portrait")) { _ in
                    self.tasks = self.localRealm.objects(ShoppingList.self).sorted(byKeyPath: "contents", ascending: true)
                }
                
                let sortByDate = UIAction(title: "등록일 기준 정렬", image: UIImage(systemName: "folder.badge.plus")) { _ in
                    self.tasks = self.localRealm.objects(ShoppingList.self).sorted(byKeyPath: "registeredDate", ascending: true)
                }
                
                cell.sortButton.showsMenuAsPrimaryAction = true
                cell.sortButton.menu = UIMenu(options: .displayInline, children: [sortByTodo, sortByChecked, sortByFavourite, sortByDate])
                
                print("Reload Action")
            }
            
            return cell
            
        } else if indexPath.section == 1 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "TrendTableViewCell", for: indexPath) as! TrendTableViewCell
            
            cell.setUI()
            let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: tasks[indexPath.row].contents)
                attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSRange(location: 0, length: attributeString.length))
            
            let attributeString2: NSMutableAttributedString = NSMutableAttributedString(string: tasks[indexPath.row].contents)
                attributeString2.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 0, range: NSRange(location: 0, length: attributeString2.length))
            
            
            cell.shoppingListLabel.textColor = tasks[indexPath.row].checkButton ? .darkGray : .black
            cell.shoppingListLabel.attributedText = tasks[indexPath.row].checkButton ? attributeString : attributeString2
            
            cell.checkboxButton.tag = indexPath.row
            let value = tasks[indexPath.row].checkButton ? "checkmark.square" : "square"
            cell.checkboxButton.setImage(UIImage(systemName: value), for: .normal)
            cell.checkboxButton.addTarget(self, action: #selector(checkboxButtonClicked(sender:)), for: .touchUpInside)
            
            cell.favouriteButton.tag = indexPath.row
            let values = tasks[indexPath.row].favouriteButton ? "star.fill" : "star"
            cell.favouriteButton.setImage(UIImage(systemName: values), for: .normal)
            cell.favouriteButton.addTarget(self, action: #selector(favouriteButtonClicked(sender:)), for: .touchUpInside)
            
            tasks.forEach {
                if tasks[indexPath.row].objectId == $0.objectId {
                    cell.SampleImageView.image = loadImageFromDocument(fileName: "\($0.objectId).jpg")
                }
            }
            
            delegate?.listInfo(checked: tasks[indexPath.row].checkButton, Favourite: tasks[indexPath.row].favouriteButton, list: tasks[indexPath.row].contents, date: tasks[indexPath.row].registeredDate, objectId: tasks[indexPath.row].objectId)
            
            return cell
            
        } else {
           
            let cell = tableView.dequeueReusableCell(withIdentifier: "TrendTableViewCell", for: indexPath) as! TrendTableViewCell
            
            cell.shoppingListLabel.text = tasks[indexPath.row].contents
            cell.shoppingListLabel.font = .systemFont(ofSize: 18)
            
            return cell
            
        }

    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            try! localRealm.write {
                localRealm.delete(tasks[indexPath.row])
            }
            removeImageFromDocument(fileName: "\(tasks[indexPath.row]).jpg")
            tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vc = DetailListViewController()
        vc.checkedImageView.image = tasks[indexPath.row].checkButton ? UIImage(systemName: "checkmark.square") : UIImage(systemName: "square")
        vc.favouriteImageView.image = tasks[indexPath.row].favouriteButton ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
        vc.listLabel.text = tasks[indexPath.row].contents
        vc.registeredDateLabel.text = tasks[indexPath.row].registeredDate.toString()
        vc.imageView.image = loadImageFromDocument(fileName: "\(tasks[indexPath.row].objectId).jpg")
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 70
        } else {
            return 150
        }
    }
}


// MARK: - Extension: PHPickerViewControllerDelegate

extension TrendTableViewController: PHPickerViewControllerDelegate {
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        phPicker.dismiss(animated: true)
        
        let itemProvider = results.first?.itemProvider
        
        if let itemProvider = itemProvider,
           
            itemProvider.canLoadObject(ofClass: UIImage.self) {
            
            itemProvider.loadObject(ofClass: UIImage.self) { (image, error) in
                
                self.selectedImage = image as? UIImage
                if let objectId = self.objectID, let image = self.selectedImage {
                    self.saveImageToDocument(fileName: "\(objectId).jpg", image: image)
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            }
            
        } else {
            print("Error from Picking Photos")
            
        }
        
    }
    
}
