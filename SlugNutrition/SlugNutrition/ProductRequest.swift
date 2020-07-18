//
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
