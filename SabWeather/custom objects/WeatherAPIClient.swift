//
//  WeatherAPIClient.swift
//  SabWeather
//
//  Created by Szabolcs Sztanyi on 20/01/15.
//  Copyright (c) 2015 ZappDesignTemplates. All rights reserved.
//

import Foundation
import CoreLocation

/**
* Communicates with the forecast.io API
*/

class WeatherAPIClient {
    
    /// base URL for the request
    let baseURL = "https://api.forecast.io/forecast"
    
    //WARNING Replace it with your own APIKEY from developer.forecast.io
    /// API KEY for forecast.io (needs registration - free)
    let APIKEY = "c162e432d0019257c2d61b15c32c3b52"
    
    /**
    * Calls the forecast.io's API and downloads the data for the passed coordinate object.
    * @param coordinate coordinate to download the data for
    * @param successBlock call this block if download was successful
    * @param failureBlock call this block if a failure happened, no network, etc.
    */
    func downloadCurrentWeatherInformationForLocation(coordinate: CLLocationCoordinate2D, successBlock: (weather: Weather) -> (), failureBlock: (error: NSError) -> ()) {
        
        let path = "\(baseURL)/\(APIKEY)/\(coordinate.latitude),\(coordinate.longitude)" as NSString
        
        let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
        
        let request = NSURLRequest(URL: NSURL(string: path)!)
        let task = session.dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
            if error != nil
            {
                failureBlock(error: error)
            }
            else
            {
                let dictionary = NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments, error: nil) as NSDictionary
                let weather: Weather = WeatherParser.parseWeatherJSON(dictionary)
                successBlock(weather: weather)
            }
        })
        task.resume()
    }
}