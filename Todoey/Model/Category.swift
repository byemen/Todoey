//
//  Category.swift
//  Todoey
//
//  Created by Joseph on 4/6/18.
//  Copyright © 2018 Joseph. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    let items = List<Item>()
}
