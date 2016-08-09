//
//  Contrast.swift
//  Ambliotopy
//
//  Created by Eduardo Janicas and Nuno Fernandes on 25/06/16.
//  Copyright © 2016 EN. All rights reserved.
//

import SpriteKit

class Contrast {
    
    var contrast: Double = 1.0
    
    func getContrast() -> Double {
        return contrast
    }
    
    func saveContrast() {
        defaults.setDouble(contrast, forKey: "contrast")
    }
    
    func loadContrast() {
        
        let savedContrast = defaults.doubleForKey("contrast")
        if savedContrast > 0 {
            contrast = savedContrast
        }
        
    }
    
    func decreaseContrast() {
        contrast *= 0.9
    }
    
    func increaseContrast() {
        contrast /= 0.9
        contrast /= 0.9
        
        if contrast > 1 { contrast = 1 }
    }
    
    func resetContrast() {
        contrast = 1.0
    }
    
    func getUIColor(color: String) -> UIColor {
        
        switch color {
        case "blue":
            let r = BlueRed * contrast + RedRed * -(contrast - 1.0)
            let g = BlueGreen * contrast + RedGreen * -(contrast - 1.0)
            let b = BlueBlue * contrast + RedBlue * -(contrast - 1.0)
            print(r, g, b)
            return UIColor(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: 1.0)
        case "red":
            let r = RedRed * contrast + BlueRed * -(contrast - 1.0)
            let g = RedGreen * contrast + BlueGreen * -(contrast - 1.0)
            let b = RedBlue * contrast + BlueBlue * -(contrast - 1.0)
            print(r, g, b)
            return UIColor(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: 1.0)
        default:
            return UIColor.blackColor()
            
        }
        
    }
    
}
