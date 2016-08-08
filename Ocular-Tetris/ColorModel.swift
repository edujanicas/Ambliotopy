//
//  ColorModel.swift
//  RushColor
//
//  Created by Nuno Henrique Sales Fernandes on 12/07/16.
//  Copyright © 2016 Nuno Henrique Sales Fernandes. All rights reserved.
//

import UIKit
import GameKit

struct ColorModel {
//    let colors = [
//        UIColor(red: 255/255.0, green: 59/255.0, blue: 48/255.0, alpha: 1.0),//RED
//        UIColor(red: 0/255.0, green: 122/255.0, blue: 255/255.0, alpha: 1.0)//BLUE
//    ]
//    
//    let backgroundColor = UIColor(red: 255/255.0, green: 149/255.0, blue: 0/255.0, alpha: 1.0)//ORANGE
//    
//    func getRandomColor() -> UIColor{
//        let randomNumber = GKRandomSource.sharedRandom().nextIntWithUpperBound(colors.count)
//        return colors[randomNumber]
//    }
//    
//    func changeColor( oldcolor: UIColor) -> UIColor{
//        var newcolor = oldcolor
//        if(newcolor == colors[0]){
//            newcolor=colors[1]
//        }
//        else{
//            newcolor=colors[0]
//        }
//        return newcolor
//    }
    
    let colors = ["red", "blue"]
    
    let backgroundColor = UIColor(red: ((175.0)/2)/255.0, green: ((150.0)/2)/255.0, blue: ((215.0)/2)/255.0, alpha: 1.0)
    
    func getRandomColor() -> UIColor{
        let randomNumber = GKRandomSource.sharedRandom().nextIntWithUpperBound(colors.count)
        let numerodaCor = colors[randomNumber]
        let cor = contrast.getUIColor(numerodaCor)
        return cor
    }
    
    func changeColor(oldcolor: String) -> UIColor{

        var newcolor = oldcolor
        if(newcolor == colors[0]){
            newcolor = colors[1]
        }
        else{
            newcolor=colors[0]
        }
        
        let novacor = contrast.getUIColor(newcolor)
        
        return novacor
    }
    
}
