//
//  userData.swift
//  SlugNutrition
//
//  Created by Vidisha Nevatia on 06/07/20.
//  Copyright © 2020 Roberto Oregon. All rights reserved.
//

import Foundation
struct UserData: Codable {
    var name: String
    var gender: String
    var age: Int
    var height: Double
    var weight: Double
    var goal: Int
    var activity: Double
    
    var calorieGoal: Double
    var proteinGoal: Double
    var fatGoal: Double
    var carbGoal: Double
    
    init(name: String, gender: String, age: Int, height: Double, weight: Double, goal: Int, activity: Double) {
        self.name = name
        self.gender = gender
        self.age = age
        self.height = height
        self.weight = weight
        self.goal = goal
        self.activity = activity
        
        self.calorieGoal = calculateCalories(s: gender, w: weight, h: height, a: age, g: goal, u: activity) // need to round to 10
        self.proteinGoal = calculateProteins(w: weight) // need to round to 5
        self.fatGoal = calculateFats(c: calorieGoal) // need to round to 5
        self.carbGoal = calculateCarbs(c: calorieGoal, f: fatGoal, p: proteinGoal) // need to round to 5
        //print("test")
    }
    
//    static let DocumentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
//
//    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("userData").appendingPathExtension("plist")
//
//
//    static func saveToFile(userData: UserData) {
//        let propertyListEncoder = PropertyListEncoder()
//        let codedData = try? propertyListEncoder.encode(userData)
//
//        try? codedData?.write(to: ArchiveURL, options: .noFileProtection)
//    }
//
//    static func loadFromFile() -> UserData? {
//        guard let codedData = try? Data(contentsOf: ArchiveURL) else { return nil }
//
//        let propertyListDecoder = PropertyListDecoder()
//        print("test")
//
//        return try? propertyListDecoder.decode(UserData.self, from: codedData)
//    }
//}


func calculateCalories(s: String, w: Double, h: Double, a: Int, g: Int, u: Double ) -> Double {
    //let f = floor(w)
    let x = 10 * (w / 2.2046)
    let y = 6.25 * (h * 2.54)
    let z = (5 * a)
    if s == "male" {
        return ((x + y - Double(z) + 5) * u - 200) + Double(g)
    }
    else {
        return ((x + y - Double(z) - 161) * u - 200) + Double(g)
    }
}

func calculateProteins(w: Double ) -> Double {
    //let f = floor(w)
    let x = w * 0.9
    return x
}

func calculateFats(c: Double ) -> Double {
    //let f = floor(w)
    let x = 0.25 * c / 9
    return x
}

func calculateCarbs(c: Double, f: Double, p: Double) -> Double {
    let x = (c - 9 * f - 4 * p) / 4
    return x
}

}
