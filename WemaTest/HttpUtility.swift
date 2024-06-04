//
//  HttpUtility.swift
//  WemaTest
//
//  Created by Wellz Val on 6/3/24.
//

import Foundation

enum UserError: Error {
    case invalidURL(String = "Invalid URL")
    case noDataAvailable(String = "No data received from server.")
    case cannotProcessData(String = "Freedom")
    case unknownError(String = "An unknown error occurred.")
    case apiError(String)
    
    var localizedDescription: String {
        switch self {
        case .invalidURL(let message):
            return message
        case .noDataAvailable(let message):
            return message
        case .cannotProcessData(let message):
            return message
        case .unknownError(let message):
            return message
        case .apiError(let message):
            return message
        }
    }
}

protocol UtilityService {
    func performDataTask<T: Decodable>(url: URL, resultType: T.Type, completion: @escaping (Result<T, UserError>) -> Void)
}

struct HTTPUtility: UtilityService {
    
    func performDataTask<T: Decodable>(
        url: URL,
        resultType: T.Type,
        completion: @escaping (Result<T, UserError>) -> Void) {
            guard url != URL(string: "") else {
                completion(.failure(.invalidURL()))
                return
            }
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    completion(.failure(.unknownError(error.localizedDescription)))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(.noDataAvailable()))
                    return
                }
                
                guard let response = response
                        as? HTTPURLResponse, (200..<210).contains(response.statusCode) else {
                    
                    do{
                        let dataMessage = try JSONDecoder().decode(APIError.self, from: data)
                        _ =  completion(.failure(.apiError(dataMessage.message)))
                    } catch {
                        _ = completion(.failure(.cannotProcessData()))
                    }
                    return
                }
                
                let decoder = JSONDecoder()
                
                do {
                    let jsonData = try decoder.decode(T.self, from: data)
                    _ = completion(.success(jsonData))
                } catch {
                    _ = completion(.failure(.cannotProcessData()))
                }
            }.resume()
        }
}

struct APIError: Codable {
    let message: String
}
