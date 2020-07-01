//
//  ProductRequest.swift
//  slugnutrition
//
//  Created by Roberto on 7/1/20.
//  Copyright © 2020 Roberto. All rights reserved.
//

import Foundation

enum ProductError:Error{
    case noDataAvailable
    case canNotProcessData
}
struct ProductRequest {
    let resourceURL:URL
    let API_KEY2 = "3954daf7ed03476db8320da92fe83b61"
    let API_KEY = "08de5518f568fd9cc2c27b447e0ec202024168e8"
    
    init(productSearch:String){
        
        /*let resourceString = "https://api.spoonacular.com/food/products/search?query=\(productSearch)&apiKey=\(API_KEY)&includeNutrition=true"*/
        let resourceString =
        "https://calendarific.com/api/v2/holidays?&api_key=\(API_KEY)&country=\(productSearch)&year=2019"
        guard let resourceURL = URL(string: resourceString) else {fatalError()}
        
        self.resourceURL = resourceURL
        
    }
    
    func getProducts (completion: @escaping(Result<[ProductDetail],ProductError>) -> Void){
        let dataTask = URLSession.shared.dataTask(with: resourceURL) { data, _, _ in
            guard let jsonData = data else{
                completion(.failure(.noDataAvailable))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let productResponse = try decoder.decode(ProductsResponse.self, from: jsonData)
                let productDetails = productResponse.response.products
                completion(.success(productDetails))
            }catch{
                completion(.failure(.canNotProcessData))
            }
        }
        dataTask.resume()
        
    }
}
