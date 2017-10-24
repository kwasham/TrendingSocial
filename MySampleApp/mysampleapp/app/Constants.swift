//
//  Constants.swift
//  MySampleApp
//
//  Created by Kirk Washam on 10/20/17.
//

import Foundation



let BASE_URL = "http://api.openweathermap.org/data/2.5/weather?"
let LATITUDE = (Location.sharedInstance.latitude!)
let LONGITUDE = (Location.sharedInstance.longitude!)
let LOCATION = (Location.sharedInstance.locationKey!)
let APP_ID = "&appid="
let API_KEY = "a57dfc06a41dc99adb90e3de286f6b32"

typealias DownloadComplete = () -> ()

//let CURRENT_WEATHER_URL =  "\(BASE_URL)lat=\(LATITUDE)&lon=\(LONGITUDE)\(APP_ID)\(API_KEY)"
let CURRENT_WEATHER_URL =  "http://dataservice.accuweather.com/currentconditions/v1/\(LOCATION)?apikey=Ie6yeG9ij659FVe2RZGEhRkgAwgSm1rE"

let CURRENT_LOCATION_URL = "http://dataservice.accuweather.com/locations/v1/cities/geoposition/search?apikey=Ie6yeG9ij659FVe2RZGEhRkgAwgSm1rE&q=\(Location.sharedInstance.latitude!)%2C%20\(Location.sharedInstance.longitude!)"

let FORCAST_URL = "http://dataservice.accuweather.com/forecasts/v1/daily/5day/\(LOCATION)?apikey=Ie6yeG9ij659FVe2RZGEhRkgAwgSm1rE"


