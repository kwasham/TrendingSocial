//
//  WeatherVC.swift
//  MySampleApp
//
//  Created by Kirk Washam on 10/19/17.
//

import UIKit
import  Alamofire

class WeatherVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var currentTempLabel: UILabel!
    
    
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var currentWeatherImage: UIImageView!
    
    @IBOutlet weak var currentWeatherTypeLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
   
    var currentWeather = CurrentWeather()
    var forcast: Forcast!
    var forcasts = [Forcast]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        currentWeather = CurrentWeather()
       
        
        currentWeather.downloadWeatherDetails {
            self.downloadForcastData {
                self.updateMainUI()
            }
        }
    }
    
    func downloadForcastData(completed: @escaping DownloadComplete) {
        //Downloading our forcast weather data for tableview
        let forcastURL = URL(string: FORCAST_URL)
        Alamofire.request(forcastURL!).responseJSON { response in
            let result = response.result
            
            if let dict = result.value as? Dictionary <String, AnyObject> {
            
            if let list = dict["list"] as? [Dictionary<String, AnyObject>] {
                
                for obj in list {
                    let forcast = Forcast(weatherDict: obj)
                    self.forcasts.append(forcast)
                    print(obj)
                }
                }
            }
           completed()
            
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath)
        return cell
    }
    
    func updateMainUI() {
        dateLabel.text = currentWeather.date
        currentTempLabel.text = "\(currentWeather.currentTemp)"
        currentWeatherTypeLabel.text = currentWeather.weatherType
        locationLabel.text = currentWeather.cityName
        currentWeatherImage.image = UIImage(named: currentWeather.weatherType)
    }
    
}



