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
    
    
    func calculateCalories(s: Int, w: Double, h: Double, a: Int, g: Int, u: Double ) -> Double {
        //let f = floor(w)
        let x = 10 * (w / 2.2046)
        let y = 6.25 * (h * 2.54)
        let z = (5 * a)
        if s == 0 {
            return ((x + y - Double(z) + 5) * u - 200) + Double(g)
        }
        else {
            return ((x + y - Double(z) - 161) * u - 200) + Double(g)
        }
    }

    func calculateProteins(w: Double ) -> Double {
        //let f = floor(w)
        let x = w * 0.9
        return x
    }

    func calculateFats(c: Double ) -> Double {
        //let f = floor(w)
        let x = 0.25 * c / 9
        return x
    }

    func calculateCarbs(c: Double, f: Double, p: Double) -> Double {
        let x = (c - 9 * f - 4 * p) / 4
        return x
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        cals = calculateCalories(s: defaultGenderIndex,w: defaultWeight,h: defaultHeight,a: defaultAge,g: getGoal(), u: getActivity())
        self.caloriesLabel.text = String(Int(cals))
    }
    
    func proteinLabelFunction() {
        pros = calculateProteins(w: defaultWeight)
            self.proteinLabel.text = String(Int(pros))
    }
    
    func fatsLabelFunction() {
        fat = calculateFats(c: cals)
        self.fatsLabel.text = String(Int(fat))
           
    }
    
    func carbsLabelFunction() {
        let carbs = calculateCarbs(c: cals,f: fat, p: pros)
        self.carbsLabel.text = String(Int(carbs))
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

