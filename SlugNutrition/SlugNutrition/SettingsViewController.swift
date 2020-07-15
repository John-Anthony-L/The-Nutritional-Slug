//
//  SettingsViewController.swift
//  SlugNutrition
//
//  Created by Vidisha Nevatia on 06/07/20.
//  Copyright © 2020 Roberto Oregon. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UIPickerViewDelegate,UIPickerViewDataSource {
    
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var genderSegmentedControl: UISegmentedControl!
    @IBOutlet var ageTextField: UITextField!
    @IBOutlet var weightTextField: UITextField!
    @IBOutlet var heightTextField: UITextField!
    @IBOutlet var goalPickerView: UIPickerView!
    @IBOutlet var dailyAcitivityLevelPickerView: UIPickerView!
    
    let goalpicker = ["Maintain", "Muscle Gain","Fat Loss"]
    // Maintain = Calories + 0
    // Muscle Gain = Calories + 300
    // Fat Loss = Calories -300
    
    let activitypicker = ["Sedentary : Little/No exercise",
                          "Average Exercise 1-2 times/week",
                          "Moderate : Exercise 4-5 times/week","High : intense exercise 6-7 times/week",
                          "Very High : very intense exercise daily"]
    // Average = 1.375
    // Sedentary = 1.2
    // Moderate = 1.55
    // High = 1.725
    // Very High = 1.9
    
    @IBOutlet var saveButton: UIButton!
    
    var defaultName:String = ""
    var defaultAge: Int!
    var defaultWeight: Double!
    var defaultHeight: Double!
    var goal:Int = 0
    var activity: Int = 0
    var selected: String = ""
    

    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
           return 1
       }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        var a:Int = 0
        if pickerView == goalPickerView{
           a = goalpicker.count
        }
        else if(pickerView == dailyAcitivityLevelPickerView)
        {
            a = activitypicker.count
        }
        return a
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        var a: String = ""
        if pickerView == goalPickerView{
                  a = goalpicker[row]
               }
               else if(pickerView == dailyAcitivityLevelPickerView)
               {
                   a = activitypicker[row]
               }
        return a
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == goalPickerView{
           UserDefaults.standard.set(row, forKey: "defaultGoal")
           UserDefaults.standard.synchronize()
           goal = row
        }
        else if(pickerView == dailyAcitivityLevelPickerView)
        {
             UserDefaults.standard.set(row, forKey: "defaultActivity")
                      UserDefaults.standard.synchronize()
                      activity = row
        }
    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
         let label = (view as? UILabel) ?? UILabel()
        if pickerView == goalPickerView{
        label.font = UIFont(name: "Times New Roman", size: 20)
            label.textColor = .white
        label.textAlignment = .center
      label.text = goalpicker [row]
   
    }
    else if(pickerView == dailyAcitivityLevelPickerView)
    {
        label.font = UIFont(name: "Times New Roman", size: 18)
         label.textAlignment = .center
        label.textColor = .white
         label.text = activitypicker [row]
                         
                   }
             return label
        }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.goalPickerView.delegate = self
      self.goalPickerView.dataSource = self
        self.dailyAcitivityLevelPickerView.delegate = self
        self.dailyAcitivityLevelPickerView.dataSource = self
        updateSaveButtonState()
    }
    
    
    @IBAction func NameTextFieldChanged(_ sender: UITextField) {
        UserDefaults.standard.set(nameTextField.text, forKey: "defaultName") // saves text field text
        UserDefaults.standard.synchronize()
              
    }
    
    @IBAction func genderSegmentedControlChanged(_ sender: UISegmentedControl) {
        UserDefaults.standard.set(sender.selectedSegmentIndex, forKey: "defaultGender")
    }
    
    @IBAction func ageTextFieldChanged(_ sender: UITextField) {
        let age:Int = tointeger(from: ageTextField)
        UserDefaults.standard.set(age, forKey: "defaultAge")// saves text field text
        UserDefaults.standard.synchronize()
    }
    @IBAction func weightTextFieldChanged(_ sender: UITextField) {
        
             let weight:Double = toDouble(from: weightTextField)
                   UserDefaults.standard.set(weight, forKey: "defaultWeight") // saves text field text
                   UserDefaults.standard.synchronize()
        
      
    }
    
    
    @IBAction func heightTextFieldChanged(_ sender: UITextField) {
       
             let height: Double = toDouble(from: heightTextField)
            UserDefaults.standard.set(height, forKey: "defaultHeight") // saves text field text
                   UserDefaults.standard.synchronize()
       
       
       
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        nameTextField.text = UserDefaults.standard.string(forKey:"defaultName")
        genderSegmentedControl.selectedSegmentIndex = UserDefaults.standard.integer(forKey: "defaultGender")
     
        ageTextField.text =  String(UserDefaults.standard.integer(forKey:"defaultAge"))
        
        weightTextField.text =  String(UserDefaults.standard.double(forKey:"defaultWeight"))
        
        heightTextField.text =  String(UserDefaults.standard.double(forKey: "defaultHeight"))
        goal = UserDefaults.standard.integer(forKey: "defaultGoal")
        self.goalPickerView.selectRow(goal, inComponent: 0, animated: true)
        activity = UserDefaults.standard.integer(forKey: "defaultActivity")
        self.dailyAcitivityLevelPickerView.selectRow(Int(activity), inComponent: 0, animated: true)
        }
    
    @IBAction func clearBarButtonPressed(_ sender: UIBarButtonItem) {
        if let bundleID = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: bundleID)
        }
        UserDefaults.standard.synchronize()
        viewWillAppear(true)
    }
    
    func updateSaveButtonState()
    {
        let name = nameTextField.text ?? ""
        let age = ageTextField.text ?? ""
        let height = heightTextField.text ?? ""
        let weight = weightTextField.text ?? ""
        saveButton.isEnabled = !name.isEmpty && !age.isEmpty && !height.isEmpty && !weight.isEmpty
    }
    
   @IBAction func textEditingChanged(_sender: UITextField)
      {
          updateSaveButtonState()
      }
    
    func tointeger(from textField: UITextField) -> Int
    {
        guard let text = textField.text, let number = Int(text) else
        {
            return 0
        }
        return number
    }
    
   func toDouble(from textField: UITextField) -> Double
   {
       guard let text = textField.text, let number = Double(text) else
       {
        return 0.0
       }
       return number
   }
    
    @IBAction func saveButton(_ sender: Any) {
}
}
