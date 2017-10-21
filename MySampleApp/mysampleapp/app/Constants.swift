//
//  Constants.swift
//  MySampleApp
//
//  Created by Kirk Washam on 10/20/17.
//

import Foundation



let BASE_URL = "http://api.openweathermap.org/data/2.5/weather?"
let LATITUDE = "lat="
let LONGITUDE = "&lon="
let APP_ID = "&appid="
let API_KEY = "a57dfc06a41dc99adb90e3de286f6b32"

typealias DownloadComplete = () -> ()

let CURRENT_WEATHER_URL =  "\(BASE_URL)\(LATITUDE)35\(LONGITUDE)139\(APP_ID)\(API_KEY)"
let FORCAST_URL = "http://api.openweathermap.org/data/2.5/forecast?lat=35&lon=139&appid=a57dfc06a41dc99adb90e3de286f6b32"


