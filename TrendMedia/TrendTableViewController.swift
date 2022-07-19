//
//  TrendTableViewController.swift
//  TrendMedia
//
//  Created by Junhee Yoon on 2022/07/19.
//

import UIKit

class TrendTableViewController: UITableViewController {

    // MARK: - Properties
    
    var list = ["테스트 출력", "쇼핑리스트 출력"]

    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    
    // MARK: - Helper Functions
    
    
    
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
            return list.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "TextFieldTableViewCell", for: indexPath) as! TextFieldTableViewCell
            
            cell.addButton.setTitle("추가", for: .normal)
            cell.addButton.clipsToBounds = true
            cell.addButton.layer.cornerRadius = 3
            cell.addButton.backgroundColor = .systemGray4
            cell.addButton.setTitleColor(.black, for: .normal)

            cell.actionBlock = {
                self.list.append(cell.shoppingTextField.text!)
                tableView.reloadData()
            }
            
            cell.shoppingTextField.placeholder = "무엇을 구매하실 건가요?"
            cell.shoppingTextField.backgroundColor = .systemGray5
            cell.shoppingTextField.borderStyle = .none
            
            cell.actionBlock = {
                self.list.append(cell.shoppingTextField.text!)
                tableView.reloadData()
            }
            
            return cell
            
        } else if indexPath.section == 1 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "TrendTableViewCell", for: indexPath) as! TrendTableViewCell
            
            cell.shoppingListLabel.text = list[indexPath.row]
            cell.shoppingListLabel.font = .systemFont(ofSize: 18)
            
            cell.checkboxButton.tintColor = .black
            cell.favouriteButton.tintColor = .black
            
            return cell
            
        } else {
           
            let cell = tableView.dequeueReusableCell(withIdentifier: "TrendTableViewCell", for: indexPath) as! TrendTableViewCell
            
            cell.shoppingListLabel.text = list[indexPath.row]
            cell.shoppingListLabel.font = .systemFont(ofSize: 18)
            
            return cell
            
        }

    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            list.remove(at: indexPath.row)
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
