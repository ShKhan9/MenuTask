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
}
 
@objcMembers public class Category: Object, Codable {
    
     dynamic var id: String = ""
     dynamic var name: String = ""
     dynamic var content = List<ProductModel>()

  public convenience required init(from decoder: Decoder) throws {
    self.init()
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.id = try container.decode(String.self, forKey: .id)
    self.name = try container.decode(String.self, forKey: .name)
    if let workingArray = try container.decodeIfPresent(Array<ProductModel>.self, forKey: .content)
    {
        content.append(objectsIn: workingArray)
    }
    else {
        
        
    }
  }
}
