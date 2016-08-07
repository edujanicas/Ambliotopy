//
//  GameViewController.swift
//  RushColor
//
//  Created by Nuno Henrique Sales Fernandes on 11/07/16.
//  Copyright (c) 2016 Nuno Henrique Sales Fernandes. All rights reserved.
//

import UIKit
import SpriteKit

class RCViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if let scene = RCScene(fileNamed: "RCScene") {
            // Configure the view.
            let skView = self.view as! SKView
            skView.showsFPS = false
            skView.showsNodeCount = false
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .AspectFill
            skView.presentScene(scene)
        }
    }

    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return .AllButUpsideDown
        } else {
            return .All
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
