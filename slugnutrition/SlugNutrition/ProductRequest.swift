//
//  ProductRequest.swift
//  SlugNutrition
//
//  THIS APP IS BASED ON THE CODE PROVIDED BY BRIAN ADVENT
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
    let API_KEY = "3954daf7ed03476db8320da92fe83b61"
    
    init(productSearch:String) {
        
        let resourceString = "https://api.spoonacular.com/food/products/search?query=\(productSearch)&apiKey=\(API_KEY)"
        guard let resourceURL = URL(string: resourceString) else {fatalError()}
        
        print(resourceString)
        self.resourceURL = resourceURL
        
    }
    
    func getProducts (completion: @escaping(Result<[ProductDetail], ProductError>) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: resourceURL) { data, _, _ in
            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
                return
            }

            print(jsonData)
            print("test")
            do {
                let decoder = JSONDecoder()
                
                let productsResponse = try decoder.decode(ProductResponse.self, from: jsonData)
                print("test2")
                let productDetails = productsResponse.products
                print("test3")
                completion(.success(productDetails))
            }catch{
                completion(.failure(.canNotProcessData))
            }
            
        }
        dataTask.resume()
    }
    
    
    
}
