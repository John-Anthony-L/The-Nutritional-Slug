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
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
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
