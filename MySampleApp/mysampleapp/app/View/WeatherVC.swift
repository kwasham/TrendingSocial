//
//  WeatherVC.swift
//  MySampleApp
//
//  Created by Kirk Washam on 10/19/17.
//

import UIKit
import CoreLocation
import Alamofire

class WeatherVC: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {

    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var currentTempLabel: UILabel!
    
    
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var currentWeatherImage: UIImageView!
    
    @IBOutlet weak var currentWeatherTypeLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    var locationKey: Int!
    var currentWeather = CurrentWeather()
    var forcast: Forcast!
    var forcasts = [Forcast]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
        
        tableView.delegate = self
        tableView.dataSource = self
        currentWeather = CurrentWeather()
        
      
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       
        
        locationAuthStatus()
    }
    
    func locationAuthStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            currentLocation = locationManager.location
            
            
            Location.sharedInstance.latitude = currentLocation.coordinate.latitude
            Location.sharedInstance.longitude = currentLocation.coordinate.longitude
            
            
                
            
                currentWeather.downloadCurrentLocation {
                
                   
                self.currentWeather.downloadWeatherDetails {
                    
                    
                  
                    self.downloadForcastData {
                    self.updateMainUI()
                        
                    }
                }
                
            }
            
           
            
            
            print(Location.sharedInstance.latitude, Location.sharedInstance.longitude)
        }else{
            locationManager.requestWhenInUseAuthorization()
            locationAuthStatus()
        }
    }
    
    
    func downloadForcastData(completed: @escaping DownloadComplete) {
        //Downloading our forcast weather data for tableview
        
        Alamofire.request(FORCAST_URL).responseJSON { response in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String , AnyObject> {
                print(result.value!)
            
                if let dailyForcasts = dict["DailyForecasts"] as? [Dictionary <String , AnyObject>] {
                
                for obj in dailyForcasts {
                   
                    let forcast = Forcast(weatherDict: obj)
                    self.forcasts.append(forcast)
                   
                }
                //self.forcasts.remove(at: 0)
                self.tableView.reloadData()
                }
            }
           completed()
        }
    
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forcasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? WeatherCell {
            
            let forcast = forcasts[indexPath.row]
          
        cell.configureCell(forcast: forcast)
        return cell
        
        }else{
            return WeatherCell()
        }
        
    }
    
    func updateMainUI() {
        dateLabel.text = currentWeather.date
        currentTempLabel.text = "\(currentWeather.currentTemp)"
        currentWeatherTypeLabel.text = currentWeather.weatherType
        locationLabel.text = currentWeather.cityName
        currentWeatherImage.image = UIImage(named: currentWeather.weatherType)
    }
    
}



