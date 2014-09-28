//
//  Current.swift
//  SwiftCuaca
//
//  Created by Ashari on 9/25/14.
//  Copyright (c) 2014 sabakLab. All rights reserved.
//

import Foundation

struct Current{
    
    var currentTime: String?
    var temperature: Int
    var humidity: Double
    var precipProbability: Double
    var summary: String
    var icon: String
    // penggunaan ? agar kita tidak perlu memberikan nilai ini atau initialisation
    // atau nilai awal
    
    init(weatherDictionary : NSDictionary) {
        let currentWeather = weatherDictionary["currently"] as NSDictionary
        
        temperature = currentWeather["temperature"] as Int
        humidity = currentWeather["humidity"] as Double
        precipProbability = currentWeather["precipProbability"] as Double
        summary = currentWeather["summary"] as String
        icon = currentWeather["icon"] as String
        
        let currentTimeIntValue = currentWeather["time"] as Int
        
        currentTime = dateStringFromUnixtime(currentTimeIntValue)
    }
    
    func dateStringFromUnixtime(unixTime: Int) -> String {
        let timeInSeconds = NSTimeInterval(unixTime)
        let weatherDate = NSDate(timeIntervalSince1970: timeInSeconds)
        let dateFormatter = NSDateFormatter()
        dateFormatter.timeStyle = .ShortStyle
        
        return dateFormatter.stringFromDate(weatherDate)
        
    }
}


