//
//  CustomizedViewController.swift
//  SlugNutrition
//
//  Created by Vidisha Nevatia on 12/07/20.
//  Copyright © 2020 Roberto Oregon. All rights reserved.
//

import UIKit

class CustomizedViewController: UIViewController {
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var brandTextField: UITextField!
    @IBOutlet var mealSegmentedControl: UISegmentedControl!
    @IBOutlet var carbsTextField: UITextField!
    @IBOutlet var carbsSlider: UISlider!
    @IBOutlet var fatTextField: UITextField!
    @IBOutlet var fatSlider: UISlider!
    @IBOutlet var caloriesTextField: UITextField!
    @IBOutlet var caloriesSlider: UISlider!
    @IBOutlet var proteinTextField: UITextField!
    @IBOutlet var proteinSlider: UISlider!
    
    var defaultName = ""
    var defaultBrand = ""
    var defaultCarbs = 0
    var defaultFats = 0
    var defaultCals = 0
    var defaultPros = 0
    
     override func viewDidLoad() {
         super.viewDidLoad()
     }
     
    
     @IBAction func defaultCarbsChanged(_ sender: UISlider) {
         updateCarbsValue()
     }
     @IBAction func defaultFatsChanged(_ sender: UISlider) {
             updateFatsValue()
         }
    @IBAction func defaultCalsChanged(_ sender: UISlider) {
            updateCalsValue()
        }
    @IBAction func defaultProsChanged(_ sender: UISlider) {
            updateProsValue()
        }
    
     
     func updateCarbsValue()
     {
          defaultCarbs = Int(carbsSlider.value)
         carbsTextField.text = "\(defaultCarbs)"
         let defaults = UserDefaults.standard
         defaults.set(defaultCarbs, forKey: "defaultCarbs")
         defaults.synchronize()
     }
     
     func updateFatsValue()
     {
         defaultFats = Int(fatSlider.value)
          fatTextField.text = "\(defaultFats)"
          let defaults = UserDefaults.standard
          defaults.set(defaultFats, forKey: "defaultFats")
          defaults.synchronize()
     }
     
     func updateCalsValue()
         {
             defaultCals = Int(caloriesSlider.value)
              caloriesTextField.text = "\(defaultCals)"
              let defaults = UserDefaults.standard
              defaults.set(defaultCals, forKey: "defaultCals")
              defaults.synchronize()
         }

    func updateProsValue()
    {
        defaultPros = Int(proteinSlider.value)
         proteinTextField.text = "\(defaultPros)"
         let defaults = UserDefaults.standard
         defaults.set(defaultPros, forKey: "defaultPros")
         defaults.synchronize()
    }
    
}
