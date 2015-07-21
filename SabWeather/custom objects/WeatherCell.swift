//
//  WeatherCell.swift
//  SabWeather
//
//  Created by Szabolcs Sztanyi on 20/01/15.
//  Copyright (c) 2015 ZappDesignTemplates. All rights reserved.
//

import UIKit

/**
A custom cell to display the upcoming days' weather information in a tableview.
*/

class WeatherCell: UITableViewCell {
  
    /// icon for the given weather (sunny, rainy, etc.)
    @IBOutlet var iconImageView: UIImageView?
    /// label to display the temperature values (high and low)
    @IBOutlet var temperatureLabel: UILabel?
    /// a label to display the date of that day (26 may)
    @IBOutlet var dateLabel: UILabel?
    /// a label to display which day is it about (Monday, Tuesday, etc.)
    @IBOutlet var dayLabel: UILabel?
    
    /**
        After loading the cell from the nib file, add these modifications too.
        Basically, what it does, that it calls the custom UIColor category methods and modifies the colors according to the selected theme.
    */
    override func awakeFromNib() {
        dayLabel?.textColor = .mainLabelColor()
        dateLabel?.textColor = .detailLabelColor()
        temperatureLabel?.textColor = .mainLabelColor()
    }
}