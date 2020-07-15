//
//  FoodSearchViewController.swift
//  SlugNutrition
//
//  Created by Vidisha Nevatia on 06/07/20.
//  Copyright © 2020 Roberto Oregon. All rights reserved.
//

import UIKit

class FoodSearchViewController: UIViewController, UIPickerViewDelegate,UIPickerViewDataSource {
  

    @IBOutlet var mealPickerView: UIPickerView!
//    @IBOutlet var goalPicker: UIPickerView!
//     let goalpicker = ["To shred some weight", "To gain weight","To become stronger"]
    let meal = ["Breakfast", "Lunch", "Dinner"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
          return 1
      }
      
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
               return meal.count
        }
//           } else {
//               return goalpicker.count
//           }
      
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return meal[row]

//        else {
//            return goalpicker[row]
        
    }
      
    
      
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.goalPicker.delegate = self
//        self.goalPicker.dataSource = self
        self.mealPickerView.delegate = self
        self.mealPickerView.dataSource = self

        // Do any additional setup after loading the view.
    }
    

}
