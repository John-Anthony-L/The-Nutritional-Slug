//
//  customViewController.swift
//  SlugNutrition
//
//  Created by Roberto on 7/5/20.
//  Copyright © 2020 Roberto Oregon. All rights reserved.
//

import UIKit

//var breakfastList: [MealProducts] = []
//var lunchList: [MealProducts] = []
//var dinnerList: [MealProducts] = []

class customViewController: UIViewController {

    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet weak var CarbsDailyProgress: UIProgressView!
    @IBOutlet weak var FatsDailyProgress: UIProgressView!
    @IBOutlet weak var ProteinDailyProgress: UIProgressView!
    @IBOutlet weak var CaloriesDailyProgress: UIProgressView!
    @IBOutlet var breakfastFood: UILabel!
    @IBOutlet var lunchFood: UILabel!
    @IBOutlet var dinnerFood: UILabel!
    
    @IBOutlet weak var caloriesLabel: UILabel!
    @IBOutlet weak var proteinLabel: UILabel!
    @IBOutlet weak var fatsLabel: UILabel!
    @IBOutlet weak var carbsLabel: UILabel!
//
//    var proteinProgress:Float = 0.0
//    var carbsProgress:Float = 0.0
//    var fatsProgress:Float = 0.0
//    var calProgress:Float = 0.0
    
  var defaultName:String = ""
  var defaultGenderIndex:Int = 0
  var defaultAge: Int = 0
  var defaultWeight: Double = 0.0
        var defaultHeight: Double = 0.0
        var defaultGoalRow:Int = 0
        var defaultActivityRow: Int = 0
        var selected: String = ""
        var cals:Double = 0.0
        var fat:Double = 0.0
        var pros:Double = 0.0
        var defaultFoodName = ""
    var defaultCarbs = 0.0
    var defaultFats = 0.0
    var defaultCals = 0.0
    var defaultPros = 0.0
    var defaultMeal:Int?
    var carbs: Double = 0.0
    var breakfast: String?
    var lunch: String?
    var dinner: String?
    
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

        func calculateCarbs(calorieGoal: Double, fatsGoal: Double, proteinGoal: Double) -> Double {
            let x = (calorieGoal - 9 * fatsGoal - 4 * proteinGoal) / 4
            return x
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
            caloriesLabelFunction()
            proteinLabelFunction()
            fatsLabelFunction()
            carbsLabelFunction()
           
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
            
        }
    func updateMeal(){
        if (UserDefaults.standard.object(forKey: "defaultFoodName") != nil) {
            updateCarbsProg()
            updateCalsProg()
            updateFatsProg()
            updateProsProg()
            updateFood()
    }
    }
        
        

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
        
        
        func caloriesLabelFunction() {
            cals = calculateCalories(sex: defaultGenderIndex,weight: defaultWeight,height: defaultHeight,age: defaultAge,goal: getGoal(), userActivity: getActivity())
            self.caloriesLabel.text = String(CaloriesDailyProgress.progress*100) + "/" + String(Int(cals))
    //        self.CaloriesDailyProgress.setProgress(Float(cals), animated: true)
        }
        
        func proteinLabelFunction() {
            pros = calculateProteins(weight: defaultWeight)
                self.proteinLabel.text = String(ProteinDailyProgress.progress*100) + "/" + String(Int(pros))
    //        self.ProteinDailyProgress.setProgress(Float(pros), animated: true)
        }
        
        func fatsLabelFunction() {
            fat = calculateFats(calorieGoal: cals)
            self.fatsLabel.text = String(FatsDailyProgress.progress*100) + "/" + String(Int(fat))
    //        self.FatsDailyProgress.setProgress(Float(fat), animated: true)
               
        }
        
        func carbsLabelFunction() {
             carbs = calculateCarbs(calorieGoal: cals,fatsGoal: fat, proteinGoal: pros)
            self.carbsLabel.text = String(CarbsDailyProgress.progress*Float(Double(carbs))) + "/" + String(Int(carbs))
    //         self.CarbsDailyProgress.setProgress(Float(carbs), animated: true)
        }
        
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

