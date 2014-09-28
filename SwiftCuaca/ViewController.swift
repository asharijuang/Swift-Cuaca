//
//  ViewController.swift
//  SwiftCuaca
//
//  Created by Ashari on 9/24/14.
//  Copyright (c) 2014 sabakLab. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // Api key dari forecast.io registrasi untuk mendapatkan key
    private let apiKey = "99e2220720a202ad324194b14866c54e"
    // kondisi ketika pertama kali aplikasi di load
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let baseURL = NSURL(string: "https://api.forecast.io/forecast/\(apiKey)/")
        let forecastURL = NSURL(string: "-7.773565,110.366703", relativeToURL: baseURL)
        // Menyimpan
        let sharedSession = NSURLSession.sharedSession()
        // download task dan kondisi setelah  selesai download
        let downloadTask: NSURLSessionDownloadTask = sharedSession.downloadTaskWithURL(forecastURL, completionHandler: { (location: NSURL!,response: NSURLResponse!,error: NSError!) -> Void in
            
            if (error == nil){
                let dataObject = NSData(contentsOfURL: location)
                let weatherDictionary: NSDictionary = NSJSONSerialization.JSONObjectWithData(dataObject, options: nil, error: nil) as NSDictionary
                
                let currentWeather = Current(weatherDictionary: weatherDictionary)
                println(currentWeather.currentTime)
                
            }else {
                let networkIssueController = UIAlertController(title: "Error", message: "Unable to load data. Connectivity error!", preferredStyle: .Alert)
        
                let okButton = UIAlertAction(title: "OK", style: .Default, handler: nil)
                networkIssueController.addAction(okButton)
                
                let cancelButton = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
                networkIssueController.addAction(cancelButton)
                
                self.presentViewController(networkIssueController, animated: true, completion: nil)
                
            }
        })
        // Menjalankan downloadTask
        downloadTask.resume()
         
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

