//
//  WeatherModel.swift
//  WemaTest
//
//  Created by Wellz Val on 6/3/24.
//

import Foundation

// MARK: - WeatherModel
struct WeatherModel: Codable {
    let weather: [CurrentWeather]
    let main: CurrentMain
    let name: String
    
}

// MARK: - Main
struct CurrentMain: Codable {
    let temp, feelsLike, tempMin, tempMax: Double

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}

// MARK: - Weather
struct CurrentWeather: Codable {
    let id: Int
    let main, weatherDescription, icon: String

    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}
