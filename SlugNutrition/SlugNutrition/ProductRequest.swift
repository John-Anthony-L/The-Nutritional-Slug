////
////  ProductRequest.swift
////  SlugNutrition
////
////  THIS .SWIFT FILE IS BASED ON THE CODE PROVIDED BY BRIAN ADVENT
//// https://www.youtube.com/watch?v=tdxKIPpPDAI
////
////  Created by Roberto Oregon on 07.03.20.
////  Copyright © 2020 Roberto Oregon. All rights reserved.
////
//
<<<<<<< HEAD
//  ProductRequest.swift
//  SlugNutrition
//
//
//  Created by Roberto Oregon on 07.03.20.
//  Copyright © 2020 Roberto Oregon. All rights reserved.
//

import Foundation

enum ProductError:Error {
    case noDataAvailable
    case canNotProcessData
}

var csvRows = [[String]]()




func readDataFromCSV(fileName:String, fileType: String)-> String!{
        guard let filepath = Bundle.main.path(forResource: fileName, ofType: fileType)
            else {
                return nil
        }
        do {
            var contents = try String(contentsOfFile: filepath, encoding: .utf8)
            contents = cleanRows(file: contents)
            return contents
        } catch {
            print("File Read Error for file \(filepath)")
            return nil
        }
    }


func cleanRows(file:String)->String{
    var cleanFile = file
    cleanFile = cleanFile.replacingOccurrences(of: "\r", with: "\n")
    cleanFile = cleanFile.replacingOccurrences(of: "\n\n", with: "\n")
    //        cleanFile = cleanFile.replacingOccurrences(of: ";;", with: "")
    //        cleanFile = cleanFile.replacingOccurrences(of: ";\n", with: "")
    return cleanFile
}

func csv(data: String) -> [[String]] {
    var result: [[String]] = []
    let rows = data.components(separatedBy: "\n")
    for row in rows {
        let columns = row.components(separatedBy: ";")
        result.append(columns)
    }
    return result
}



struct ProductRequest {

//
    
    init(productSearch:String){
        var product_data = readDataFromCSV(fileName: ("products"), fileType: "csv")
        product_data = cleanRows(file: product_data!)
        csvRows = csv(data: product_data!)
        var products = [String]()

        print(csvRows)
        for rows in csvRows{
          if rows[0].contains(productSearch){
                print(rows)
                products.append(rows[0])
                print("==================")
        }
    }
    
}
}
=======
//import Foundation
//
//enum ProductError:Error {
//    case noDataAvailable
//    case canNotProcessData
//}
//
//struct ProductRequest {
//    let resourceURL:URL
//    var products = [String]()
//    let APP_ID = "9af5b2b9"
//    let API_KEY = "97ac8bd3653616517f0d52cb9a4fc5e3"
////
//
////    init(productSearch:String){
////        var product_data = readDataFromCSV(fileName: ("products"), fileType: "csv")
////                   product_data = cleanRows(file: product_data!)
////        var csvRows = csv(data: product_data!)
////
////    }
////
////
//
//    init(productSearch:String) {
//
//        //let resourceString = "https://api.spoonacular.com/food/products/search?query=\(productSearch)&apiKey=\(API_KEY)"
//        let resourceString = "https://api.nutritionix.com/v1_1/search/\(productSearch)?results=0:5&fields=item_name,brand_name,item_id,nf_calories,nf_protein,nf_total_carbohydrate,nf_total_fat,nf_serving_weight_grams&appId=\(APP_ID)&appKey=\(API_KEY)"
//        guard let resourceURL = URL(string: resourceString) else {fatalError()}
//
//
//        //print(resourceString)
//        self.resourceURL = resourceURL
//
//        var product_data = readDataFromCSV(fileName: ("products"), fileType: "csv")
//        product_data = cleanRows(file: product_data!)
//        let csvRows = csv(data: product_data!)
//
////        let temp = "STOUFFERS Classics Meal Salisbury Steak - 9.625 Oz,360,  17g,  2g,  23g"
////        if temp.contains(productSearch){
////            print(temp)
////
////        }
//        print(csvRows)
//        for rows in csvRows{
//            if rows[0].contains(productSearch){
//                print(rows[0])
//                products.append(rows[0])
//                print("-------------------------")
//            }
//        }
//
//    }
//
//    func getProducts (completion: @escaping(Result<ProductResponse, Error>) -> Void) {
//        let dataTask = URLSession.shared.dataTask(with: resourceURL) { data, response, error in
//            if let error = error { completion(.failure(error));  return }
//
//
//            do {
//                let productsResponse = try JSONDecoder().decode(ProductResponse.self, from: data!)
//                completion(.success(productsResponse))
//            }catch{
//                completion(.failure(error))
//            }
//        }
//        dataTask.resume()
//    }
////    func getProducts (completion: @escaping(Result<ProductResponse, Error>) -> Void) {
////
////
//////            for rows in csvRows{
//////                print(rows)
//////            }
////            // print(csvRows)
////
////            do {
////                //print("entered do")
////                let productsResponse =
////                //print("test1")
////                //let productDetails = productsResponse.products
////                //print("test2")
////                print(productsResponse)
////                completion(.success(productsResponse))
////            }catch{
////                completion(.failure(error))
////            }
////        }
////    }
//
//
//func readDataFromCSV(fileName:String, fileType: String)-> String!{
//        guard let filepath = Bundle.main.path(forResource: fileName, ofType: fileType)
//            else {
//                return nil
//        }
//        do {
//            var contents = try String(contentsOfFile: filepath, encoding: .utf8)
//            contents = cleanRows(file: contents)
//            return contents
//        } catch {
//            print("File Read Error for file \(filepath)")
//            return nil
//        }
//    }
//
//
//func cleanRows(file:String)->String{
//    var cleanFile = file
//    cleanFile = cleanFile.replacingOccurrences(of: "\r", with: "\n")
//    cleanFile = cleanFile.replacingOccurrences(of: "\n\n", with: "\n")
//    //        cleanFile = cleanFile.replacingOccurrences(of: ";;", with: "")
//    //        cleanFile = cleanFile.replacingOccurrences(of: ";\n", with: "")
//    return cleanFile
//}
//
//func csv(data: String) -> [[String]] {
//    var result: [[String]] = []
//    let rows = data.components(separatedBy: "\n")
//    for row in rows {
//        let columns = row.components(separatedBy: ";")
//        result.append(columns)
//    }
//    return result
//}
//
//
//}
>>>>>>> 73943744c499e18115a6cc12b2446f6d0042a94b
