//
//  Constants.swift
//  AlacamDem
//
//  Created by Mac on 11/19/18.
//  Copyright © 2018 Mac. All rights reserved.
//
import Foundation
 
var mainPath = "https://api.foodics.dev/v5/"
var cate = "categories"
var pro = "products?include=category"
struct Links  {
    static var categories = "\(mainPath)\(cate)"
    static var products = "\(mainPath)\(pro)" 
}


 
