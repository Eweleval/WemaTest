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
        Task {
            do {
                guard let weatherResource = weatherResource else { return }
                let weatherData: WeatherModel = try await weatherResource.getWeatherData()
                DispatchQueue.main.async {
                    self.delegate?.receiveData(weatherData)
                }
            } catch let error as UserError {
                DispatchQueue.main.async {
                    self.delegate?.errorhandler(error)
                }
            } 
            catch {
                DispatchQueue.main.async {
                    self.delegate?.errorhandler(.unknownError(error.localizedDescription))
                }
            }
        }
    }
}
