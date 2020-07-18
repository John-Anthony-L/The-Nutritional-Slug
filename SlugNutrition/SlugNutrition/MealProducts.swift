//
//  MealProducts.swift
//  SlugNutrition
//
//  Created by Roberto on 7/15/20.
//  Copyright © 2020 Roberto Oregon. All rights reserved.


import Foundation

struct MealProducts:Codable{

    var item_name:String
    var brand_name:String
    var nf_calories:Double
    var nf_total_fat:Double
    var nf_total_carbohydrate:Double
    var nf_protein:Double

    
    init(Search: String) {
        var product_data = readDataFromCSV(fileName: ("products"), fileType: "csv")
        product_data = cleanRows(file: product_data!)
        let csvRows = csv(data: product_data!)
        
        print(csvRows)
               for rows in csvRows{
                   if rows[0].contains(productSearch){
                       print(rows[0])
                       products.append(rows[0])
                       print("-------------------------")
                   }
               }
    }
    
    
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

    
}
