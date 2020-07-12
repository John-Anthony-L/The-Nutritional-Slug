//
//  ProductRequest.swift
//  SlugNutrition
//
//  THIS .SWIFT FILE IS BASED ON THE CODE PROVIDED BY BRIAN ADVENT
// https://www.youtube.com/watch?v=tdxKIPpPDAI
//
//  Created by Roberto Oregon on 07.03.20.
//  Copyright © 2020 Roberto Oregon. All rights reserved.
//

import Foundation

enum ProductError:Error {
    case noDataAvailable
    case canNotProcessData
}

struct ProductRequest {
    let resourceURL:URL
    let APP_ID = "9af5b2b9"
    let API_KEY = "97ac8bd3653616517f0d52cb9a4fc5e3"
    
    init(productSearch:String) {
        
        //let resourceString = "https://api.spoonacular.com/food/products/search?query=\(productSearch)&apiKey=\(API_KEY)"
        let resourceString = "https://api.nutritionix.com/v1_1/search/\(productSearch)?results=0:5&fields=item_name,brand_name,item_id,nf_calories,nf_protein,nf_total_carbohydrate,nf_total_fat,nf_serving_weight_grams&appId=\(APP_ID)&appKey=\(API_KEY)"
        guard let resourceURL = URL(string: resourceString) else {fatalError()}
        
        //print(resourceString)
        self.resourceURL = resourceURL
        
    }
    
    func getProducts (completion: @escaping(Result<ProductResponse, Error>) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: resourceURL) { data, response, error in
            if let error = error { completion(.failure(error));  return }
            
            
            do {
                //print("entered do")
                let productsResponse = try JSONDecoder().decode(ProductResponse.self, from: data!)
                //print("test1")
                //let productDetails = productsResponse.products
                //print("test2")
                completion(.success(productsResponse))
            }catch{
                completion(.failure(error))
            }
        }
        dataTask.resume()
    }
}
