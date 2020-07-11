//
//  SlidesShowViewController.swift
//  SlugNutrition
//
//  Created by Vidisha Nevatia on 11/07/20.
//  Copyright © 2020 Roberto Oregon. All rights reserved.
//

import UIKit

class SlidesShowViewController: UIViewController {
   @IBOutlet weak var SlideShowViewer: UIImageView!
        var imageNames = ["1","2","3"]//List of image names
        override func viewDidLoad() {
            super.viewDidLoad()
            let timer = Timer.scheduledTimer(withTimeInterval: 0.9, repeats: true) { timer in
                self.SlideShowViewer.image = UIImage(named: self.imageNames.randomElement()!) //Slideshow logic
            }
            timer.fire() //Starts timer
            //timer.invalidate() //Stops timer
        }
    } 

