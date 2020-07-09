//
//  SettingsViewController.swift
//  SlugNutrition
//
//  Created by Vidisha Nevatia on 06/07/20.
//  Copyright © 2020 Roberto Oregon. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UIPickerViewDelegate,UIPickerViewDataSource {
    
    
    var userData: UserData?
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var genderSegmentedControl: UISegmentedControl!
    @IBOutlet var ageTextField: UITextField!
    @IBOutlet var weightTextField: UITextField!
    @IBOutlet var heightTextField: UITextField!
    @IBOutlet var goalPickerView: UIPickerView!
    let goalpicker = ["To shred some weight", "To gain weight","To become stronger"]
    
    @IBOutlet var saveButton: UIButton!
    var defaultName:NSString = ""
    var defaultAge: NSString = ""
    var defaultWeight: NSString = ""
    var defaultHeight: NSString = ""
    var goal:Int = 0
    var selected: NSString = ""

    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
           return 1
       }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return goalpicker.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return goalpicker[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
           UserDefaults.standard.set(goalpicker[row], forKey: "defaultGoal")
        UserDefaults.standard.synchronize()
        goal = row
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.goalPickerView.delegate = self
        self.goalPickerView.dataSource = self
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
        UserDefaults.standard.set(ageTextField.text, forKey: "defaultAge") // saves text field text
        UserDefaults.standard.synchronize()
        
    }
    @IBAction func weightTextFieldChanged(_ sender: UITextField) {
        UserDefaults.standard.set(weightTextField.text, forKey: "defaultWeight") // saves text field text
        UserDefaults.standard.synchronize()
    }
    
    
    @IBAction func heightTextFieldChanged(_ sender: UITextField) {
        UserDefaults.standard.set(heightTextField.text, forKey: "defaultHeight") // saves text field text
        UserDefaults.standard.synchronize()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        nameTextField.text = UserDefaults.standard.value(forKey:"defaultName") as? String
        genderSegmentedControl.selectedSegmentIndex = UserDefaults.standard.integer(forKey: "defaultGender")
        ageTextField.text = UserDefaults.standard.value(forKey:"defaultAge") as? String
        weightTextField.text = UserDefaults.standard.value(forKey:"defaultWeight") as? String
        heightTextField.text = UserDefaults.standard.value(forKey: "defaultHeight") as? String
        self.goalPickerView.selectRow(goal, inComponent: 0, animated: true)
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
