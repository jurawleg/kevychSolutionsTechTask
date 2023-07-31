//
//  NetworkCaller.swift
//  Weather Report
//
//  Created by MacBook on 27.07.2023.
//

import Foundation

//https://geocoding-api.open-meteo.com/v1/search?name=Lvi&count=10&language=en&format=json


final class NetworkCaller {
    private func runRequest(request: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                debugPrint("Error getting data for request \(request), error - \(error)")
                completion(nil, nil, error)
            }
            
            if let data = data, let response = response  {
                completion(data, response, nil)
            }
            
        }.resume()
    }
}


extension NetworkCaller {
    private func createUrl(path: String, useBaseUrl: Bool = true) -> URL? {
        
        var initialUrl: String = path
        
//        if useBaseUrl {
//            guard let baseUrl = InfoPlistParser.getValue(for: "ForecastUrl") else {
//                debugPrint("Error getting base url for cloud func from plist file.")
//                return nil
//            }
//            
//            initialUrl = baseUrl + path
//        }
        
        guard let url = URL(string: initialUrl) else {
            debugPrint("Error creating URL from string \(initialUrl)")
            return nil
        }
        return url
    }
    
    private func createRequest(url: URL, method: HTTPMethod, appendAPIKey: Bool = false, body: Data? = nil) -> URLRequest? {
        
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
