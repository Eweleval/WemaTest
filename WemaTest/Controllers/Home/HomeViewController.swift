//
//  HomeViewController.swift
//  WemaTest
//
//  Created by Wellz Val on 6/3/24.
//

import UIKit

class HomeViewController: UIViewController{
   
    
    @IBOutlet weak var searchField: UITextField!
    let userDefaults: UserDefaults = .standard
    var error: String?
    @IBOutlet weak var errorField: UILabel!
   
    let weatherModel = WeatherViewModel()
    var weatherData: WeatherModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        view.backgroundColor = .systemBlue
        
        weatherModel.delegate = self
        searchField.delegate = self
        
        if let favCity = userDefaults.string(forKey: "favCity"), !favCity.isEmpty{
            searchField.text = favCity
        }
    }
    
    @IBAction func check(_ sender: Any) {
        if searchField.text != "" {
        if let city = searchField.text {
            weatherModel.getCityName(cityName: city)
        }
        DispatchQueue.main.async {
            self.weatherModel.receiveData()
        }}
    }
}
