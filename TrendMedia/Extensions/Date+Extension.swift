//
//  Date+Extension.swift
//  TrendMedia
//
//  Created by Junhee Yoon on 2022/08/24.
//

import UIKit

extension Date {
    
    func toString(withFormat format: String = "yyyy_MM_dd_HH:mm") -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = .current
        dateFormatter.timeZone = .current
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.dateFormat = format
        let str = dateFormatter.string(from: self)
        
        return str
    }
    
}
