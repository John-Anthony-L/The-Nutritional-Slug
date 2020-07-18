//
//  FoodSearchViewController.swift
//  SlugNutrition
//
//  Created by Vidisha Nevatia on 06/07/20.
//  Copyright © 2020 Roberto Oregon. All rights reserved.
//

import UIKit

class FoodSearchViewController: UIViewController, UIPickerViewDelegate,UIPickerViewDataSource{
  

    @IBOutlet var mealPickerView: UIPickerView!
    var defaultFood:String = ""

    let meal = ["Breakfast", "Lunch", "Dinner"]
    
    @IBOutlet var foodNameLabel: UILabel!
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
          return 1
      }
  
      
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
               return meal.count
        }

      
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return meal[row]
    }
      
    
      
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mealPickerView.delegate = self
        self.mealPickerView.dataSource = self
}
    override func viewWillAppear(_ animated: Bool) {
        let defaults = getUserDefaults()
        foodNameLabel.text = defaults.string(forKey:"defaultFood") ?? ""
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        UserDefaults.standard.removeObject(forKey: "defaultFood")
        UserDefaults.standard.synchronize()
        foodNameLabel.text = ""
    }
    
          func getUserDefaults() -> UserDefaults {
              let defaults = UserDefaults.standard
              if (defaults.object(forKey: "defaultFood") == nil) {
                     // set initial defaults
                  defaults.set(defaultFood, forKey: "defaultFood")
                     defaults.synchronize()
                 }
                 return defaults
             }
          
}
