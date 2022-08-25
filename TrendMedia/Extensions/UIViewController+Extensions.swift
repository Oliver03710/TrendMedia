//
//  UIViewController+Extensions.swift
//  TrendMedia
//
//  Created by Junhee Yoon on 2022/07/19.
//

import UIKit

extension UIViewController {
    
    enum TransitionStyle {
        case present
        case presentNavigation
        case presentFullNavigation
        case push
    }
    
    func setBackgroundColor() {
        
        view.backgroundColor = .orange
        
    }
    
    func showAlert() {
        
        let alert = UIAlertController(title: "Title", message: "messages", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        
        present(alert, animated: true)
    }
    
    func transitionViewController<T: UIViewController>(_ viewController: T, transitionStyle: TransitionStyle = .present) {
        
         switch transitionStyle {
        case .present:
             self.present(viewController, animated: true)
        case .presentNavigation:
            let navi = UINavigationController(rootViewController: viewController)
             self.present(navi, animated: true)
        case .presentFullNavigation:
             let nav = UINavigationController(rootViewController: viewController)
             nav.modalPresentationStyle = .fullScreen
             self.present(nav, animated: true)
        case .push:
             self.navigationController?.pushViewController(viewController, animated: true)
        }
        
        
    }
}
