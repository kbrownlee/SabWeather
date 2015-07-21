//
//  Day.swift
//  SabWeather
//
//  Created by Szabolcs Sztanyi on 20/01/15.
//  Copyright (c) 2015 ZappDesignTemplates. All rights reserved.
//

import Foundation

class Day: NSObject {
    
    /// icon for the current weather
    var icon: NSString!
    /// temperature
    var temperature: NSNumber!
    /// maximum temperature
    var temperatureMax: NSNumber!
    /// minimum temperature
    var temperatureMin: NSNumber!
    /// time
    var time: NSDate!
    
    init(time: NSDate, temperature: NSNumber?, temperatureMax: NSNumber?, temperatureMin: NSNumber?, iconName: NSString) {
        super.init()
        icon = iconName
        self.time = time
        self.temperatureMin = temperatureMin
        self.temperatureMax = temperatureMax
        self.temperature = temperature
    }
    
    /**
    * Return the temperature.
    * @return NSString temperature in a string according to the selected temperature format.
    */
    func temperatureString() -> NSString {
        return formattedTemperatureFromTempValue(temperature.floatValue)
    }
    
    /**
    * Returns a formatter temperature string with high and low strings.
    * @return NSString formatter temperature string
    */
    func formattedTemperatureString() -> NSString {
        let maxTemp = maxTemperatureString()
        let minTemp = minTemperatureString()
        return "\(minTemp)°  \(maxTemp)°"
    }

    /**
    * Converts fahrenheit to celsius
    * @param fahrenheit fahrenheit value to be converted
    * @return Float celius value of fahrenheit
    */
    private func celsiusFromFahrenheit(fahrenheit: Float) -> Float {
        return (fahrenheit - 32) / 1.8
    }

    /**
    * Creates a celius value from the passed in temperatureValue
    * @param temperatureValue temperatureValue to be used or to be converted
    * @return NSString the converted temperature value
    */
    private func formattedTemperatureFromTempValue(temperatureValue: Float) -> NSString {
        let temp = celsiusFromFahrenheit(temperatureValue) as Float
        return NSString(format: "%.0f", temp)
    }
    
    /**
    * Return the minimum temperature.
    * @return NSString minimum temperature in a string according to the selected temperature format.
    */
    private func minTemperatureString() -> NSString {
        return formattedTemperatureFromTempValue(temperatureMin.floatValue)
    }
    
    /**
    * Return the maximum temperature.
    * @return NSString maximum temperature in a string according to the selected temperature format.
    */
    private func maxTemperatureString() -> NSString {
        return formattedTemperatureFromTempValue(temperatureMax.floatValue)
    }
}