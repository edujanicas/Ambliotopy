//
//  GlobalVariables.swift
//  Ambliotopy
//
//  Created by Eduardo Janicas on 06/08/16.
//  Copyright © 2016 EN. All rights reserved.
//

import SpriteKit

var BlockSize:CGFloat = 40.0
var badEye: Eye?

let TickLengthCalibration = NSTimeInterval(3000)
let TickLengthLevelOne = NSTimeInterval(600)
let clock = Clock()
let contrast = Contrast()

let RedRed = 175.0
let RedGreen = 0.0
let RedBlue = 0.0
let BlueRed = 0.0
let BlueGreen = 150.0
let BlueBlue = 215.0

let NumberOfColors: UInt32 = 2
let NumOrientations: UInt32 = 4

let NumColumns = 10
let NumRows = 20

let StartingColumn = 4
let StartingRow = 0

let PreviewColumn = 12
let PreviewRow = 1

let PointsPerLine = 10
let LevelThreshold = 20

let defaults = NSUserDefaults.standardUserDefaults()

