//
//  ProgressViewController.swift
//  SlugNutrition
//
//  Created by Dylan Salak on 7/16/20.
//  Copyright © 2020 Roberto Oregon. All rights reserved.
//

import UIKit

//extension UserDefaults {
//
//    static let defaults = UserDefaults.standard
//
//    static var lastAccessDate: Date? {
//        get {
//            return defaults.object(forKey: "lastAccessDate") as? Date
//        }
//        set {
//            guard let newValue = newValue else { return }
//            guard let lastAccessDate = lastAccessDate else {
//                defaults.set(newValue, forKey: "lastAccessDate")
//                return
//            }
//            if !Calendar.current.isDateInToday(lastAccessDate) {
//                print("remove Persistent Domain")
//                UserDefaults.reset()
//            }
//            defaults.set(newValue, forKey: "lastAccessDate")
//        }
//    }
//
//    static func reset() {
//        defaults.removePersistentDomain(forName: Bundle.main.bundleIdentifier ?? "")
//    }
//}

class ProgressViewController: UIViewController {
    
    @IBOutlet weak var goodLabel: UILabel!
    @IBOutlet weak var okayLabel: UILabel!
    @IBOutlet weak var badLabel: UILabel!
    
    var defaultGood: Int = 0
    var defaultOkay: Int = 0
    var defaultBad: Int = 0
    var defaultDate: Date?

    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = getUserDefaults()
        defaultGood = defaults.integer(forKey:"defaultGood")
        defaultOkay = defaults.integer(forKey:"defaultOkay")
        defaultBad = defaults.integer(forKey:"defaultBad")
        defaultDate = defaults.object(forKey:"defaultDate") as? Date

        if (defaultDate == nil){
            //user's first time accessing progress page, so set date to now
            defaultDate = Date()
        }
        else{
            updateLabels(lastDate: defaultDate!, good: defaultGood, okay: defaultOkay, bad: defaultBad)
        }
        // Do any additional setup after loading the view.
        goodLabel.text = String(defaultGood)
        okayLabel.text = String(defaultOkay)
        badLabel.text = String(defaultBad)
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
            
            //save as Date
            defaults.set(defaultDate, forKey: "defaultDate")
            
            defaults.set(defaultGood, forKey: "defaultGood")
            defaults.set(defaultOkay,forKey: "defaultOkay")
            defaults.set(defaultBad, forKey: "defaultBad")
            defaults.synchronize()
        }
        return defaults
    }
    
    // function from this link
    // https://iostutorialjunction.com/2019/09/get-number-of-days-between-two-dates-swift.html 
    func daysBetween(start: Date, end: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: start, to: end).day!
    }
    
    func updateLabels(lastDate: Date, good: Int, okay: Int, bad: Int){
        
        let defaults = getUserDefaults()
        
        let now = Date()
        
        let lastDateMonth = Calendar.current.dateComponents([.month], from: lastDate)
        let nowMonth = Calendar.current.dateComponents([.month], from: now)
        
        //if the month has changed the labels and colors need to be reset
        if lastDateMonth != nowMonth{
            let zero: Int = 0
            defaults.set(zero, forKey: "defaultGood")
            defaults.set(zero, forKey: "defaultOkay")
            defaults.set(zero, forKey: "defaultBad")
            defaults.set(now, forKey: "defaultDate")
        }
        
        //if date is the same as the lastDate in userDefaults, do nothing
        else if (lastDate == now){
            print("Date has not changed")
        }
        //if lastDate was earlier than the date now, then update the labels based on past days
        else if (lastDate < now){
            let days = daysBetween(start: lastDate, end: now)
            print(days)
            
            //update color for lastDate !!!
            
            //if there are days between lastDate and now (days where the user didn't open the app),
            //mark those days as red
            if (days != 0){
                defaultBad = defaults.integer(forKey:"defaultBad")
                defaultBad += days
//                //for loop to mark all days in between as red
//                for i in 1...days {
//                    //mark the days as red !!!
//                    defaultBad += 1
//                }
            }
            
            //after setting progress for lastDate (and any days between then and now), set userDefault to today
            defaults.set(now, forKey: "defaultDate")
        }
        //else lastDate is somehow after the date now, so throw an exception/error
        else {
            print("ERROR")
        }
        
        //implement a notification observer for UIApplicationSignificantTimeChangeNotification
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
