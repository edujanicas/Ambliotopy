//
//  SquareScene.swift
//  Ambliotopy
//
//  Created by Eduardo Janicas and Nuno Fernandes on 25/06/16.
//  Copyright © 2016 EN. All rights reserved.
//

//Sera que preciso de um gameStarted?

import UIKit
import SpriteKit

struct PhysicsCategory {
    static let circle : UInt32 = 0x1 << 1
    static let square : UInt32 = 0x1 << 2
    static let pop : UInt32 = 0x1 << 3
}

class SquareScene: SKScene, SKPhysicsContactDelegate {
    
    let redColor = ColorModel().colors[0]
    let blueColor = ColorModel().colors[1]
    let orangeColor = ColorModel().backgroundColor
    let increment = 1
    var score = Int()
    var scoreLvl = 1
    var hightscore = Int()
    var scoreLbl = SKLabelNode() //NOVO
    var hightscoreLbl = SKLabelNode() //NOVO
    var circle = SKShapeNode(circleOfRadius: 40) //NOVO
    var square = SKShapeNode(rectOfSize: CGSize(width: 200, height: 200)) //NOVO
    var died = Bool() //NOVO
    var restartBTN = SKSpriteNode(imageNamed: "play") //NOVO
    
    
    func restartScene(){
        self.removeAllChildren()
        self.removeAllActions()
        died = false
        score = 0
        createScene()
    }
    
    func createScene(){
        self.physicsWorld.contactDelegate = self
        self.physicsWorld.gravity = CGVectorMake(0, -4)
        self.createSquareNode()
        self.dropingCircles()
        self.createscoreLbl() //NOVO
        self.createshightcoreLbl()
    }
    
    override func didMoveToView(view: SKView) {
        self.createScene()
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
        
        //NOVO
        if firstBody.categoryBitMask == PhysicsCategory.square && secondBody.categoryBitMask == PhysicsCategory.circle || firstBody.categoryBitMask == PhysicsCategory.circle && secondBody.categoryBitMask == PhysicsCategory.square{
            if(square.fillColor == circle.fillColor){
                score += increment
                scoreLbl.text = "\(score)"
                if(hightscore<score){
                    hightscore = score
                    hightscoreLbl.text = "\(hightscore)"
                }
                if (score % 10 == scoreLvl){
                    scoreLvl += 1
                }

            }
            else{
                died = true
                createrestartBTNNode()
            }
        }
    }
    

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?){
        
        if(square.name == "redSquare"){
            square.fillColor = Contrast().getUIColor("blue")
            square.strokeColor = Contrast().getUIColor("blue")
            square.name = "blueSquare"
        }
        else{
            square.fillColor = Contrast().getUIColor("red")
            square.strokeColor = Contrast().getUIColor("red")
            square.name = "redSquare"
        }
        
        for touch: AnyObject in touches {
            let positionOfTouch = touch.locationInNode(self)
            
            if (died == true){
                if restartBTN.containsPoint(positionOfTouch){
                    restartScene()
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
        square.name = "redSquare"
        square.fillColor = Contrast().getUIColor("red")
        square.strokeColor = Contrast().getUIColor("red")
        square.position = CGPointMake(self.frame.width / 2, 193.987) //NOVO
        square.userInteractionEnabled = false
        
        square.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 200, height: -150))
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
        circle.position = CGPointMake(self.frame.width / 2, self.size.height+40) //NOVO
        circle.name = "defaultCircle"
        circle.strokeColor = colorRandom
        circle.glowWidth = 0
        circle.fillColor = colorRandom
        circle.userInteractionEnabled = true
        circle.physicsBody = SKPhysicsBody(circleOfRadius: 40)
        circle.physicsBody?.dynamic = true //.physicsBody?.dynamic = true
        
        circle.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 200, height: 200))
        circle.physicsBody?.categoryBitMask = PhysicsCategory.circle
        circle.physicsBody?.collisionBitMask = PhysicsCategory.square | PhysicsCategory.pop
        circle.physicsBody?.contactTestBitMask = PhysicsCategory.square | PhysicsCategory.pop
        circle.physicsBody?.affectedByGravity = true
        circle.physicsBody?.dynamic = true
        
        
        circle.zPosition = 2
        
        self.addChild(circle)
        
        return circle
        
    }
    
//    func createscoreNode() -> SKSpriteNode{
//        let scoreN = SKSpriteNode()
//        scoreN.size = CGSize(width: 1, height: 200)
//        scoreN.position = CGPoint(x: 400, y: 193.987)
//        scoreN.physicsBody = SKPhysicsBody(rectangleOfSize: scoreN.size)
//        scoreN.physicsBody?.affectedByGravity = false
//        scoreN.physicsBody?.dynamic = false
//        scoreN.physicsBody?.categoryBitMask = PhysicsCategory.scoreN
//        scoreN.physicsBody?.collisionBitMask = 0
//        scoreN.physicsBody?.contactTestBitMask = 0
//        
//        return scoreN
//    }
    
    func createscoreLbl()-> SKLabelNode{ //NOVO
        scoreLbl.position = CGPoint(x: self.frame.width / 2, y: 100)
        scoreLbl.text = "\(score)"
        scoreLbl.fontName = "04b_19"
        scoreLbl.fontSize = 100
        
        scoreLbl.zPosition = 3
        
        self.addChild(scoreLbl)
        
        return scoreLbl
    }
    
    func createshightcoreLbl()-> SKLabelNode{ //NOVO
        hightscoreLbl.position = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2 + 320)
        
        hightscoreLbl.text = "\(hightscore)"
        hightscoreLbl.fontName = "04b_19"
        hightscoreLbl.fontSize = 100
        
        hightscoreLbl.zPosition = 3
        
        self.addChild(hightscoreLbl)
        
        return hightscoreLbl
    }
    
    func createrestartBTNNode(){
        restartBTN.position = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
        
        restartBTN.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 200, height: -190))
        restartBTN.physicsBody?.categoryBitMask = PhysicsCategory.pop
        restartBTN.physicsBody?.collisionBitMask = PhysicsCategory.circle
        restartBTN.physicsBody?.contactTestBitMask = PhysicsCategory.circle
        restartBTN.physicsBody?.affectedByGravity = false
        restartBTN.physicsBody?.dynamic = false
        
        square.userInteractionEnabled = false
        square.fillColor = orangeColor
        square.strokeColor = orangeColor
        
        restartBTN.zPosition = 5
        self.addChild(restartBTN)
    }

}
