//
//  Location.swift
//  MySampleApp
//
//  Created by Kirk Washam on 10/22/17.
//


import CoreLocation




class Location {
    static var sharedInstance = Location()
    private init () {}
    
    var locationKey: Int! 
    var latitude: Double!
    var longitude: Double!
}
