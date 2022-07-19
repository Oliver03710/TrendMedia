//
//  SettingsTableViewController.swift
//  TrendMedia
//
//  Created by Junhee Yoon on 2022/07/18.
//

import UIKit

// CaseIterable - 프로토콜, 배열처럼 열거형을 활용할 수 있는 특성
enum SettingOptions: Int, CaseIterable {
    case total, personal, others // 섹션
    
    var sectionTitle: String {
        switch self {
        case .total:
            return "전체 설정"
        case .personal:
            return "개인 설정"
        case .others:
            return "기타"
        }
    }
    
    var rowTitle: [String] {
        switch self {
        case .total:
            return ["공지사항", "실험실", "버전 정보"]
        case .personal:
            return ["개인/보안", "알림", "채팅", "멀티프로필"]
        case .others:
            return ["고객센터/도움말"]
        }
    }
}



class SettingsTableViewController: UITableViewController {

    // MARK: - Properties
    
//    let headerArr = ["전체 설정", "개인 설정", "기타"]
//    let section0Arr = ["공지사항", "실험실", "버전 정보"]
//    let section1Arr = ["개인/보안", "알림", "채팅", "멀티프로필"]
//    let section2Arr = ["고객센터/도움말"]
    
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
//        return headerArr.count
        return SettingOptions.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return SettingOptions.allCases[section].sectionTitle
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return SettingOptions.allCases[section].rowTitle.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cells")!
        
            cell.textLabel?.text = SettingOptions.allCases[indexPath.section].rowTitle[indexPath.row]
            cell.textLabel?.textColor = .black
            cell.textLabel?.font = .systemFont(ofSize: 15)
        
            return cell
    }
}
