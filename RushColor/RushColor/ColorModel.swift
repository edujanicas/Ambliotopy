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
    let colors = [
        UIColor(red: 255/255.0, green: 59/255.0, blue: 48/255.0, alpha: 1.0),//RED
        UIColor(red: 0/255.0, green: 122/255.0, blue: 255/255.0, alpha: 1.0)//BLUE
    ]
    
    func getRandomColor() -> UIColor{
        let randomNumber = GKRandomSource.sharedRandom().nextIntWithUpperBound(colors.count)
        return colors[randomNumber]
    }
    
    func changeColor( oldcolor: UIColor) -> UIColor{
        var newcolor = oldcolor
        if(newcolor == colors[0]){
            newcolor=colors[1]
        }
        else{
            newcolor=colors[0]
        }
        return newcolor
    }
}
