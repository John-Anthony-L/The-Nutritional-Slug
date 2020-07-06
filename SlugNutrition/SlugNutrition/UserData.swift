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
    
    init(name: String, gender: String, age: Int, height: Double, weight: Double, goal: Int) {
        self.name = name
        self.gender = gender
        self.age = age
        self.height = height
        self.weight = weight
        self.goal = goal
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


