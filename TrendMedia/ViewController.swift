//
//  ViewController.swift
//  TrendMedia
//
//  Created by Junhee Yoon on 2022/07/18.
//

import UIKit

class ViewController: UIViewController {

    // 언제 아웃렛컬렉션을 사용하는 게 좋을까?
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var date2Label: UILabel!
    
    @IBOutlet var dateLabelCollection: [UILabel]!
    
    let format = DateFormatter()
    
    @IBOutlet weak var viewLeadingConstraint: NSLayoutConstraint!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureLabelDesign()
        
        format.dateFormat = "yyyy/MM/dd"
        
        viewLeadingConstraint.constant = 120
    }

    func configureLabelDesign() {
        // 1. Outlet Collection (ex. UIView)
        for i in dateLabelCollection {
            i.font = .boldSystemFont(ofSize: 20)
            i.textColor = .brown
            print(i)
        }
        
        dateLabelCollection[0].text = "첫번째 텍스트"
        dateLabelCollection[1].text = "두번째 텍스트"
        
        // 2. UILabel
        let labelArray = [dateLabel, date2Label]
        for i in labelArray {
            i?.font = .boldSystemFont(ofSize: 20)
            i?.textColor = .brown
        }
        
        dateLabel.text = "첫번째 텍스트"
        date2Label.text = "두번째 텍스트"
        
    }
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        
        dateLabel.text = format.string(from: sender.date)
    }
    

}

