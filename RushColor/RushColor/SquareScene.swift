//
//  SquareScene.swift
//  RushColor
//
//  Created by Nuno Henrique Sales Fernandes on 12/07/16.
//  Copyright © 2016 Nuno Henrique Sales Fernandes. All rights reserved.
//

import UIKit
import SpriteKit

class SquareScene: SKScene {
    
    var numberofCircles = 40
    let redColor = ColorModel().colors[0]
    let blueColor = ColorModel().colors[1]
    
    override func didMoveToView(view: SKView) {
        self.physicsWorld.gravity = CGVectorMake(0, -1.2)
        self.initSquareScene()
    }
    
    func initSquareScene(){
        
        self.createSquareNode()
        
        let dropCircles = SKAction.sequence([SKAction.runBlock({
            self.createCircleNode()}),
            SKAction.waitForDuration(2.0)
            ])
        
        self.runAction(SKAction.repeatAction(dropCircles, count: numberofCircles))
    }
    

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?){
        
            for touch: AnyObject in touches {
                let positionOfTouch = touch.locationInNode(self)
                if let node = nodeAtPoint(positionOfTouch) as? SKShapeNode {
//                    node.zRotation += 60
                    if(node.fillColor == redColor){
                        node.fillColor = blueColor
                        node.strokeColor=blueColor
                    }
                    else{
                        node.fillColor = redColor
                        node.strokeColor = redColor
                    }
                    
                    
                    
                }
        }
        
//        let squareNode = self.childNodeWithName("squareNode")
//        if (squareNode != nil){
//            
//            let changeColor = SKAction.colorizeWithColor(blueColor, colorBlendFactor: 0.0, duration: 0)
//            squareNode?.runAction(changeColor)
//        
//        }
    }
    
    func createSquareNode() -> SKShapeNode {
        let square = SKShapeNode(rectOfSize: CGSize(width: 200, height: 200))
        square.name = "defaultSquare"
        square.fillColor = redColor
        square.strokeColor = redColor
        square.position = CGPointMake(373.105, 193.987)
        square.userInteractionEnabled = false
        self.addChild(square)
        
        return square
    }
    
    func createCircleNode()->SKShapeNode{
        let colorRandom = ColorModel().getRandomColor()
        let circle = SKShapeNode(circleOfRadius: 40)
        circle.position = CGPointMake(373.105, self.size.height+40)
        circle.name = "defaultCircle"
        circle.strokeColor = colorRandom
        circle.glowWidth = 0
        circle.fillColor = colorRandom
        circle.userInteractionEnabled = true
        circle.physicsBody = SKPhysicsBody(circleOfRadius: 40)
        circle.physicsBody?.dynamic = true //.physicsBody?.dynamic = true
        self.addChild(circle)
        return circle
        
    }

}
