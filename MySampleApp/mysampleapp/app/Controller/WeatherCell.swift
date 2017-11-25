//
//  WeatherCell.swift
//  MySampleApp
//
//  Created by Kirk Washam on 10/21/17.
//

import UIKit

class WeatherCell: UITableViewCell {

    
    @IBOutlet weak var weatherIcon: UIImageView!
    
    @IBOutlet weak var dayLabel: UILabel!
    
    
    @IBOutlet weak var weatherType: UILabel!
    
    @IBOutlet weak var highTemp: UILabel!
    
    @IBOutlet weak var lowTemp: UILabel!
    
    
    func configureCell(forcast: Forcast) {
        
        lowTemp.text = "\(forcast.lowTemp)"
        highTemp.text = "\(forcast.highTemp)"
        weatherType.text = forcast.weatherType
        weatherIcon.image = UIImage(named: "\(forcast.weatherIcon)-s.png")
        dayLabel.text = forcast.date
        //backgroundColor = UIColor.clear
    }

    

}
