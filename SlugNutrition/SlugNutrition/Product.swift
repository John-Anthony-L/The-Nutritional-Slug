////
////  Product.swift
////  SlugNutrition
////
////  THIS .SWIFT FILE USES CODE PROVIDED BY REDDIT USER europeanwizard
//// https://www.reddit.com/r/swift/comments/8jb5t6/coding_json_where_value_can_be_intdoublestring/
////
////  Created by Roberto Oregon on 07.03.20.
////  Copyright © 2020 Roberto Oregon. All rights reserved.
////
//
//import Foundation
//
//struct ProductResponse:Codable{
//    struct ProductDetail: Codable{
//        let fields:FieldDetail
//        
//        struct FieldDetail: Codable{
//            let item_id:String
//            let item_name:String
//            let brand_name:String
//            let nf_calories:FormFieldValueType
//            let nf_total_fat:FormFieldValueType
//            let nf_total_carbohydrate:FormFieldValueType
//            let nf_protein:FormFieldValueType
//            let nf_serving_weight_grams:FormFieldValueType
//        }
//    }
//    
//    let hits:[ProductDetail]
//}
//
//enum FormFieldValueType: Codable {
//    case i(Int)
//    case s(String)
//    case d(Double)
//    
//    init(from decoder: Decoder) throws {
//        let container = try decoder.singleValueContainer()
//        if let value = try? container.decode(String.self) {
//            self = .s(value)
//        } else if let value = try? container.decode(Double.self) {
//            self = .d(value)
//        } else if let value = try? container.decode(Int.self) {
//            self = .i(value)
//        } else {
//            fatalError()
//        }
//    }
//    
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.singleValueContainer()
//        switch self {
//        case .s(let value):
//            try container.encode(value)
//        case .d(let value):
//            try container.encode(value)
//        case .i(let value):
//            try container.encode(value)
//        }
//    }
//}
