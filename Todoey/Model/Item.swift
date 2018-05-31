//
//  Item.swift
//  Todoey
//
//  Created by Joseph on 31/5/18.
//  Copyright © 2018 Joseph. All rights reserved.
//

import Foundation

//class Item: Encodable, Decodable {
class Item: Codable {
    var title: String = ""
    var done: Bool = false
}
