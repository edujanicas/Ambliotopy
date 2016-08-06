//
//  EyeSelectorViewController.swift
//  Ambliotopy
//
//  Created by Eduardo Janicas on 04/08/16.
//  Copyright © 2016 EN. All rights reserved.
//

import SpriteKit

enum Eye {
    case Left;
    case Right;
}

class EyeSelectorViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func pressedLeft(sender: AnyObject) {
        badEye = Eye.Left
        defaults.setInteger(1, forKey: "badEye")
    }
    
    @IBAction func pressedRight(sender: AnyObject) {
        badEye = Eye.Right
        defaults.setInteger(2, forKey: "badEye")
    }
}
