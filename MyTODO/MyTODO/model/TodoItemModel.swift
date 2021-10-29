//
//  TodoItemModel.swift
//  MyTODO
//
//  Created by nju on 2021/10/15.
//

import UIKit

class TodoItemModel: NSObject {
    var itemName : String?
    var date : Date?
    var check : Bool?
    var itemDescription : String?

    override init() {
        super.init()
    }
    
    init(name: String, date: Date, check: Bool, description: String) {
        self.itemName = name
        self.date = date
        self.check = check
        self.itemDescription = description
    }
}
