//
//  Categories.swift
//  MenuTask
//
//  Created by MacBook Pro on 11/18/20.
//  Copyright © 2020 Foodics. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers public class RootCategory: Object, Codable {
    dynamic var data = List<Category>()
    dynamic var links:NavLinks?
}

@objcMembers public class Category: Object, Codable {
    dynamic var id: String = ""
    dynamic var name: String = ""
    dynamic var content:RootProduct?
}


@objcMembers public class NavLinks: Object, Codable {
    dynamic var first: String? = ""
    dynamic var last: String? = ""
    dynamic var next: String? = ""
    dynamic var prev: String? = ""
}
