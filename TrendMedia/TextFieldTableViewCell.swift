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
    
    var actionBlock: (() -> Void)? = nil
    
    @IBAction func shoppingTextFieldFilled(_ sender: UITextField) {
        actionBlock?()

    }

    @IBAction func addButtonTapped(_ sender: UIButton) {
        actionBlock?()
    }
}
