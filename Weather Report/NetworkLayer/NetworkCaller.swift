//
//  NetworkCaller.swift
//  Weather Report
//
//  Created by MacBook on 27.07.2023.
//

import Foundation
import CoreLocation

final class NetworkCaller {
    
    final func searchCity(for text: String, completion: @escaping (Result<GeocodingResults, Error>) -> Void) {
        
        let path = "https://geocoding-api.open-meteo.com/v1/search?name=\(text)&count=10&language=en&format=json"
        
        guard let url = createUrl(path: path, useBaseUrl: false), let request = createRequest(url: url, method: .GET) else {
            return
        }
        
        runRequest(request: request, completion: { result in
            completion(result)
        })
    }
    
    final func getForecast(lat: CGFloat, lng: CGFloat, completion: @escaping (Result<ForecastModel, Error>) -> Void) {
        
        let path = "/forecast?latitude=\(lat)&longitude=\(lng)&daily=temperature_2m_max,temperature_2m_min,sunrise,sunset,windspeed_10m_max,windgusts_10m_max&timezone=GMT&forecast_days=16"
        
        guard let url = createUrl(path: path), let request = createRequest(url: url, method: .GET) else {
            return
        }
        
        runRequest(request: request, completion: { result in
            completion(result)
        })
    }
    
}

extension NetworkCaller {
    
    private func runRequest<T: Codable>(request: URLRequest, completion: @escaping (Result<T, Error>) -> Void) {
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                debugPrint("Error getting data for request \(request), error - \(error)")
                completion(.failure(error))
            }
                        
            if let data = data  {
                do {
                    let decodedData = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(decodedData))
                } catch {
                    debugPrint(error)
                    completion(.failure(error))
                }
            }
            
        }.resume()
    }
    
    private func createUrl(path: String, useBaseUrl: Bool = true) -> URL? {
        
        var initialUrl: String = path
        
        if useBaseUrl {
            guard let baseUrl = InfoPlistParser.getValue(for: "ForecastUrl") else {
                debugPrint("Error getting base url for cloud func from plist file.")
                return nil
            }
            
            initialUrl = baseUrl + path
        }
        
        initialUrl = initialUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        guard let url = URL(string: initialUrl) else {
            debugPrint("Error creating URL from string \(initialUrl)")
            return nil
        }
        
        return url
    }
    
    private func createRequest(url: URL, method: HTTPMethod, body: Data? = nil) -> URLRequest? {
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        if let body {
            request.httpBody = body
        }
        
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")
        
        return request
    }

}

enum HTTPMethod: String {
    case GET = "GET"
    case POST = "POST"
    case PUT = "PUT"
    case DELETE = "DELETE"
}

class InfoPlistParser {
    static func getValue(for key: String) -> String? {
        if let value = Bundle.main.infoDictionary?[key] as? String {
            return value
        }
//        Log("Could not get value from plist for key \(key), bundle - \(Bundle.main)")
        return nil
    }
}
