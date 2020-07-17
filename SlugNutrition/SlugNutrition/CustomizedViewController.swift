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
    
    @IBOutlet var saveButton: UIButton!
    
    var defaultName = ""
    var defaultBrand = ""
    var defaultCarbs = 0
    var defaultFats = 0
    var defaultCals = 0
    var defaultPros = 0
    
    
    var product: MealProducts = MealProducts(item_name: "", brand_name: "", nf_calories: 0.0, nf_total_fat: 0.0, nf_total_carbohydrate: 0.0, nf_protein: 0.0)
    
     override func viewDidLoad() {
         super.viewDidLoad()
        updateSaveButtonState()
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
        product.nf_total_carbohydrate = Double(carbsSlider.value)
         carbsTextField.text = "\(defaultCarbs)"
         let defaults = UserDefaults.standard
         defaults.set(defaultCarbs, forKey: "defaultCarbs")
         defaults.synchronize()
        
     }
    @IBAction func CarbstextFieldDidChange(textField: UITextField) {
        if let stringValue = textField.text{
            if let intValue = Int(stringValue){
                carbsSlider.setValue(Float(intValue), animated: true)
            }
        }
            updateCarbsValue()
    }
     
     func updateFatsValue()
     {
         defaultFats = Int(fatSlider.value)
        product.nf_total_fat = Double(fatSlider.value)
          fatTextField.text = "\(defaultFats)"
          let defaults = UserDefaults.standard
          defaults.set(defaultFats, forKey: "defaultFats")
          defaults.synchronize()
     }
    
    @IBAction func FatstextFieldDidChange(textField: UITextField) {
        if let stringValue = textField.text{
            if let intValue = Int(stringValue){
                fatSlider.setValue(Float(intValue), animated: true)
            }
        }
            updateFatsValue()
    }
     
     func updateCalsValue()
         {
             defaultCals = Int(caloriesSlider.value)
            product.nf_calories = Double(caloriesSlider.value)
              caloriesTextField.text = "\(defaultCals)"
              let defaults = UserDefaults.standard
              defaults.set(defaultCals, forKey: "defaultCals")
              defaults.synchronize()
         }
    
   @IBAction func CalstextFieldDidChange(textField: UITextField) {
           if let stringValue = textField.text{
               if let intValue = Int(stringValue){
                   caloriesSlider.setValue(Float(intValue), animated: true)
               }
           }
               updateCalsValue()
       }

    func updateProsValue()
    {
        defaultPros = Int(proteinSlider.value)
        product.nf_protein = Double(proteinSlider.value)
         proteinTextField.text = "\(defaultPros)"
         let defaults = UserDefaults.standard
         defaults.set(defaultPros, forKey: "defaultPros")
         defaults.synchronize()
    }
    
    @IBAction func ProstextFieldDidChange(textField: UITextField) {
           if let stringValue = textField.text{
               if let intValue = Int(stringValue){
                   proteinSlider.setValue(Float(intValue), animated: true)
               }
           }
               updateProsValue()
       }
    
    @IBAction func textEditingChanged(_sender: UITextField)
       {
           updateSaveButtonState()
            
       }
    
    func updateSaveButtonState() {
           let foodText = nameTextField.text ?? ""
           let brandText = brandTextField.text ?? ""
           saveButton.isEnabled = !foodText.isEmpty && !brandText.isEmpty
        
       }
    
    @IBAction func saveButton(_ sender: UIButton) {
        product.item_name = nameTextField.text ?? ""
        product.brand_name = brandTextField.text ?? ""
        breakfastList.append(product)
    }
    

    
}
