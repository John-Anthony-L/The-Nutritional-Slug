//
//  customViewController.swift
//  SlugNutrition
//
//  Created by Roberto on 7/5/20.
//  Copyright © 2020 Roberto Oregon. All rights reserved.
//

import UIKit

var breakfastList: [MealProducts] = []
var lunchList: [MealProducts] = []
var dinnerList: [MealProducts] = []

class customViewController: UIViewController {

    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet weak var CarbsDailyProgress: UIProgressView!
    @IBOutlet weak var FatsDailyProgress: UIProgressView!
    @IBOutlet weak var ProteinDailyProgress: UIProgressView!
    @IBOutlet weak var CaloriesDailyProgress: UIProgressView!
    
    @IBOutlet weak var caloriesLabel: UILabel!
    @IBOutlet weak var proteinLabel: UILabel!
    @IBOutlet weak var fatsLabel: UILabel!
    @IBOutlet weak var carbsLabel: UILabel!
    
    var proteinProgress:Float = 1.0
    var carbsProgress:Float = 0.0
    var fatsProgress:Float = 0.0
    var calProgress:Float = 0.0
    
    var defaultName:String = ""
    var defaultGenderIndex:Int = 0
    var defaultAge: Int = 0
    var defaultWeight: Double = 0.0
    var defaultHeight: Double = 0.0
    var defaultGoalRow:Int = 0
    var defaultActivityRow: Int = 0
    var selected: String = ""
    var cals:Double = 0.0
    var carbs:Double = 0.0
    var fat:Double = 0.0
    var pros:Double = 0.0
    let controller:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SettingsViewController") as UIViewController
    
    
    @IBOutlet weak var breakfastProducts: UILabel!
    @IBOutlet weak var lunchProducts: UILabel!
    @IBOutlet weak var dinnerProducts: UILabel!
    
    var product1: MealProducts = MealProducts(item_name: "generic", brand_name: "meh", nf_calories: 100.0, nf_total_fat: 100.0, nf_total_carbohydrate: 100.0, nf_protein: 100.0)
    var breakfastResult = ""
    var lunchResult = ""
    var dinnerResult = ""
    
    
    func calculateCalories(sex: Int, weight: Double, height: Double, age: Int, goal: Int, userActivity: Double ) -> Double {
        let x = 10 * (weight / 2.2046)
        let y = 6.25 * (height * 2.54)
        let z = (5 * age)
        if sex == 0 {
            return ((x + y - Double(z) + 5) * userActivity - 200) + Double(goal)
        }
        else {
            return ((x + y - Double(z) - 161) * userActivity - 200) + Double(goal)
        }
    }

    func calculateProteins(weight: Double ) -> Double {
        //let f = floor(w)
        let x = weight * 0.9
        return x
    }

    func calculateFats(calorieGoal: Double ) -> Double {
        //let f = floor(w)
        let x = 0.25 * calorieGoal / 9
        return x
    }

    func calculateCarbs(calorieGoal: Double, fatsGoal: Double, proteinGoal: Double) -> Double {
        let x = (calorieGoal - 9 * fatsGoal - 4 * proteinGoal) / 4
        return x
    }
    
