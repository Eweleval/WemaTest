//
//  WeatherResource.swift
//  WemaTest
//
//  Created by Wellz Val on 6/3/24.
//

import Foundation

protocol WeatherProtocol{
    func getWeatherData(completion: @escaping(Result<WeatherModel, UserError>) -> Void)
}

struct WeatherResource: WeatherProtocol {
    private var httpUtility: UtilityService
    private var urlString: String
    
    init(httpUtility: UtilityService = HTTPUtility(),
         urlString: String){
        self.httpUtility = httpUtility
        self.urlString = urlString
    }
    
    func getWeatherData(completion: @escaping(Result<WeatherModel, UserError>) -> Void){
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL("")))
            return
        }
        
        httpUtility.performDataTask(url: url, resultType: WeatherModel.self) { result in
            switch result {
            case .success(let jsonData):
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            case .failure(let error):
                completion(.failure(error))
            }
            
        }
    }
}
