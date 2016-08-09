//
//  Block.swift
//  Ambliotopy
//
//  Created by Eduardo Janicas and Nuno Fernandes on 25/06/16.
//  Copyright © 2016 EN. All rights reserved.
//

import SpriteKit

enum BlockColor: Int, CustomStringConvertible {
    
    case Blue = 0, Red
    
    var spriteName: String {
    switch self {
    case .Blue:
        return "blue"
    case .Red:
        return "red"
        }
    }
    
    var description: String {
    return self.spriteName
    }
    
    static func random() -> BlockColor {
        return BlockColor(rawValue:Int(arc4random_uniform(NumberOfColors)))!
    }
}

class Block: Hashable, CustomStringConvertible {
    // Constants
    let color: BlockColor
    
    // Variables
    var column: Int
    var row: Int
    
    // Lazy loading
    var sprite: SKSpriteNode?
    
    var spriteName: String {
    return color.description
    }
    
    var hashValue: Int {
    return self.column ^ self.row
    }
    
    var description: String {
    return "\(color) (\(column), \(row))"
    }
    
    init(column:Int, row:Int, color:BlockColor) {
        self.column = column
        self.row = row
        self.color = color
    }
}

func ==(lhs: Block, rhs: Block) -> Bool {
    return lhs.column == rhs.column && lhs.row == rhs.row && lhs.color.rawValue == rhs.color.rawValue
}
