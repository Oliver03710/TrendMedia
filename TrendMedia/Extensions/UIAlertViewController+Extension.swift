//
//  UIAlertViewController+Extension.swift
//  TrendMedia
//
//  Created by Junhee Yoon on 2022/08/25.
//

import UIKit

extension UIViewController {
    
    func showAlertMessage(title: String, button: String = "확인") {
        let okay = UIAlertAction(title: button, style: .default) { _ in
            
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alert.addAction(okay)
        alert.addAction(cancel)
        self.present(alert, animated: true)
        
    }
    
    func showRestoreAlertMessage(title: String, button: String = "확인") {
        let okay = UIAlertAction(title: button, style: .default) { _ in
            
            let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
            let sceneDelegate = windowScene?.delegate as? SceneDelegate
            
            let sb = UIStoryboard(name: "Trend", bundle: nil)
            guard let vc = sb.instantiateViewController(withIdentifier: TrendTableViewController.reuseIdentifier) as? TrendTableViewController else { return }
            let nav = UINavigationController(rootViewController: vc)
            
            sceneDelegate?.window?.rootViewController = nav
            sceneDelegate?.window?.makeKeyAndVisible()
        }
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alert.addAction(okay)
        self.present(alert, animated: true)
        
    }
    
}
