//
//  TrendTableViewCell.swift
//  TrendMedia
//
//  Created by Junhee Yoon on 2022/07/19.
//

import UIKit

class TrendTableViewCell: UITableViewCell {

    // MARK: - Properties
    
    @IBOutlet weak var checkboxButton: UIButton!
    @IBOutlet weak var favouriteButton: UIButton!
    @IBOutlet weak var shoppingListLabel: UILabel!

    
    // MARK: - Helper Functions
    
    func setUI() {
        shoppingListLabel.font = .systemFont(ofSize: 18)
        checkboxButton.tintColor = .black
        favouriteButton.tintColor = .black
    }
}
