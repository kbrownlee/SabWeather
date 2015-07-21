//
//  WeatherParser.swift
//  SabWeather
//
//  Created by Szabolcs Sztanyi on 20/01/15.
//  Copyright (c) 2015 ZappDesignTemplates. All rights reserved.
//

import Foundation

/**

    An object to parse the results of the WeatherAPIClient object

*/

class WeatherParser: NSObject {
    /**
    * Parses the passed in JSON to a weather object
    * @param JSON json to be parsed
    * @return Weather weather object to return
    */
    class func parseWeatherJSON(dictionary: NSDictionary) -> Weather {
        let currentDaysInformation = dictionary["currently"] as NSDictionary
        let currentDay = createDayObjectFromDictionary(currentDaysInformation)
        
        // add the other days to the Weather object
        let dailyDictionary = dictionary["daily"] as NSDictionary
        var rawUpcomingDays = dailyDictionary["data"] as [Dictionary<String, AnyObject>]
        
        var upcomingDays = [Day]()
        for dictionary in rawUpcomingDays {
            let newDay = createDayObjectFromDictionary(dictionary as NSDictionary) as Day
            upcomingDays.append(newDay)
        }
        let weather = Weather(currentDay: currentDay, upcomingDays: upcomingDays)
        return weather;
    }
    
    /**
    * Creates a Day object from the passed in dictionary, save it to Core Data and return it so for later use.
    * @param dictionary dictionary that has all the keys and object for the Day object
    * @return Day day object that was created
    */
    class func createDayObjectFromDictionary(dictionary: NSDictionary) -> Day {
        let interval = dictionary["time"] as Double
        let time = NSDate(timeIntervalSince1970: interval) as NSDate
        
        let temperature = dictionary["temperature"] as? NSNumber
        let temperatureMin = dictionary["temperatureMin"] as? NSNumber
        let temperatureMax = dictionary["temperatureMax"] as? NSNumber
        let icon = dictionary["icon"] as NSString
        
        let day = Day(time: time, temperature: temperature, temperatureMax: temperatureMax, temperatureMin: temperatureMin, iconName: icon)
        return day
    }
}