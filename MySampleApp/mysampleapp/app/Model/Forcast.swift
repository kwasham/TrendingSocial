//
//  Forcast.swift
//  MySampleApp
//
//  Created by Kirk Washam on 10/20/17.
//

import UIKit
import Alamofire

class Forcast {
    
    var _date: String!
    var _weatherType: String!
    var _highTemp: Double!
    var _lowTemp: Double!
    
    var date: String {
        if _date == nil {
            _date = "Date"
       }
        return _date
    }
    
    var weatherType : String {
        if _weatherType == nil {
            _weatherType = "No Type"
        }
        return _weatherType
    }
    
    var highTemp: Double {
        if _highTemp == nil {
            _highTemp = 54
        }
        return _highTemp
        
    }
    
    var lowTemp: Double {
        if _lowTemp == nil {
            _lowTemp = 17
        }
        return _lowTemp
    }
    
    

    init(weatherDict: Dictionary<String, AnyObject>) {

            
        if let temp = weatherDict["Temperature"] as? Dictionary<String, AnyObject> {
            if let min = temp["Minimum"] as? Dictionary<String, AnyObject> {
                if let value = min["Value"] as? Double {
                    self._lowTemp = value
                }
            }

        }


            if let temp = weatherDict["Temperature"] as? Dictionary<String, AnyObject> {
                if let max = temp["Maximum"] as? Dictionary<String, AnyObject> {
                    if let value = max["Value"] as? Double {
                        self._highTemp = value
                    }
                }
            }


            if let weatherType = weatherDict["Day"] as? Dictionary<String, AnyObject> {
                if let weatherPhrase = weatherType["IconPhrase"] as? String {

                        self._weatherType = weatherPhrase
                    }
                }


        if let date = weatherDict["EpochDate"] as? Double {
            let unixConvertedDate = Date(timeIntervalSince1970: date)
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .full
            dateFormatter.dateFormat = "EEEE"
            dateFormatter.timeStyle = .none
            self._date = unixConvertedDate.dayOfTheWeek()
        }
        }

    }


extension Date {
    func dayOfTheWeek() -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }


}


