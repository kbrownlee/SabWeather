//
//  MainViewController.swift
//  SabWeather
//
//  Created by Szabolcs Sztanyi on 20/01/15.
//  Copyright (c) 2015 ZappDesignTemplates. All rights reserved.
//

import UIKit
import CoreLocation

/**
    The mainview Controller to display all the locations' weather views.
*/

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, LocationHandlerProtocol
{
    /// label to display the current temperature
    @IBOutlet var temperatureLabel: ThemeChangerLabel!
    /// an icon to display the current weather's icon
    @IBOutlet var weatherIcon: UIImageView!
    /// a label to display the city's name
    @IBOutlet var cityLabel: ThemeChangerLabel!
    /// a label to display the current temperature format (°C, °F)
    @IBOutlet var tempFormatLabel: ThemeChangerLabel!
    /// a tableview to display the upcoming days' data
    @IBOutlet var daysTableView: UITableView!
    
    /// object to handle location events
    var locationHandler: LocationHandler = {
        var locationHandler = LocationHandler()
        return locationHandler
    }()
    
    /**
    * Creates a dateformatter, only once, to speed up performance
    * @return NSDateFormatter dateFormatter instance
    */
    var dateFormatter: NSDateFormatter = {
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MMMM dd"
        return dateFormatter
    }()
    
    /**
    * Creates a dayFormatter, only once, to speed up performance
    * @return NSDateFormatter dayFormatter instance
    */
    var dayFormatter: NSDateFormatter = {
        var dayFormatter = NSDateFormatter()
        dayFormatter.dateFormat = "EEEE"
        return dayFormatter
    }()
    
    /// a weather object to be displayed
    var weatherToDisplay: Weather?
    
    /**
    * Called after the view has been loaded. Customize the view and start getting the location
    * Add observers for custom notifications and update the weather views.
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        temperatureLabel.hidden = true
        tempFormatLabel.hidden = true
        customizeView()
        locationHandler.locationProtocol = self
        loadWeatherInformationForCurrentLocation()
    }
    
    /**
    * Refresh the view, if weather object is available, load the data from there, if not, download it from the server
    */
    func refreshView() {
        if let weather = weatherToDisplay
        {
            temperatureLabel.text = weather.currentDay?.temperatureString()
            tempFormatLabel.text = "°C"
            if let currentDay = weather.currentDay? {
                weatherIcon.image = UIImage.imageWith(currentDay.icon).imageWithRenderingMode(.AlwaysTemplate)
                weatherIcon.tintColor = .detailLabelColor()
            }
            daysTableView.reloadData()
        }
        else
        {
            loadWeatherInformationForCurrentLocation()
        }
        temperatureLabel.hidden = false
        tempFormatLabel.hidden = false
    }
    
    /**
    * Sets background and seperator colors for tableView and customizes the reload button
    */
    func customizeView() {
        daysTableView.tableFooterView = UIView(frame: CGRectZero)
        daysTableView.separatorColor = .lightLineColor()
    }
    
    // MARK: tableView methods
    /**
    * Asks the delegate about the height of the row at the given indexpath.
    * @param tableView A table-view object
    * @param indexPath An index path locating the row in tableView.
    */
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 61.0
    }
    
    /**
    * Asks the delegate about the number of rows in a section.
    * @param tableView A table-view object
    * @param section section
    * @return NSInteger number of rows
    */
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let weather = weatherToDisplay
        {
            return weather.sortedUpcomingDays().count
        }
        else
        {
            return 0
        }
    }
    
    /**
    * Configure the cell at the given indexpath, load the dayobject and fill in the labels with it's data.
    * @param tableView A table-view object
    * @param indexPath An index path
    * @return UITableViewCell cell to be returned
    */
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("WeatherCell") as WeatherCell

        if let weather = weatherToDisplay
        {
            let day = weather.sortedUpcomingDays()[indexPath.row]
            
            cell.dateLabel?.text = dateFormatter.stringFromDate(day.time)
            cell.dayLabel?.text = dayFormatter.stringFromDate(day.time)
            
            cell.temperatureLabel?.text = day.formattedTemperatureString()
            cell.iconImageView?.image = UIImage.imageWith(day.icon).imageWithRenderingMode(.AlwaysTemplate)
            cell.iconImageView?.tintColor = .detailLabelColor()
        }
        return cell
    }
    
    /**
    * Reload the weather information for the current location. Call the locationHandler and get the gps data.
    */
    func loadWeatherInformationForCurrentLocation() {
        let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        hud.labelText = NSLocalizedString("GETTING_LOCATION_HUD", comment: "")
        locationHandler.startLocationUpdate()
    }
    
    /**
    * A method to hide the progress HUD
    */
    func hideProgressHUD() {
        MBProgressHUD.hideHUDForView(view, animated: true)
    }
    
    /// MARK - location handler methods
    /**
    * Once Location manager gets a location data, start downloading the weather information and parse it accordingly.
    * @param location current location data.
    */
    func locationDetected(location: CLLocation) {
        let hud = MBProgressHUD(forView: self.view)
        hud.labelText = NSLocalizedString("LOADING_WEATHER_HUD", comment: "")
        downloadCurrentWeatherForLocation(location)
    }
    
    /**
    * An error occured while getting location data
    * @param error error to display
    */
    func locationDiscoveryFailed(error: NSError) {
        hideProgressHUD()
        let alertView = UIAlertView(title: NSLocalizedString("error_occured", comment: ""), message: error.localizedDescription, delegate: nil, cancelButtonTitle: NSLocalizedString("Ok", comment: ""))
        alertView.show()
    }
    
    /// MARK - networking methods
    /**
        Downloads the weather information for the passed in location
        :param: location location object to get the data for
    */
    func downloadCurrentWeatherForLocation(location: CLLocation) {
        let weatherAPIClient = WeatherAPIClient()
        weatherAPIClient.downloadCurrentWeatherInformationForLocation(location.coordinate, successBlock: { (weather) -> () in
            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                self.hideProgressHUD()
                self.weatherToDisplay = weather
                self.refreshView()
            })
            }) { (error) -> () in
            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                self.hideProgressHUD()
                let alertView = UIAlertView(title: NSLocalizedString("error_occured", comment: ""), message: error.localizedDescription, delegate: nil, cancelButtonTitle: NSLocalizedString("Ok", comment: ""))
                alertView.show()
            })
        }
    }
    
    /**
    * Returns the preffered statusbar style for the app.
    * @return UIStatusBarStyle preferred statusbarStyle
    */
    override func preferredStatusBarStyle() -> UIStatusBarStyle{
        return .LightContent;
    }
    
}