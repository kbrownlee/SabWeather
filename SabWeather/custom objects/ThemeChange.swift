//
//  ThemeChange.swift
//  SabWeather
//
//  Created by Szabolcs Sztanyi on 20/01/15.
//  Copyright (c) 2015 ZappDesignTemplates. All rights reserved.
//

import UIKit

/**
* Custom category of UIIMage to load the proper images for the given string
*/

extension UIImage {
    
    /**
    * Loads the required image for the passed in name for the selected theme, adds the string after the image name. So, if dark theme is selected,
    * and I want to load the file called "sunny" it will look for the current theme's name and puts the "Dark" string after the filename,
    * so the final UIImage will load the file called: "sunnyDark.png". This way you don't need millions of if statements everywhere, just here.
    * @param name name for the file to be used.
    * @return UIImage image to be returned
    */
    class func imageWith(name: NSString) -> UIImage {
        let fileName = "\(name)Orange" as NSString
        return UIImage(named: fileName)!
    }
}