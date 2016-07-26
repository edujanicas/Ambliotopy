//
//  GameScene.swift
//  Ocular-Tetris
//
//  Created by Eduardo Janicas and Nuno Fernandes on 25/06/16.
//  Copyright (c) 2016 EN. All rights reserved.
//

import SpriteKit

var BlockSize:CGFloat = 40.0

let TickLengthLevelOne = NSTimeInterval(600)
let clock = Clock()

let RedRed = 166.0
let RedGreen = 0.0
let RedBlue = 22.0
let BlueRed = 2.0
let BlueGreen = 36.0
let BlueBlue = 100.0

class GameScene: SKScene {
    
    var tick:(() -> ())?
    var tickLengthMillis = TickLengthLevelOne
    var lastTick:NSDate?
    
    let gameLayer = SKNode()
    let shapeLayer = SKNode()
    let LayerPosition = CGPoint(x: 10, y: -20)
    
    var textureCache = Dictionary<String, SKTexture>()
    
    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoder not supoorted")
    }
    
    override init(size: CGSize) {
        super.init(size: size)
        
        // The size of each block is determined by the size of the view, diveded by the number of the columns of the game. The 6 extra columns are given only for aestetich reasons
        BlockSize = size.width / CGFloat(NumColumns + 6)
        anchorPoint = CGPoint(x: 0, y: 1.0)
        
        let background = SKSpriteNode(color: UIColor.blackColor(), size: size)
        background.position = CGPoint(x: 0, y: 0)
        background.anchorPoint = CGPoint(x: 0, y: 1.0)
            
        addChild(background)
        
        addChild(gameLayer)
        
        let gameBoard = SKSpriteNode(color: UIColor.whiteColor(), size: CGSizeMake(BlockSize * CGFloat(NumColumns), BlockSize * CGFloat(NumRows)))
        gameBoard.anchorPoint = CGPoint(x: 0, y: 1.0)
        gameBoard.position = LayerPosition
        
        shapeLayer.position = LayerPosition
        shapeLayer.addChild(gameBoard)
        gameLayer.addChild(shapeLayer)
        
        runAction(SKAction.repeatActionForever(SKAction.playSoundFileNamed("Sounds/theme.mp3", waitForCompletion: true)))

    }
    
    func playSound(sound:String) {
        runAction(SKAction.playSoundFileNamed(sound, waitForCompletion: false))
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
        clock.update()
        
        guard let lastTick = lastTick else {
            return
        }
        
        let timePassed = lastTick.timeIntervalSinceNow * -1000.0
        if timePassed > tickLengthMillis {
            self.lastTick = NSDate()
            tick?()
        }
    }
    
    func startTicking() {
        lastTick = NSDate()
    }
    
    func stopTicking() {
        lastTick = nil
    }
    
    func pointForColumn(column: Int, row: Int) -> CGPoint {
        let x = LayerPosition.x + (CGFloat(column) * BlockSize) + (BlockSize / 2)
        let y = LayerPosition.y - ((CGFloat(row) * BlockSize) + (BlockSize / 2))
        return CGPointMake(x, y)
    }
    
    func addPreviewShapeToScene(shape:Shape, completion:() -> ()) {
        for block in shape.blocks {
            
            // Determines color of the block
            let color = getUIColor(block.spriteName)
            
            let sprite = SKSpriteNode(color: color, size: CGSizeMake(BlockSize - 10, BlockSize - 10))
            sprite.position = pointForColumn(block.column, row: block.row - 2)
            shapeLayer.addChild(sprite)
            block.sprite = sprite
            
            // Animation
            sprite.alpha = 0
            let moveAction = SKAction.moveTo(pointForColumn(block.column, row: block.row), duration: NSTimeInterval(0.2))
            moveAction.timingMode = .EaseOut
            let fadeInAction = SKAction.fadeAlphaTo(0.7, duration: 0.4)
            fadeInAction.timingMode = .EaseOut
            sprite.runAction(SKAction.group([moveAction, fadeInAction]))
        }
        runAction(SKAction.waitForDuration(0.4), completion: completion)
    }
    
    func removePreviewShapesFromScene() {
        
        // dropFirst returns an array of typle SplicedArray, so we have to create a new SKNode array from each element of childrenArraySlice
        let childrenArraySlice = shapeLayer.children.dropFirst()
        var childrenArray : [SKNode]
        childrenArray = []
        
        for element in childrenArraySlice {
            childrenArray.append(element)
        }
        shapeLayer.removeChildrenInArray(childrenArray)
    
    }
    
    func movePreviewShape(shape:Shape, completion:() -> ()) {
        for block in shape.blocks {
            let sprite = block.sprite!
            let moveTo = pointForColumn(block.column, row:block.row)
            let moveToAction:SKAction = SKAction.moveTo(moveTo, duration: 0.2)
            moveToAction.timingMode = .EaseOut
            sprite.runAction(
                SKAction.group([moveToAction, SKAction.fadeAlphaTo(1.0, duration: 0.2)]), completion: {})
        }
        runAction(SKAction.waitForDuration(0.2), completion: completion)
    }
    
    func redrawShape(shape:Shape, completion:() -> ()) {
        for block in shape.blocks {
            let sprite = block.sprite!
            let moveTo = pointForColumn(block.column, row:block.row)
            let moveToAction:SKAction = SKAction.moveTo(moveTo, duration: 0.05)
            moveToAction.timingMode = .EaseOut
            if block == shape.blocks.last {
                sprite.runAction(moveToAction, completion: completion)
            } else {
                sprite.runAction(moveToAction)
            }
        }
    }
    
    // #1
    func animateCollapsingLines(linesToRemove: Array<Array<Block>>, fallenBlocks: Array<Array<Block>>, completion:() -> ()) {
        var longestDuration: NSTimeInterval = 0
        // #2
        for (columnIdx, column) in fallenBlocks.enumerate() {
            for (blockIdx, block) in column.enumerate() {
                let newPosition = pointForColumn(block.column, row: block.row)
                let sprite = block.sprite!
                // #3
                let delay = (NSTimeInterval(columnIdx) * 0.05) + (NSTimeInterval(blockIdx) * 0.05)
                let duration = NSTimeInterval(((sprite.position.y - newPosition.y) / BlockSize) * 0.1)
                let moveAction = SKAction.moveTo(newPosition, duration: duration)
                moveAction.timingMode = .EaseOut
                sprite.runAction(
                    SKAction.sequence([
                        SKAction.waitForDuration(delay),
                        moveAction]))
                longestDuration = max(longestDuration, duration + delay)
            }
        }
        
        for rowToRemove in linesToRemove {
            for block in rowToRemove {
                // #4
                let randomRadius = CGFloat(UInt(arc4random_uniform(400) + 100))
                let goLeft = arc4random_uniform(100) % 2 == 0
                
                var point = pointForColumn(block.column, row: block.row)
                point = CGPointMake(point.x + (goLeft ? -randomRadius : randomRadius), point.y)
                
                let randomDuration = NSTimeInterval(arc4random_uniform(2)) + 0.5
                // #5
                var startAngle = CGFloat(M_PI)
                var endAngle = startAngle * 2
                if goLeft {
                    endAngle = startAngle
                    startAngle = 0
                }
                let archPath = UIBezierPath(arcCenter: point, radius: randomRadius, startAngle: startAngle, endAngle: endAngle, clockwise: goLeft)
                let archAction = SKAction.followPath(archPath.CGPath, asOffset: false, orientToPath: true, duration: randomDuration)
                archAction.timingMode = .EaseIn
                let sprite = block.sprite!
                // #6
                sprite.zPosition = 100
                sprite.runAction(
                    SKAction.sequence(
                        [SKAction.group([archAction, SKAction.fadeOutWithDuration(NSTimeInterval(randomDuration))]),
                            SKAction.removeFromParent()]))
            }
        }
        // #7
        runAction(SKAction.waitForDuration(longestDuration), completion:completion)
    }
    
    func getUIColor(color: String) -> UIColor {
        
        switch color {
        case "blue":
            let r = BlueRed - (BlueRed - RedRed) / 2.0 * (Double(level) * 0.1)
            let g = BlueGreen - (BlueGreen - RedGreen) / 2.0 * (Double(level) * 0.1)
            let b = BlueBlue - (BlueBlue - RedBlue) / 2.0 * (Double(level) * 0.1)
            return UIColor(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: 1.0)
        case "red":
            let r = RedRed - (RedRed - BlueRed)/2.0 * (Double(level) * 0.1)
            let g = RedGreen - (RedGreen - BlueGreen)/2.0 * (Double(level) * 0.1)
            let b = RedBlue - (RedBlue - BlueBlue) / 2.0 * (Double(level) * 0.1)
            return UIColor(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: 1.0)
        default:
            return UIColor.blackColor()
        
        }
        
    }
}