    func incrementProgress(pros: Double){
        for products in breakfastList {
            proteinProgress = proteinProgress + Float(products.nf_protein)
            carbsProgress = carbsProgress + Float(products.nf_total_carbohydrate)
            fatsProgress = fatsProgress + Float(products.nf_total_fat)
            calProgress = calProgress + Float(products.nf_calories)
        }
        for products in lunchList {
            proteinProgress = proteinProgress + Float(products.nf_protein)
            carbsProgress = carbsProgress + Float(products.nf_total_carbohydrate)
            fatsProgress = fatsProgress + Float(products.nf_total_fat)
            calProgress = calProgress + Float(products.nf_calories)
        }
        for products in dinnerList {
            proteinProgress = proteinProgress + Float(products.nf_protein)
            carbsProgress = carbsProgress + Float(products.nf_total_carbohydrate)
            fatsProgress = fatsProgress + Float(products.nf_total_fat)
            calProgress = calProgress + Float(products.nf_calories)
        }
        
        proteinProgress = proteinProgress / Float(pros)
        carbsProgress = carbsProgress / Float(carbs)
        fatsProgress = fatsProgress / Float(fat)
        calProgress = calProgress / Float(cals)
        
        ProteinDailyProgress.progress = proteinProgress
        CarbsDailyProgress.progress = carbsProgress
        FatsDailyProgress.progress = fatsProgress
        CaloriesDailyProgress.progress = calProgress
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = getUserDefaults()
        defaultName = defaults.string(forKey:"defaultName") ?? ""
        defaultGenderIndex = defaults.integer(forKey: "defaultGender")
        defaultAge = defaults.integer(forKey:"defaultAge")
        defaultWeight = defaults.double(forKey:"defaultWeight")
        defaultHeight = defaults.double(forKey: "defaultHeight")
        defaultGoalRow = defaults.integer(forKey: "defaultGoal")
        defaultActivityRow = defaults.integer(forKey: "defaultActivity")
        
        macrosCalculated()
        
        incrementProgress(pros: pros)
        
        caloriesLabelFunction()
        proteinLabelFunction()
        fatsLabelFunction()
        carbsLabelFunction()
        
        breakfastProducts.numberOfLines = 0
        breakfastProducts.sizeToFit()
        lunchProducts.numberOfLines = 0
        lunchProducts.sizeToFit()
        dinnerProducts.numberOfLines = 0
        dinnerProducts.sizeToFit()
        //breakfastList.append(product1)
        //breakfastList.append(product1)
        //breakfastList.append(product1)
        for products in breakfastList {
            breakfastResult += "\n" + products.item_name
        }
        for products in lunchList {
            lunchResult += "\n" + products.item_name
        }
        for products in dinnerList {
            dinnerResult += "\n" + products.item_name
        }
        breakfastProducts.text = breakfastResult
        lunchProducts.text = lunchResult
        dinnerProducts.text = dinnerResult
        
        
        
       

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
 
        navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillAppear(animated)
        if (defaultName == "")
        {
            self.present(controller, animated: true, completion: nil)
        }
        else
        {
            userNameLabel.text = defaultName.uppercased() + "'S TODAY"
        }
    }
    
    

    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        super.viewWillDisappear(animated)
    }
    func getGoal() -> Int{
        var goal:Int
        switch defaultGoalRow
        {
        case 0 : goal = 0
        case 1 : goal = 300
        case 2 :  goal = -300
        default : goal = 0
        }
        return goal
    }
    
    func getActivity() -> Double{
        var activity:Double
        switch defaultActivityRow
        {
        case 0 : activity = 1.2
        case 1 :  activity = 1.375
        case 2 :  activity = 1.55
        case 3 :  activity = 1.725
        case 4 :  activity = 1.9
        default : activity = 0
        }
        return activity
    }
    
    
    func caloriesLabelFunction() {
        
        self.caloriesLabel.text = String(CaloriesDailyProgress.progress * Float(cals)) + "/" + String(Int(cals))
//        self.CaloriesDailyProgress.setProgress(Float(cals), animated: true)
    }
    
    func macrosCalculated() {
        pros = calculateProteins(weight: defaultWeight)
        cals = calculateCalories(sex: defaultGenderIndex,weight: defaultWeight,height: defaultHeight,age: defaultAge,goal: getGoal(), userActivity: getActivity())
        carbs = calculateCarbs(calorieGoal: cals,fatsGoal: fat, proteinGoal: pros)
        fat = calculateFats(calorieGoal: cals)
    }
    
    func proteinLabelFunction() {
            self.proteinLabel.text = String(ProteinDailyProgress.progress * Float(pros)) + "/" + String(Int(pros))
//        self.ProteinDailyProgress.setProgress(Float(pros), animated: true)
    }
    
    func fatsLabelFunction() {
        
        self.fatsLabel.text = String(FatsDailyProgress.progress * Float(fat)) + "/" + String(Int(fat))
//        self.FatsDailyProgress.setProgress(Float(fat), animated: true)
           
    }
    
    func carbsLabelFunction() {
        
        self.carbsLabel.text = String(CarbsDailyProgress.progress * Float(carbs) ) + "/" + String(Int(carbs))
//         self.CarbsDailyProgress.setProgress(Float(carbs), animated: true)
    }
    

       
       func getUserDefaults() -> UserDefaults {
           let defaults = UserDefaults.standard
           if (defaults.object(forKey: "defaultName") == nil) {
                  // set initial defaults
               defaults.set(defaultGenderIndex, forKey: "defaultGender")
                defaults.set(defaultAge,forKey: "defaultAge")
               defaults.set(defaultWeight, forKey: "defaultWeight")
               defaults.set(defaultHeight, forKey: "defaultHeight")
                defaults.set(defaultGoalRow,forKey: "defaultGoal")
                 defaults.set(defaultActivityRow,forKey: "defaultActivity")
                  defaults.synchronize()
              }
              return defaults
          }
       


 
    
}

