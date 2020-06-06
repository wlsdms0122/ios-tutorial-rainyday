//
//  NetworkService.swift
//  rainyday
//
//  Created by JSilver on 2020/06/06.
//  Copyright © 2020 JSilver. All rights reserved.
//

import Foundation
import CoreLocation

class NetworkService {
    private let networkService = NetworkService()
    
    func requestGetWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees, completed: @escaping (Result<GetWeatherResponse, Error>) -> Void) {
        
    }
}

class NetworkProvider {
    private let session = URLSession(configuration: .default)
    
    func request<T: Api>(api: T, completed: @escaping (Result<T.Result, Error>) -> Void) {
        session.dataTask(with: api.url) { data, response, error in
            if let error = error {
                completed(.failure(error))
                return
            }
            
            if let data = data, let response = response as? HTTPURLResponse {
                guard (200 ..< 300).contains(response.statusCode) else {
                    completed(.failure(RDError.unknown))
                    return
                }
                
                let decoder = JSONDecoder()
                do {
                    let result = try decoder.decode(T.Result.self, from: data)
                    
                    DispatchQueue.main.async {
                        completed(.success(result))
                    }
                } catch {
                    completed(.failure(error))
                }
            }
        }.resume()
    }
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case connect = "CONNECT"
    case delete = "DELETE"
    case head = "HEAD"
    case options = "OPTIONS"
    case patch = "PATCH"
    case put = "PUT"
    case trace = "TRACE"
}

protocol Api {
    associatedtype Result: Codable
    
    var baseUrl: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: [String: Any]? { get }
    var headers: [String: String]? { get }
}

extension Api {
    var url: URL {
        let url = baseUrl.appendingPathComponent(path)
        guard method != .get else {
            var components = URLComponents(string: url.absoluteString)!
            components.queryItems = parameters?.map { URLQueryItem(name: $0, value: "\($1)") }
            
            return components.url!
        }
        
        return url
    }
}

// https://api.openweathermap.org/data/2.5/onecall?lat=$(latitude)&lon=$(longitude)&exclude=hourly&appid=$(api-key)
struct GetWeatherApi {
    
}
