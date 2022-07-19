//
//  TrendTableViewCell.swift
//  TrendMedia
//
//  Created by Junhee Yoon on 2022/07/19.
//

import UIKit

class TrendTableViewCell: UITableViewCell {

    @IBOutlet weak var checkboxButton: UIButton! {
        didSet{
            checkboxButton.setImage(UIImage(systemName: "square"), for: .normal)
            checkboxButton.setImage(UIImage(systemName: "checkmark.square"), for: .selected)
        }
    }
    
    
    @IBOutlet weak var favouriteButton: UIButton! {
        didSet{
            favouriteButton.setImage(UIImage(systemName: "star"), for: .normal)
            favouriteButton.setImage(UIImage(systemName: "star.fill"), for: .selected)
        }
    }
    
    
    @IBOutlet weak var shoppingListLabel: UILabel!
    
    
    
    @IBAction func checkboxButtonTapped(_ sender: UIButton) {
        sender.checkboxAnimation {
            print("I'm done")
            //here you can also track the Checked, UnChecked state with sender.isSelected
            print(sender.isSelected)
        }
    }
    
    @IBAction func favouriteButtonTapped(_ sender: UIButton) {
        sender.checkboxAnimation {
            print("I'm done")
            //here you can also track the Checked, UnChecked state with sender.isSelected
            print(sender.isSelected)
        }
    }
    
    
    
    
}
