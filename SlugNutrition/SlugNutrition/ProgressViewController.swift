//
//  ProgressViewController.swift
//  SlugNutrition
//
//  Created by Dylan Salak on 7/16/20.
//  Copyright © 2020 Roberto Oregon. All rights reserved.
//

import UIKit

class ProgressViewController: UIViewController {
    
    @IBOutlet weak var goodLabel: UILabel!
    @IBOutlet weak var okayLabel: UILabel!
    @IBOutlet weak var badLabel: UILabel!
    
        var defaultGood: Int = 10
        var defaultOkay: Int = 6
        var defaultBad: Int = 3
        var defaultDate: Date?
        var dateRating: Int = 0

        override func viewDidLoad() {
            super.viewDidLoad()
            let defaults = getUserDefaults()

    //        defaultGood = defaults.integer(forKey:"defaultGood")
    //        defaultOkay = defaults.integer(forKey:"defaultOkay")
    //        defaultBad = defaults.integer(forKey:"defaultBad")
            defaultDate = defaults.object(forKey:"defaultDate") as? Date
            dateRating = defaults.integer(forKey:"dateRating")

            // if it's the user's first time accessing the app, we need to set the date to now
            if (defaultDate == nil){
                defaultDate = Date()
                UserDefaults.standard.set(defaultDate, forKey: "defaultDate")
            }
            // else we update the labels based on the last access date
            else{
                let testComponents = DateComponents(calendar: Calendar.current, timeZone: TimeZone(abbreviation: "GMT"), year: 2020, month: 7, day: 20)
                print(testComponents.date!)
                dateRating = 1
                updateLabels(lastDate: testComponents.date!)

    //            updateLabels(lastDate: defaultDate!)
    //            UserDefaults.standard.set(defaultGood, forKey: "defaultGood")
    //            UserDefaults.standard.set(defaultOkay, forKey: "defaultOkay")
    //            UserDefaults.standard.set(defaultBad, forKey: "defaultBad")
            }
            
            //sync new values from above if-else statements
            UserDefaults.standard.synchronize()
            
            // Set the updated labels
            self.goodLabel.text = String(defaultGood)
            self.okayLabel.text = String(defaultOkay)
            self.badLabel.text = String(defaultBad)
        }
        
        override func viewWillAppear(_ animated: Bool) {
     
            navigationController?.setNavigationBarHidden(true, animated: animated)
            super.viewWillAppear(animated)
        }

        override func viewWillDisappear(_ animated: Bool) {
            self.navigationController?.setNavigationBarHidden(false, animated: animated)
            super.viewWillDisappear(animated)
        }
        
        func getUserDefaults() -> UserDefaults {
            let defaults = UserDefaults.standard
            if (defaults.object(forKey: "defaultName") == nil) {
                // set initial defaults
                defaults.set(defaultGood, forKey: "defaultGood")
                defaults.set(defaultOkay, forKey: "defaultOkay")
                defaults.set(defaultBad, forKey: "defaultBad")
                defaults.set(defaultDate, forKey: "defaultDate")
                defaults.set(dateRating, forKey: "dateRating")
                defaults.synchronize()
            }
            return defaults
        }
        
        // function from this link - Calculates the days between two dates
        // https://iostutorialjunction.com/2019/09/get-number-of-days-between-two-dates-swift.html
        func daysBetween(start: Date, end: Date) -> Int {
            return Calendar.current.dateComponents([.day], from: start, to: end).day!
        }
        
        //function calculates how many dates are Good, Okay, or Bad by comparing last access date and current date
        //Inputs: Last Access Date
        //Output: No outputted value, Function updates Good, Okay, and Bad values
        func updateLabels(lastDate: Date){
            
            let defaults = UserDefaults.standard
            
            let now = Date()
            
            //get month components of both dates for comparision
            let lastDateComponents = Calendar.current.dateComponents([.day, .month], from: lastDate)
            let nowComponents = Calendar.current.dateComponents([.day, .month], from: now)
            
            //if the month has changed the labels and colors need to be reset
            if (lastDateComponents.month != nowComponents.month){
                
                defaultGood = 0
                defaultOkay = 0
                defaultBad = 0
                defaults.set(0, forKey: "dateRating")
                defaults.set(now, forKey: "defaultDate")
                
                //need to check if today is first of the month
                //if not, we must count the preceding days of the month as Bad
                let formatter = DateFormatter()
                formatter.locale = Locale(identifier: "nl_NL")
                formatter.setLocalizedDateFormatFromTemplate("dd")

                let dayOfMonth = Int(formatter.string(from: now))!
                
                if (dayOfMonth != 1){
                    defaultBad += dayOfMonth - 1
                }
            }
            //if date is the same as the lastDate in userDefaults, do nothing
            else if (lastDateComponents.day == nowComponents.day){
                print("Date has not changed")
            }
            //if lastDate was earlier than the date now, then update the labels based on past days
            else if (lastDateComponents.day! < nowComponents.day!){
                let days = daysBetween(start: lastDate, end: now)
                
                //update the counts of Good, Okay, and Bad days
                //dateRating comes from customViewController [1 - Good, 2 - Okay, 3- Bad]
                if dateRating == 1{
                    defaultGood += 1
                } else if dateRating == 2{
                    defaultOkay += 1
                } else if dateRating == 3{
                    defaultBad += 1
                } else {
                    //throw exception?
                    print("ERROR")
                }
                
                //if there are days between lastDate and now (days where the user didn't open the app),
                //mark those days as Bad
                if (days != 0){
                    defaultBad += days - 1
                }
                
                //after setting progress for lastDate (and any days between then and now), set userDefault to today
                defaults.set(now, forKey: "defaultDate")
            }
            //else lastDate is somehow after the date now, so throw an exception/error
            else {
                print("ERROR")
            }
        }
    }
