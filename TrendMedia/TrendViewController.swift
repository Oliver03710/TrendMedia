//
//  TrendViewController.swift
//  TrendMedia
//
//  Created by Junhee Yoon on 2022/07/19.
//

import UIKit

class TrendViewController: UIViewController {

    // MARK: - Properties
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var checkboxButton: UIButton! {
        didSet{
            checkboxButton.setImage(UIImage(systemName: "square"), for: .normal)
            checkboxButton.setImage(UIImage(systemName: "checkmark.square"), for: .selected)
        }
    }
    
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setBackgroundColor()
        searchTextField.borderColor()
    }
    
    
    // MARK: - Helper Functions
    

    // MARK: - IBActions
    
    @IBAction func checkbox(_ sender: UIButton){
           sender.checkboxAnimation {
               print("I'm done")
               //here you can also track the Checked, UnChecked state with sender.isSelected
               print(sender.isSelected)
               
           }
   }

}
