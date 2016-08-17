//
//  CalibrationViewController.swift
//  Ambliotopy
//
//  Created by Eduardo Janicas and Nuno Fernandes on 25/06/16.
//  Copyright © 2016 EN. All rights reserved.
//

import SpriteKit

class CalibrationViewController: UIViewController, CalibrationDelegate, UIGestureRecognizerDelegate {
    
    var scene: TetrisScene!
    var calibration: Calibration!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure the view.
        let skView = view as! SKView
        skView.multipleTouchEnabled = false
        
        // Create and configure the scene
        scene = TetrisScene(size: skView.bounds.size)
        scene.scaleMode = .AspectFill
        
        scene.tick = didTick
        
        calibration = Calibration()
        calibration.delegate = self
        calibration.beginCalibration()
        
        // Present the scene
        skView.presentScene(scene)
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    @IBAction func didTap(sender: AnyObject) {
        // calibration.endCalibration()
    }
    
    func didTick() {
        if (badEye == Eye.Left) {
            calibration.changeBlueContrast()
        } else {
            calibration.changeRedContrast()
        }
    }
    
    func calibrationDidBegin(calibration: Calibration) {
        // levelLabel.text = "\(level)"
        // scoreLabel.text = "\(swiftris.score)"
        scene.tickLengthMillis = TickLengthCalibration
        self.scene.startTicking()
        scene.addPreviewShapeToScene(calibration.shape!) {}

    }
    
    func calibrationDidEnd(calibration: Calibration) {
        view.userInteractionEnabled = false
        scene.stopTicking()
    }
    
    func calibrationWillLevelUp(calibration: Calibration) {
        scene.removePreviewShapesFromScene()
    }
    
    func calibrationDidLevelUp(calibration: Calibration) {
        scene.addPreviewShapeToScene(calibration.shape!) {}
    }
    
    @IBAction func didEnd(sender: AnyObject) {

        contrast.saveContrast()
        calibrationDidEnd(calibration)
        navigationController?.popViewControllerAnimated(true)
        
    }
}