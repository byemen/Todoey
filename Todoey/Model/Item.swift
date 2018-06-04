//
//  Item.swift
//  Todoey
//
//  Created by Joseph on 4/6/18.
//  Copyright © 2018 Joseph. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    @objc dynamic var insertDate : Date?
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
