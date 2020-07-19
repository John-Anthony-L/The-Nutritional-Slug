//
//  FoodSearchViewController.swift
//  SlugNutrition
//
//  Created by Vidisha Nevatia on 06/07/20.
//  Copyright © 2020 Roberto Oregon. All rights reserved.
//

import UIKit

var searchedFoodList: [MealProducts] = []

class FoodSearchViewController: UIViewController{
  

    @IBOutlet weak var mealSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var brandALabel: UILabel!
    @IBOutlet weak var brandBLabel: UILabel!
    @IBOutlet weak var brandCLabel: UILabel!
    
    @IBOutlet weak var brandACarbLabel: UILabel!
    @IBOutlet weak var brandAProsLabel: UILabel!
    @IBOutlet weak var brandAFatsLabel: UILabel!
    @IBOutlet weak var brandACalsLabel: UILabel!
    
    @IBOutlet weak var brandBCarbLabel: UILabel!
    @IBOutlet weak var brandBProsLabel: UILabel!
    @IBOutlet weak var brandBFatsLabel: UILabel!
    @IBOutlet weak var brandBCalsLabel: UILabel!
    
    @IBOutlet weak var brandCCarbLabel: UILabel!
    @IBOutlet weak var brandCProsLabel: UILabel!
    @IBOutlet weak var brandCFatsLabel: UILabel!
    @IBOutlet weak var brandCCalsLabel: UILabel!
    
    
    var brandAFood: MealProducts = MealProducts(item_name: "generic", brand_name: "meh", nf_calories: 100.0, nf_total_fat: 100.0, nf_total_carbohydrate: 100.0, nf_protein: 100.0)
    var brandBFood: MealProducts = MealProducts(item_name: "generic", brand_name: "meh", nf_calories: 100.0, nf_total_fat: 100.0, nf_total_carbohydrate: 100.0, nf_protein: 100.0)
    var brandCFood: MealProducts = MealProducts(item_name: "generic", brand_name: "meh", nf_calories: 100.0, nf_total_fat: 100.0, nf_total_carbohydrate: 100.0, nf_protein: 100.0)
    
    var defaultFood:String = ""
    var mealSelected = 0 

    //let meal = ["Breakfast", "Lunch", "Dinner"]
    
    @IBOutlet var foodNameLabel: UILabel!
    /*
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
          return 1
      }
  
      
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
               return meal.count
        }

      
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return meal[row]
    }
 */
      
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.mealPickerView.delegate = self
        //self.mealPickerView.dataSource = self
        
        print(searchedFoodList.count)
        brandACarbLabel.text = String(0)
        brandAFatsLabel.text = String(0)
        brandACalsLabel.text = String(0)
        brandAProsLabel.text = String(0)
        
        brandBCarbLabel.text = String(0)
        brandBFatsLabel.text = String(0)
        brandBCalsLabel.text = String(0)
        brandBProsLabel.text = String(0)
        
        brandCCarbLabel.text = String(0)
        brandCFatsLabel.text = String(0)
        brandCCalsLabel.text = String(0)
        brandCProsLabel.text = String(0)
        
        showBrandResults()
        print(searchedFoodList.count)
        
        
}
    override func viewWillAppear(_ animated: Bool) {
        let defaults = getUserDefaults()
        foodNameLabel.text = defaults.string(forKey:"defaultFood") ?? ""
        showBrandResults()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        UserDefaults.standard.removeObject(forKey: "defaultFood")
        UserDefaults.standard.synchronize()
        foodNameLabel.text = ""
         searchedFoodList = []
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
    
    @IBAction func mealSegmentedControl(_ sender: UISegmentedControl) {
        UserDefaults.standard.set(sender.selectedSegmentIndex, forKey: "defaultMeal")
        UserDefaults.standard.synchronize()
        
        let defaults = UserDefaults.standard
         mealSelected = defaults.integer(forKey: "defaultMeal")
        print("meal int: ",mealSelected)
    }
    
    @IBAction func addToTarget(_ sender: UIButton) {
//        let defaults = UserDefaults.standard
//                mealSelected = defaults.integer(forKey: "defaultMeal")
//               print("mealselected",mealSelected)
               
               
               if mealSelected == 0{
                   print("breakfast")
                   breakfastList.append(searchedFoodList[0])
               }else if mealSelected == 1 {
                   print("lunch")
                   lunchList.append(searchedFoodList[0])
               }else if mealSelected == 2 {
                   print("dinner")
                   dinnerList.append(searchedFoodList[0])
               }
//        let controller:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "customViewController") as UIViewController
//         self.present(controller, animated: true, completion: nil)
    }
    
    
    
    
    func showBrandResults(){
        
        if searchedFoodList.count > 1 {
            brandALabel.text = String(searchedFoodList[0].item_name)
            brandACarbLabel.text = String(searchedFoodList[0].nf_total_carbohydrate)
            brandAFatsLabel.text = String(searchedFoodList[0].nf_total_fat)
            brandACalsLabel.text = String(searchedFoodList[0].nf_calories)
            brandAProsLabel.text = String(searchedFoodList[0].nf_protein)
        }
        if searchedFoodList.count > 2 {
            brandBLabel.text = String(searchedFoodList[1].item_name)
            brandBCarbLabel.text = String(searchedFoodList[1].nf_total_carbohydrate)
            brandBFatsLabel.text = String(searchedFoodList[1].nf_total_fat)
            brandBCalsLabel.text = String(searchedFoodList[1].nf_calories)
            brandBProsLabel.text = String(searchedFoodList[1].nf_protein)
        }
        if searchedFoodList.count > 3 {
            brandCLabel.text = String(searchedFoodList[2].item_name)
            brandCCarbLabel.text = String(searchedFoodList[2].nf_total_carbohydrate)
            brandCFatsLabel.text = String(searchedFoodList[2].nf_total_fat)
            brandCCalsLabel.text = String(searchedFoodList[2].nf_calories)
            brandCProsLabel.text = String(searchedFoodList[2].nf_protein)
        }
    }
    
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "pageTwo") as? UITableViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
          
}
