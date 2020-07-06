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
    let goalpicker = ["To shred some weight", "To gain weight","To become stronger"]
    
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

        // Do any additional setup after loading the view.
    }
   
    
   
    
    
    @IBAction func goButton(_ sender: UIButton) {
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
