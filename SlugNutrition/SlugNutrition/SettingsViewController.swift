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

    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
           return 1
       }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return goalpicker.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return goalpicker[row]
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.goalPickerView.delegate = self
        self.goalPickerView.dataSource = self
        if let savedUserData = UserData.loadFromFile(){
                          userData = savedUserData
                      }
        if let userData = userData{
            nameTextField.text =  userData.name
//            genderSegmentedControl.titleForSegment(at: genderSegmentedControl.selectedSegmentIndex) = userData.gender
            ageTextField.text = String(userData.age)
            heightTextField.text = String(userData.height)
            weightTextField.text = String(userData.weight)
//            goalPickerView.selectedRow(inComponent: 0)= userData.goal
            
        }
       
        updateSaveButtonState()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        reloadInputViews()
    }
    
    func updateSaveButtonState() {
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           super.prepare(for: segue, sender: sender)

           guard segue.identifier == "saveUnwind" else { return }
        let name = nameTextField.text ?? ""
        let gender = genderSegmentedControl.titleForSegment(at: genderSegmentedControl.selectedSegmentIndex) ?? ""
         let age = tointeger(from: ageTextField)
       
             let height = toDouble(from: heightTextField)
            let weight = toDouble(from: weightTextField)
        let goal = goalPickerView.selectedRow(inComponent: 0)
            userData = UserData(name: name,
                            gender: gender,
                            age: age,
                            height: height,
                            weight: weight,
                            goal: goal
                              )
       }
    
    func tointeger(from textField: UITextField) -> Int {
        guard let text = textField.text, let number = Int(text) else {
            return 0
        }
        return number
    }
   func toDouble(from textField: UITextField) -> Double {
       guard let text = textField.text, let number = Double(text) else {
        return 0.0
       }
       return number
   }
    
    
    @IBAction func goButton(_ sender: UIButton) {
        
    }
    
   
        
    

}
