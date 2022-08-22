//
//  TextFieldTableViewCell.swift
//  TrendMedia
//
//  Created by Junhee Yoon on 2022/07/19.
//

import UIKit

class TextFieldTableViewCell: UITableViewCell {
    
    @IBOutlet weak var shoppingTextField: UITextField!
    
    @IBOutlet weak var addButton: UIButton!
    
    var addButtonAction: (() -> Void)?
    var textFiledAction: (() -> Void)?
    
    @IBAction func shoppingTextFieldFilled(_ sender: UITextField) {
        textFiledAction?()

    }

    @IBAction func addButtonTapped(_ sender: UIButton) {
        addButtonAction?()
    }
    
    func setUI() {
        addButton.setTitle("추가", for: .normal)
        addButton.clipsToBounds = true
        addButton.layer.cornerRadius = 3
        addButton.backgroundColor = .systemGray4
        addButton.setTitleColor(.black, for: .normal)
        
        shoppingTextField.placeholder = "무엇을 구매하실 건가요?"
        shoppingTextField.backgroundColor = .systemGray5
        shoppingTextField.borderStyle = .none
    }
}
