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
    
//    @IBOutlet var breakfastFood: UILabel!
//    @IBOutlet var lunchFood: UILabel!
//    @IBOutlet var dinnerFood: UILabel!
    
    @IBOutlet weak var caloriesLabel: UILabel!
    @IBOutlet weak var proteinLabel: UILabel!
    @IBOutlet weak var fatsLabel: UILabel!
    @IBOutlet weak var carbsLabel: UILabel!

    var proteinProgress:Float = 0.0
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
    
    
//    var defaultFoodName = ""
//    var defaultCarbs = 0.0
//    var defaultFats = 0.0
//    var defaultCals = 0.0
//    var defaultPros = 0.0
//    var defaultMeal:Int?
//    var carbs: Double = 0.0
//    var breakfast: String?
//    var lunch: String?
//    var dinner: String?
    
    @IBOutlet weak var breakfastProducts: UILabel!
    @IBOutlet weak var lunchProducts: UILabel!
    @IBOutlet weak var dinnerProducts: UILabel!
    
    var product1: MealProducts = MealProducts(item_name: "generic", brand_name: "meh", nf_calories: 100.0, nf_total_fat: 100.0, nf_total_carbohydrate: 100.0, nf_protein: 100.0)
    var breakfastResult = " "
    var lunchResult = " "
    var dinnerResult = " "
    
    let controller:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SettingsViewController") as UIViewController
        
        
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

    func calculateCarbs(calorieGoal: Double, fatsGoal: Double, proteinGoal: Double) -> Double{
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
        
//        macrosCalculated()
//        incrementProgress(pros: pros)
//        
//        caloriesLabelFunction()
//        proteinLabelFunction()
//        fatsLabelFunction()
//        carbsLabelFunction()
//
////        breakfastProducts.numberOfLines = 0
////        breakfastProducts.sizeToFit()
////        lunchProducts.numberOfLines = 0
////        lunchProducts.sizeToFit()
////        dinnerProducts.numberOfLines = 0
////        dinnerProducts.sizeToFit()
//
//        print("brekkie count: ",breakfastList.count)
//
//        for products in breakfastList {
//            breakfastResult += " " + products.item_name
//        }
//        for products in lunchList {
//            lunchResult += " " + products.item_name
//        }
//        for products in dinnerList {
//            dinnerResult += " " + products.item_name
//        }
//
//        breakfastProducts.text = String(breakfastResult.prefix(18))
//        lunchProducts.text = String(lunchResult.prefix(18))
//        dinnerProducts.text = String(dinnerResult.prefix(18))
//
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
        macrosCalculated()
        incrementProgress(pros: pros)
        
        caloriesLabelFunction()
        proteinLabelFunction()
        fatsLabelFunction()
        carbsLabelFunction()
        for products in breakfastList {
                   breakfastResult += " " + products.item_name
               }
               for products in lunchList {
                   lunchResult += " " + products.item_name
               }
               for products in dinnerList {
                   dinnerResult += " " + products.item_name
               }
               
               breakfastProducts.text = String(breakfastResult.prefix(18))
               lunchProducts.text = String(lunchResult.prefix(18))
               dinnerProducts.text = String(dinnerResult.prefix(18))
                  
        
        /*
        if  breakfast != nil
        {
            breakfastFood.text = breakfast
        }
        if lunch != nil
        {
            lunchFood.text = lunch
        }
        if dinner != nil
        {
            dinnerFood.text = dinner
        }
        let defaults = getUserDefaults()
        defaultFoodName = defaults.string(forKey: "defaultFoodName") ?? ""
        defaultMeal = defaults.integer(forKey: "defaultMeal")
        defaultCarbs = defaults.double(forKey: "defaultCarbs")
        defaultFats = defaults.double(forKey: "defaultFats")
        defaultCals = defaults.double(forKey: "defaultCals")
        defaultPros = defaults.double(forKey: "defaultPros")
        updateMeal()
        */
        
        }
    
    /*
    func updateMeal(){
        if (UserDefaults.standard.object(forKey: "defaultFoodName") != nil) {
            updateCarbsProg()
            updateCalsProg()
            updateFatsProg()
            updateProsProg()
            updateFood()
        }
    }
 */
        
        

//        override func viewWillDisappear(_ animated: Bool) {
//            self.navigationController?.setNavigationBarHidden(false, animated: animated)
//            super.viewWillDisappear(animated)
//        }
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
        
    func macrosCalculated() {
        pros = calculateProteins(weight: defaultWeight)
        cals = calculateCalories(sex: defaultGenderIndex,weight: defaultWeight,height: defaultHeight,age: defaultAge,goal: getGoal(), userActivity: getActivity())
        carbs = calculateCarbs(calorieGoal: cals,fatsGoal: fat, proteinGoal: pros)
        fat = calculateFats(calorieGoal: cals)
    }
    
    func caloriesLabelFunction() {
        self.caloriesLabel.text = String(format: "%.0f", CaloriesDailyProgress.progress * Float(cals)) + "/" + String(Int(cals))
    }
        
    func proteinLabelFunction() {
        self.proteinLabel.text = String(format: "%.0f", ProteinDailyProgress.progress * Float(pros)) + "/" + String(Int(pros))
    }
        
    func fatsLabelFunction() {
        self.fatsLabel.text = String(format: "%.0f", FatsDailyProgress.progress * Float(fat)) + "/" + String(Int(fat))
    }
        
    func carbsLabelFunction() {
        self.carbsLabel.text = String(format: "%.0f", CarbsDailyProgress.progress * Float(carbs) ) + "/" + String(Int(carbs))
    }
    
    /*
    func updateCarbsProg()
    {
        CarbsDailyProgress.progress = CarbsDailyProgress.progress + Float(defaultCarbs)/Float(Double(carbs))
        carbsLabelFunction()
    }
    func updateCalsProg()
    {
        CaloriesDailyProgress.progress = CaloriesDailyProgress.progress + Float(defaultCals)/Float(Double(cals))
        caloriesLabelFunction()
        
    }
    
    func updateFatsProg()
    {
        FatsDailyProgress.progress = FatsDailyProgress.progress + Float(defaultFats)/Float(Double(fat))
               fatsLabelFunction()
    }
    func updateProsProg()
    {
        ProteinDailyProgress.progress = ProteinDailyProgress.progress + Float(defaultPros)/Float(Double(pros))
        proteinLabelFunction()
    }
    func updateFood(){
        if defaultMeal == 0
        {
            breakfast = defaultFoodName
            breakfastFood.text = breakfast
        }
        else if defaultMeal == 1
        {
            lunch = defaultFoodName
            lunchFood.text = lunch
        }
        else
        {
            dinner = defaultFoodName
            dinnerFood.text = dinner
        }
    }*/
    
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

