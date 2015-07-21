//
//  UIColorExtension.swift
//  SabWeather
//
//  Created by Szabolcs Sztanyi on 20/01/15.
//  Copyright (c) 2015 ZappDesignTemplates. All rights reserved.
//

import UIKit

/**
* Custom category of UIColor to load the custom colors according to the selected themes.
*/

extension UIColor {
    
    /// useful macros
    class func rgbColor(red r: Float, green g: Float, blue b: Float) -> UIColor {
        return UIColor(red: CGFloat(r/255.0), green: CGFloat(g/255.0), blue: CGFloat(b/255.0), alpha: 1.0)
    }
    
    /**
    * Color for the separator lines bottom part (placed on top of the cell)
    * @return UIColor color to use
    */
    class func lightLineColor() -> UIColor {
        return UIColor.rgbColor(red: 50.0, green: 50.0, blue: 50.0)
    }
    
    // MARK - label colors
    /**
    * Color for detail label in the cell
    * @return UIColor color to use
    */
    class func detailLabelColor() -> UIColor {
        return UIColor.rgbColor(red: 50.0, green: 50.0, blue: 50.0)
    }
    
    /**
    * Color for the main labels like temperature
    * @return UIColor color to use
    */
    class func mainLabelColor() -> UIColor {
        return UIColor.rgbColor(red: 26.0, green: 26.0, blue: 26.0)
    }
}
