////
////  HttpUtility.swift
////  WemaTest
////
////  Created by Wellz Val on 6/3/24.
////

import Foundation

enum UserError: Error {
    case invalidURL(String = "Invalid URL")
    case noDataAvailable(String = "No data received from server.")
    case cannotProcessData(String = "Failed to process data")
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
    func performDataTask<T: Decodable>(url: URL, resultType: T.Type) async throws -> T
}

struct HTTPUtility: UtilityService {
    
    func performDataTask<T: Decodable>(
        url: URL,
        resultType: T.Type
    ) async throws -> T {
        guard url != URL(string: "") else {
            throw UserError.invalidURL()
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let response = response as? HTTPURLResponse, (200..<210).contains(response.statusCode) else {
                do {
                    let dataMessage = try JSONDecoder().decode(APIError.self, from: data)
                    throw UserError.apiError(dataMessage.message)
                    
                } catch {
                    if let userError = error as? UserError {
                        throw userError
                    } else {
                        throw UserError.cannotProcessData()
                    }
                }
                
            }
            let decoder = JSONDecoder()
            do {
                let jsonData = try decoder.decode(T.self, from: data)
                return jsonData
            } catch {
                throw UserError.cannotProcessData()
            }
            
        } catch {
            if let userError = error as? UserError {
                throw userError
            } else {
                throw UserError.unknownError()
            }
        }
    }
}

struct APIError: Codable {
    let message: String
}

