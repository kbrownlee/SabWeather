//
//  Weather.swift
//  SabWeather
//
//  Created by Szabolcs Sztanyi on 20/01/15.
//  Copyright (c) 2015 ZappDesignTemplates. All rights reserved.
//

import Foundation

/**
* Weather object
*/

class Weather: NSObject {
    
    /// date for the last update
    var lastUpdated: NSDate?
    /// the current day object
    var currentDay: Day?
    /// an array of the upcoming day objects
    var upcomingDays: [Day] = [Day]()
    /// NSArray of Days object sorted by time
    private var sortedDays: [Day]?
    
    init(currentDay: Day, upcomingDays: [Day]) {
        super.init()
        self.upcomingDays = upcomingDays
        lastUpdated = NSDate()
        self.currentDay = currentDay
    }
    
    /**
        Sorts the upcoming Days objects by time and returns an array
        :return: NSArray sorted upcoming Days objects
    */
    func sortedUpcomingDays() -> [Day] {
        if var sortedArrayDays = sortedDays
        {
            return upcomingDays
        }
        else
        {
            var days: [Day] = upcomingDays
            days.sort({ (day0:Day, day1:Day) -> Bool in
                return day0.time.timeIntervalSinceNow > day1.time.timeIntervalSinceNow
            })
            sortedDays = days
            return sortedDays!
        }
    }
}