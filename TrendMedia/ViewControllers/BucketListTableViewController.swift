//
//  BucketListTableViewController.swift
//  TrendMedia
//
//  Created by Junhee Yoon on 2022/07/19.
//

import UIKit

struct Todo {
    var title: String
    var done: Bool
}

class BucketListTableViewController: UITableViewController {

    // MARK: - Properties
    
    static let identifier = "BucketListTableViewController"
    
    // 클래스는 ReferenceType -> 인스턴스 자체를 변경하지 않는 이상 한 번만 호출됨(didSet)
    // IBOutlet ViewDidLoad 호출 되기 직전에 nil이 아닌지 nil인지 알 수 있음!
    @IBOutlet weak var userTextField: UITextField! {
        didSet {
            userTextField.textAlignment = .center
            userTextField.font = .boldSystemFont(ofSize: 22)
            userTextField.textColor = .systemRed
            print("TextField didSet")
        }
    }
    
    // 리스트 프로퍼티가 추가, 삭제 등 변경되고 나서 테이블뷰를 항상 갱신!
    var list = [Todo(title: "범죄도시2", done: false), Todo(title: "탑건", done: false)] {
        didSet {
            tableView.reloadData()
            print("list가 변경됨! \(list), \(oldValue)")
        }
    }
    
    var placeHolder: String?
    
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "버킷리스트"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeButtonClicked))
        
        tableView.rowHeight = 80
        
//        list.updateValue(false, forKey: "마녀")
//        list.updateValue(false, forKey: "헤어질결심")
        
        userTextField.placeholder = placeHolder
        
    }
    
    
    // MARK: - Selectors
    
    @objc func closeButtonClicked() {
        self.dismiss(animated: true)
    }
    
    @objc func checkboxButtonClicked(sender: UIButton) {
        print("\(sender.tag)버튼 클릭")
        
        // 배열 인덱스를 찾아서 바꿔야한다, 테이블뷰 갱신 해야한다.
        list[sender.tag].done = !list[sender.tag].done
        tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .fade)
        
        // 재사용 셀 오류 확인
//        sender.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
    }

    
    // MARK: - Helper Functions
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: BucketListTableViewCell.identifier, for: indexPath) as! BucketListTableViewCell // as? 타입 캐스팅
        
        cell.bucketListLabel.text = list[indexPath.row].title
        cell.bucketListLabel.font = .boldSystemFont(ofSize: 18)
        
        cell.checkBoxButton.tag = indexPath.row
        cell.checkBoxButton.addTarget(self, action: #selector(checkboxButtonClicked(sender:)), for: .touchUpInside)
        
        let value = list[indexPath.row].done ? "checkmark.square.fill" : "checkmark.square"
        cell.checkBoxButton.setImage(UIImage(systemName: value), for: .normal)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // 우측 스와이프 디폴트 기능: commit editingStyle
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            // 배열 삭제 후 테이블뷰 갱신
            list.remove(at: indexPath.row)
//            tableView.reloadData()
//            tableView.reloadRows(at: [IndexPath(row: indexPath.row, section: indexPath.section)], with: .fade)
        }
    }
    
//    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        // 즐겨찾기 / 핀고정
//    }
    
//    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        // 차단 등
//    }
    
    
    // MARK: - IBActions
    
    @IBAction func userTextFieldReturn(_ sender: UITextField) {
        
        // case 1
//        if let value = sender.text?.trimmingCharacters(in: .whitespacesAndNewlines), !value.isEmpty, (2...6).contains(value.count) {
//            list.append(value)
//            tableView.reloadData()
//        } else {
//            // 토스트 메세지 띄우기
//        }
        
        // case 2
        guard let value = sender.text?.trimmingCharacters(in: .whitespacesAndNewlines), !value.isEmpty, (2...6).contains(value.count) else {
            // alert, toast 등을 통해 알림보내기
            return }
        list.append(Todo(title: sender.text!, done: false))
//        tableView.reloadData()
//        tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .fade)
    }
    

}
