//
//  SquareScene.swift
//  RushColor
//
//  Created by Nuno Henrique Sales Fernandes on 12/07/16.
//  Copyright © 2016 Nuno Henrique Sales Fernandes. All rights reserved.
//

import UIKit
import SpriteKit

struct PhysicsCategory {
    static let circle : UInt32 = 0x1 << 1
    static let square : UInt32 = 0x1 << 2
    static let scoreN : UInt32 = 0x1 << 3
}

class SquareScene: SKScene, SKPhysicsContactDelegate {
    
    let redColor = ColorModel().colors[0]
    let blueColor = ColorModel().colors[1]
    let increment = 1
    var score = Int()
    
    override func didMoveToView(view: SKView) {
        self.physicsWorld.contactDelegate = self
        self.physicsWorld.gravity = CGVectorMake(0, -4)
        self.createSquareNode()
        self.dropingCircles()
    }
    
//==================================================================================
//    func circleDroping(){
//        let spawn = SKAction.runBlock({
//            () in
//            
//            self.initSquareScene()
//        })
//        
//        let spawnDelay = SKAction.sequence([spawn])
//        let spawnDelayForever = SKAction.repeatActionForever(spawnDelay)
//        self.runAction(spawnDelayForever)
//    }
//==================================================================================
    
    func dropingCircles(){
        
        var node:SKShapeNode = SKShapeNode()
        
        let dropCircles = SKAction.sequence([SKAction.runBlock({
            node = self.createCircleNode()}),
            SKAction.waitForDuration(2.0),
            SKAction.runBlock({ node.removeFromParent() }),
            ])
        
        let spawnDelay = SKAction.sequence([dropCircles])
        let spawnDelayForever = SKAction.repeatActionForever(spawnDelay)
        self.runAction(spawnDelayForever)
        //FALTA REMOVER OS NODES
//        let remove = SKAction.removeFromParent()
//        self.runAction(remove)
        
//        self.runAction(SKAction.repeatAction(dropCircles, count: numberofCircles))
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        let firstBody = contact.bodyA
        let secondBody = contact.bodyB

        if firstBody.categoryBitMask == PhysicsCategory.square && secondBody.categoryBitMask == PhysicsCategory.circle || firstBody.categoryBitMask == PhysicsCategory.circle && secondBody.categoryBitMask == PhysicsCategory.square{
            score += increment
            print(score)
        }
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
        
        square.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 200, height: -100))
        square.physicsBody?.categoryBitMask = PhysicsCategory.square
        square.physicsBody?.collisionBitMask = PhysicsCategory.circle
        square.physicsBody?.contactTestBitMask = PhysicsCategory.circle
        square.physicsBody?.affectedByGravity = false
        square.physicsBody?.dynamic = false
        
        square.zPosition = 3
        
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
        
        circle.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 200, height: 200))
        circle.physicsBody?.categoryBitMask = PhysicsCategory.circle
        circle.physicsBody?.collisionBitMask = PhysicsCategory.square
        circle.physicsBody?.contactTestBitMask = PhysicsCategory.square
        circle.physicsBody?.affectedByGravity = true
        circle.physicsBody?.dynamic = true
        
        
        circle.zPosition = 2
        
        self.addChild(circle)
        
        return circle
        
    }
    
    func createscoreNode() -> SKSpriteNode{
        let scoreN = SKSpriteNode()
        scoreN.size = CGSize(width: 1, height: 200)
        scoreN.position = CGPoint(x: 400, y: 193.987)
        scoreN.physicsBody = SKPhysicsBody(rectangleOfSize: scoreN.size)
        scoreN.physicsBody?.affectedByGravity = false
        scoreN.physicsBody?.dynamic = false
        scoreN.physicsBody?.categoryBitMask = PhysicsCategory.scoreN
        scoreN.physicsBody?.collisionBitMask = 0
        scoreN.physicsBody?.contactTestBitMask = 0
        
        return scoreN
    }

}
