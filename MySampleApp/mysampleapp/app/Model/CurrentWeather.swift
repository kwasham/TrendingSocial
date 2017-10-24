//
//  CurrentWeather.swift
//  MySampleApp
//
//  Created by Kirk Washam on 10/20/17.
//

import UIKit
import Alamofire

class CurrentWeather {
    var _cityName: String!
    var _date: String!
    var _weatherType: String!
    var _currentTemp: Double!
    var _currentLocation: String!
    var _locationKey: Int!
    
    
    var locationKey: Int {
        if _locationKey==nil {
            _locationKey = 0
        }
        return _locationKey
    }
    
    
    var cityName: String {
        if _cityName == nil {
            _cityName = ""
        }
        return _cityName
    }
    
    var date: String {
        if _date == nil {
            _date = ""
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        let currentDate = dateFormatter.string(from: Date())
        self._date = "Today, \(currentDate)"
        return _date
    }
    
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
    }
    
    var currentTemp: Double {
        if _currentTemp == nil {
            _currentTemp = 0.0
        }
        return _currentTemp
    }
    
    func downloadCurrentLocation(completed: @escaping DownloadComplete) {
        Alamofire.request(CURRENT_LOCATION_URL).responseJSON { response in
            let result = response.result
            print(result.value)
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                if let importedLocationKey = dict["Key"] as? String {
                    let myString2 = importedLocationKey
                    let myInt2 = (myString2 as NSString).integerValue
                   //
                    self._locationKey = myInt2
                   Location.sharedInstance.locationKey = myInt2
                    print("KIRK: \(myInt2)")
                }
                if let name = dict["LocalizedName"] as? String {
                    self._cityName = name.capitalized
                   // print(self._cityName)
                }
            }
            
        completed()
        
    }
    }
    
    
    func downloadWeatherDetails(completed: @escaping DownloadComplete) {
        //Download Current Weather Data
        Alamofire.request(CURRENT_WEATHER_URL).responseJSON { response in
            let result = response.result
       //print(result.value)
            if let dict = result.value as? [Dictionary<String, AnyObject>] {
                
               
                
                if let temp = dict[0]["Temperature"] as? Dictionary<String, AnyObject> {
                    
                    if let imperial = temp["Imperial"] as? Dictionary<String, AnyObject> {
                        if let value = imperial["Value"] as? Double {
                        
                        self._currentTemp = value
                        print(self._currentTemp)
                    }
                }
            }
                if let weather =  dict[0]["WeatherText"] as? String {
                    self._weatherType = weather
                    
                }
                
//                if let main = dict["main"] as? Dictionary<String, AnyObject> {
//
//                    if let currentTemperature = main["temp"] as? Double {
//
//                        let kelvinToFarenheitPreDivision = (currentTemperature * (9/5) - 459.67)
//
//                        let kelvinToFarenheit = Double(round(10 * kelvinToFarenheitPreDivision/10))
//
//                        self._currentTemp = kelvinToFarenheit
//                        print(self._currentTemp)
//                    }
//                }
            }
            completed()
        }
    }
}



