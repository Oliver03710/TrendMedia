//
//  RealmModel.swift
//  TrendMedia
//
//  Created by Junhee Yoon on 2022/08/22.
//

import Foundation
import RealmSwift

class ShoppingList: Object {
    
    @Persisted var checkButton: Bool
    @Persisted var contents: String
    @Persisted var favouriteButton: Bool
    @Persisted var registeredDate = Date()
    
    @Persisted(primaryKey: true) var objectId: ObjectId
    
    convenience init(contents: String, registeredDate: Date) {
        self.init()
        self.checkButton = false
        self.contents = contents
        self.favouriteButton = false
        self.registeredDate = registeredDate
    }
 
}
