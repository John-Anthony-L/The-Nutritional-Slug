//
//  customViewController.swift
//  SlugNutrition
//
//  Created by Roberto on 7/5/20.
//  Copyright © 2020 Roberto Oregon. All rights reserved.
//

import UIKit

class customViewController: UIViewController {

    @IBOutlet weak var CarbsDailyProgress: UIProgressView!
    @IBOutlet weak var FatsDailyProgress: UIProgressView!
    @IBOutlet weak var ProteinDailyProgress: UIProgressView!
    @IBOutlet weak var CaloriesDailyProgress: UIProgressView!
    
    @IBOutlet weak var caloriesLabel: UILabel!
    @IBOutlet weak var proteinLabel: UILabel!
    @IBOutlet weak var fatsLabel: UILabel!
    @IBOutlet weak var carbsLabel: UILabel!
    
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
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        let defaults = getUserDefaults()
        defaultName = defaults.string(forKey:"defaultName") ?? ""
        defaultGenderIndex = defaults.integer(forKey: "defaultGender")
        defaultAge = defaults.integer(forKey:"defaultAge")
        defaultWeight = defaults.double(forKey:"defaultWeight")
        defaultHeight = defaults.double(forKey: "defaultHeight")
        defaultGoalRow = defaults.integer(forKey: "defaultGoal")
        defaultActivityRow = defaults.integer(forKey: "defaultActivity")
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
        case 0 : activity = 1.375
        case 1 :  activity = 1.2
        case 2 :  activity = 1.55
        case 3 :  activity = 1.725
        case 4 :  activity = 1.9
        default : activity = 0
        }
        return activity
    }
    
    
    func caloriesLabelFunction() {
        cals = calculateCalories(sex: defaultGenderIndex,weight: defaultWeight,height: defaultHeight,age: defaultAge,goal: getGoal(), userActivity: getActivity())
        self.caloriesLabel.text = String(Int(cals))
        self.CaloriesDailyProgress.setProgress(Float(cals), animated: true)
    }
    
    func proteinLabelFunction() {
        pros = calculateProteins(weight: defaultWeight)
            self.proteinLabel.text = String(Int(pros))
        self.ProteinDailyProgress.setProgress(Float(pros), animated: true)
    }
    
    func fatsLabelFunction() {
        fat = calculateFats(calorieGoal: cals)
        self.fatsLabel.text = String(Int(fat))
        self.FatsDailyProgress.setProgress(Float(fat), animated: true)
           
    }
    
    func carbsLabelFunction() {
        let carbs = calculateCarbs(calorieGoal: cals,fatsGoal: fat, proteinGoal: pros)
        self.carbsLabel.text = String(Int(carbs))
         self.CarbsDailyProgress.setProgress(Float(carbs), animated: true)
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

