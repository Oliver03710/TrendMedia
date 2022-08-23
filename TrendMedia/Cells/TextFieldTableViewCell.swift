//
//  TextFieldTableViewCell.swift
//  TrendMedia
//
//  Created by Junhee Yoon on 2022/07/19.
//

import UIKit

class TextFieldTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    @IBOutlet weak var shoppingTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var sortButton: UIButton!
    
    var addButtonAction: (() -> Void)?
    var textFiledAction: (() -> Void)?
    var reloadAction: (() -> Void)?
    
    
    // MARK: - IBActions
    
    @IBAction func shoppingTextFieldFilled(_ sender: UITextField) {
        textFiledAction?()

    }

    @IBAction func addButtonTapped(_ sender: UIButton) {
        addButtonAction?()
    }
    
    @IBAction func sortButtonTapped(_ sender: UIButton) {
        reloadAction?()
    }
    
    
    // MARK: - Helper Functions
    
    func setUI() {
        addButton.setTitle("추가", for: .normal)
        addButton.clipsToBounds = true
        addButton.layer.cornerRadius = 3
        addButton.backgroundColor = .systemGray4
        addButton.setTitleColor(.black, for: .normal)
        
        sortButton.setTitle("정렬", for: .normal)
        sortButton.clipsToBounds = true
        sortButton.layer.cornerRadius = 3
        sortButton.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        sortButton.setTitleColor(.black, for: .normal)
        
        shoppingTextField.placeholder = "무엇을 구매하실 건가요?"
        shoppingTextField.backgroundColor = .systemGray5
        shoppingTextField.borderStyle = .none
    }
    
}
