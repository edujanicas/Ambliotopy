//
//  GameScene.swift
//  RushColor
//
//  Created by Nuno Henrique Sales Fernandes on 11/07/16.
//  Copyright (c) 2016 Nuno Henrique Sales Fernandes. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    //Setup your scene here
    override func didMoveToView(view: SKView) {

    }
    
    //Called when a touch begins
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let introLabel = childNodeWithName("introLabel")
        
        if introLabel != nil {
            
            let fadeOut = SKAction.fadeOutWithDuration(0.5) //Action
            
            introLabel?.runAction(fadeOut, completion: {
                let doors = SKTransition.doorwayWithDuration(1.5)
                let squareScene = SquareScene(fileNamed: "SquareScene")
                
                self.view?.presentScene(squareScene!, transition: doors)
            })
        }

    }
    //Called before each frame is rendered
    override func update(currentTime: CFTimeInterval) {
        
    }
}
