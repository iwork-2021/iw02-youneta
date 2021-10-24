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
    var editFlag:Bool = false

    override init() {
        super.init()
    }
}
