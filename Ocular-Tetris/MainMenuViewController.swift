//
//  MainMenuViewController.swift
//  Ambliotopy
//
//  Created by Eduardo Janicas and Nuno Fernandes on 25/06/16.
//  Copyright © 2016 EN. All rights reserved.
//

import Foundation
import UIKit

class MainMenuViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let launchedBefore = defaults.boolForKey("launchedBefore")
        if (!launchedBefore) {
            print("First Time")
            defaults.setBool(true, forKey: "launchedBefore")
            performSegueWithIdentifier("calibration", sender: nil)
        }
    }
}