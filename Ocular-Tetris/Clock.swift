//
//  Clock.swift
//  Ocular-Tetris
//
//  Created by Eduardo Janicas on 07/07/16.
//  Copyright © 2016 EN. All rights reserved.
//

import Foundation

class Clock {
    
    var gameTime:Int // gameTime on the current day
    var tick:NSDate  // Each date and hour of the call to clock
    var timer:NSTimeInterval  // The timer retains the elapsed time since the last tick
    var dates:[String: AnyObject]? // Dates is a dictionary of type ["YYYY-MM-DD" : timeInSeconds]
    var today:String // The current day
    
    init() {
        
        dates = defaults.dictionaryForKey("dates") // When initializing the clock, it first checks the memory to see if older usage data is found
        
        timer = 0  // The timer starts as 0
        tick = NSDate()  // Saves the time the clock was created
        today = String(tick).componentsSeparatedByString(" ")[0] // To check the current day we ramove the first part of tick as string (It gives the date)
        
        // If there wasn't older data (First time the app is used) we initialize the dictionary and the gameTime
        guard let unwrapeDates = dates else {
            dates = [today: 0]
            gameTime = 0
            return
        }
        
        // If there was older data but not from the current day, we add the current day to the dictionary and start the gameTime
        if (unwrapeDates[today] == nil) {
            dates?.updateValue(0, forKey: today)
            gameTime = 0
        }
            
        // Else, the game was already played on the current day and gameTime is initialized as the ammount of time played
        else {
            gameTime = unwrapeDates[today] as! Int
        }
        
    }
    
    func update() {
        
        // The timer retains the elapsed time since the last tick
        timer = tick.timeIntervalSinceNow * -1000.0
        if ((timer - 1000) > 0) { // If over a second passed
            tick = NSDate()       // New tick
            gameTime += 1         // 1 second added to the gameTime
            dates?.updateValue(gameTime, forKey: today)
            defaults.setObject(dates, forKey: "dates") // Saves the game time for future use
            print(dates!)
            
        }
        
    }
    
    func daysPlayed() -> ([String], [Double]) {
        
        var daysPlayed: [String] = []
        var timePlayed: [Double] = []
        
        for (key, _) in dates! {
                daysPlayed.append(key as String)
        }
        
        daysPlayed.sortInPlace()
        
        for day in daysPlayed {
            timePlayed.append((dates![day] as! Double))
        }
        
        return (daysPlayed, timePlayed)
    }
}
