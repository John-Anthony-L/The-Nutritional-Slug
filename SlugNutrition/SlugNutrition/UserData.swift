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
    var activity: Int
    
    var calorieGoal: Double
    var proteinGoal: Double
    var fatGoal: Double
    var carbGoal: Double
    
    init(name: String, gender: String, age: Int, height: Double, weight: Double, goal: Int, activity: Int) {
        self.name = name
        self.gender = gender
        self.age = age
        self.height = height
        self.weight = weight
        self.goal = goal
        self.activity = activity
        
        self.calorieGoal = calculateCalories(w: weight, h: height, a: age, u: activity) // need to round to 10
        self.proteinGoal = calculateProteins(w: weight) // need to round to 5
        self.fatGoal = calculateFats(c: calorieGoal) // need to round to 5
        self.carbGoal = calculateCarbs(c: calorieGoal, f: fatGoal, p: proteinGoal) // need to round to 5
    }
    
    static let DocumentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("userData").appendingPathExtension("plist")
    
    
    static func saveToFile(userData: UserData) {
        let propertyListEncoder = PropertyListEncoder()
        let codedData = try? propertyListEncoder.encode(userData)
        
        try? codedData?.write(to: ArchiveURL, options: .noFileProtection)
    }
    
    static func loadFromFile() -> UserData? {
        guard let codedData = try? Data(contentsOf: ArchiveURL) else { return nil }
        
        let propertyListDecoder = PropertyListDecoder()
        
        return try? propertyListDecoder.decode(UserData.self, from: codedData)
    }
}


/*
func roundToFive(n: Double) -> Double {
  let f = floor(n)
  return f + round((n-f) * 20) / 20
}

func roundToTen(n: Double) -> Double {
  let f = floor(n)
  return f + round((n-f) * 10) / 10
}
*/
func calculateCalories(w: Double, h: Double, a: Int, u: Int ) -> Double {
    //let f = floor(w)
    let x = 10 * (w/2.2046)
    let y = 6.25 * (h * 2.54)
    let z = 5 * a - 161
    let last = u - 200
    return (x + y - Double(z)) * Double(last)
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


