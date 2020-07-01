//
//  Product.swift
//  slugnutrition
//
//  Created by Roberto on 7/1/20.
//  Copyright © 2020 Roberto. All rights reserved.
//

import Foundation

struct ProductsResponse:Decodable{
    var response:Products
}

struct Products:Decodable{
    var products:[ProductDetail]
}

struct ProductDetail:Decodable {
    var name:String
    var date:DateInfo
}

struct DateInfo:Decodable {
    var iso:String
}
