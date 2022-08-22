//
//  TendsTableViewController.swift
//  TrendMedia
//
//  Created by Junhee Yoon on 2022/07/21.
//

import UIKit

class TendsTableViewController: UITableViewController {

        
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    
    // MARK: - IBActions
    
    @IBAction func movieButtonClicked(_ sender: UIButton) {
        
        // 화면 전환: 1. 스토리보드 파일 2. 스토리보드 내에 뷰 컨트롤러 3. 화면 전환
        // 영화 버튼 클릭 시 -> BucketListTableViewController Present
        // 1.
        let sb = UIStoryboard(name: "Trend", bundle: nil)
        
        // 2.
        let vc = sb.instantiateViewController(withIdentifier: BucketListTableViewController.identifier) as! BucketListTableViewController
        
        vc.placeHolder = "영화 제목을 입력해주세요"
        
        // 3.
        self.present(vc, animated: true)
        
    }
    
    @IBAction func dramaButtonClicked(_ sender: UIButton) {
        
        // 화면 전환: 1. 스토리보드 파일 2. 스토리보드 내에 뷰 컨트롤러 3. 화면 전환
        // 영화 버튼 클릭 시 -> BucketListTableViewController Present
        // 1.
        let sb = UIStoryboard(name: "Trend", bundle: nil)
        
        // 2.
        let vc = sb.instantiateViewController(withIdentifier: BucketListTableViewController.identifier) as! BucketListTableViewController
        
        // 2.5. present 시 화면 전환 방식 설정(옵션)
//        vc.modalPresentationStyle = .fullScreen
        vc.placeHolder = "드라마 제목을 입력해주세요"
        
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        // 3.
        self.present(nav, animated: true)
        
    }
    
    @IBAction func bookButtonClicked(_ sender: UIButton) {
        
        // 화면 전환: 1. 스토리보드 파일 2. 스토리보드 내에 뷰 컨트롤러 3. 화면 전환
        // 영화 버튼 클릭 시 -> BucketListTableViewController Present
        // 1.
        let sb = UIStoryboard(name: "Trend", bundle: nil)
        
        // 2.
        let vc = sb.instantiateViewController(withIdentifier: BucketListTableViewController.identifier) as! BucketListTableViewController
        
        vc.placeHolder = "책 제목을 입력해주세요"
        
        // 2.5
        let nav = UINavigationController(rootViewController: vc)
        
        // 2.5. present 시 화면 전환 방식 설정(옵션)
        nav.modalPresentationStyle = .fullScreen
        
        // 3.
        self.present(nav, animated: true)
        
    }
    

}
