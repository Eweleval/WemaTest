//
//  WeatherResource.swift
//  WemaTest
//
//  Created by Wellz Val on 6/3/24.
//

import Foundation

protocol WeatherProtocol {
    func getWeatherData() async throws -> WeatherModel
}

struct WeatherResource: WeatherProtocol {
    private var httpUtility: UtilityService
    private var urlString: String
    
    init(httpUtility: UtilityService = HTTPUtility(), urlString: String) {
        self.httpUtility = httpUtility
        self.urlString = urlString
    }
    
    func getWeatherData() async throws -> WeatherModel {
        guard let url = URL(string: urlString) else {
            throw UserError.invalidURL()
        }
        
        let weatherData: WeatherModel = try await httpUtility.performDataTask(url: url, resultType: WeatherModel.self)
        return weatherData
    }
}
