 //
//  AppDelegate.swift
//  SabWeather
//
//  Created by Szabolcs Sztanyi on 20/01/15.
//  Copyright (c) 2015 ZappDesignTemplates. All rights reserved.
//

import UIKit

/**
Application's appDelegate that is responsible for loading the application.
*/

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    /// window of the app
    var window: UIWindow?
    
    /**
    * Adds a check to every app opening not to forget that the app needs an API key to forecast.io and a username to geonames. Both of these services are free.
    * @param application The singleton app object.
    */
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
        // WARNING: REMOVE THESE CHECKS - when you adjusted Constants.m class
        let weatherAPIClient: WeatherAPIClient = WeatherAPIClient()
        
        if weatherAPIClient.APIKEY == ""
        {
            let alertView = UIAlertView(title: "Error, no API key", message: "You forgot to add your forecast.io API key", delegate: nil, cancelButtonTitle: "Cancel")
            alertView.show()
            return false
        }
        return true
    }
}