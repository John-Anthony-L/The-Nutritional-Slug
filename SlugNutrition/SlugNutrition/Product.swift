//
//  Product.swift
//  SlugNutrition
//
//  THIS .SWIFT FILE IS BASED ON THE CODE PROVIDED BY BRIAN ADVENT
// https://www.youtube.com/watch?v=tdxKIPpPDAI
//
//  Created by Roberto Oregon on 07.03.20.
//  Copyright © 2020 Roberto Oregon. All rights reserved.
//

import Foundation
/*
struct ProductResponse:Decodable {
    var products:[ProductDetail]
}

struct ProductDetail:Decodable {
    var id:String
    var title:String
}
*/

struct ProductResponse:Codable{
    struct ProductDetail: Codable{
        let id: Int
        let title:String
    }
    let products:[ProductDetail]
}
