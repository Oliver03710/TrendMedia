//
//  SettingsTableViewController.swift
//  TrendMedia
//
//  Created by Junhee Yoon on 2022/07/18.
//

import UIKit

class SettingsTableViewController: UITableViewController {

    // MARK: - Properties
    
    let headerArr = ["전체 설정", "개인 설정", "기타"]
    let section0Arr = ["공지사항", "실험실", "버전 정보"]
    let section1Arr = ["개인/보안", "알림", "채팅", "멀티프로필"]
    let section2Arr = ["고객센터/도움말"]
    
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewDidLayoutSubviews()
        
    }
    
    // MARK: - Helper Functions
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let myLabel = UILabel()
        myLabel.frame = CGRect(x: 20, y: 8, width: 320, height: 20)
        myLabel.font = UIFont.boldSystemFont(ofSize: 20)
        myLabel.text = self.tableView(tableView, titleForHeaderInSection: section)
        myLabel.textColor = .systemGray

        let headerView = UIView()
        headerView.addSubview(myLabel)

        return headerView
    }
    
//    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 40
//    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return headerArr.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return headerArr[section]
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        switch section {
        case 0:
            return section0Arr.count
        case 1:
            return section1Arr.count
        default:
            return section2Arr.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cells")!
        
        switch indexPath.section {
        case 0:
            cell.textLabel?.text = section0Arr[indexPath.row]
            cell.textLabel?.textColor = .black
            cell.textLabel?.font = .systemFont(ofSize: 15)
        case 1:
            cell.textLabel?.text = section1Arr[indexPath.row]
            cell.textLabel?.textColor = .black
            cell.textLabel?.font = .systemFont(ofSize: 15)
        default:
            cell.textLabel?.text = section2Arr[indexPath.row]
            cell.textLabel?.textColor = .black
            cell.textLabel?.font = .systemFont(ofSize: 15)
        }
        
            return cell
    }
}
