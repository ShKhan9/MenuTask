//
//  Product.swift
//  MenuTask
//
//  Created by MacBook Pro on 11/18/20.
//  Copyright © 2020 Foodics. All rights reserved.
//

import Foundation
import RealmSwift
@objcMembers public class RootProduct: Object, Codable {
    dynamic var data = List<ProductModel>()
    dynamic var links:NavLinks?
}

@objcMembers public class ProductModel: Object, Codable {
    dynamic var id: String = ""
    dynamic var name: String = ""
    dynamic var image: String? = ""
    dynamic var price: Int = 0
}
