//
//  TrendTableViewController.swift
//  TrendMedia
//
//  Created by Junhee Yoon on 2022/07/19.
//

import UIKit
import RealmSwift

struct ListStatus {
    var checkButton: Bool
    var title: String
    var favouriteButton: Bool
}

class TrendTableViewController: UITableViewController {

    // MARK: - Properties
    
    var list: [ListStatus] = [] {
        didSet {
            tableView.reloadData()
            print("list가 변경됨! \(list), \(oldValue)")
        }
    }
    
    let localRealm = try! Realm()
    var tasks: Results<ShoppingList>!

    
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
                
                let task = ShoppingList(contents: text, registeredDate: Date())
                
                try! self.localRealm.write {
                    self.localRealm.add(task)
                    print("Realm Succeed")
                }
                tableView.reloadData()
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
            
            return cell
            
        } else {
           
            let cell = tableView.dequeueReusableCell(withIdentifier: "TrendTableViewCell", for: indexPath) as! TrendTableViewCell
            
            cell.shoppingListLabel.text = list[indexPath.row].title
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
            tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 70
        } else {
            return 40
        }
    }
}
