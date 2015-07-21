//
//  ThemeChangerLabel.swift
//  SabWeather
//
//  Created by Szabolcs Sztanyi on 20/01/15.
//  Copyright (c) 2015 ZappDesignTemplates. All rights reserved.
//

import Foundation

/**
* Custom label class to have a drop shadow under the labels.
*/

class ThemeChangerLabel: UILabel {
    
    /**
    * Set a custom drop shadow under itself, according to which theme is selected
    */
    override func awakeFromNib() {
        super.awakeFromNib()
        textColor = .mainLabelColor()
    }
}