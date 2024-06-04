//
//  WeatherViewModel.swift
//  WemaTest
//
//  Created by Wellz Val on 6/3/24.
//

import Foundation

protocol WeatherDataDelegate: AnyObject{
    func receiveData(_ data: WeatherModel)
    func errorhandler(_ data: UserError)
}

class WeatherViewModel {
    weak var delegate: WeatherDataDelegate?
    
    public var weatherResource: WeatherProtocol?
    
    func getCityName(cityName: String) {
        let urlString = "\(Link.currentLink)\(API.id)\(API.lock)\(Units.id)\(Units.celcius)\(Cities.id)\(cityName)"
        weatherResource = WeatherResource(urlString: urlString)
    }
    
    func receiveData() {
        weatherResource?.getWeatherData { [weak self] result in
            switch result {
            case .success(let listOf):
                self?.delegate?.receiveData(listOf)
            case .failure(let error):
                self?.delegate?.errorhandler(error)
            }
        }
    }
}
