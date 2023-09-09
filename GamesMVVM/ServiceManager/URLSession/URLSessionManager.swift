//
//  URLSessionManager.swift
//  GamesMVVM
//
//  Created by Cenk Bahadır Çark on 10.09.2023.
//

import Foundation

final class URLSessionManager: Networking {
    func fetchDataArray<T>(endpoint: APIEndpoint, parameters: [Parameter]?, completion: @escaping (Result<[T], Error>) -> Void) where T : Decodable {
        var components = URLComponents(string: Constant.baseURL + endpoint.rawValue)
        if let parameters = parameters {
            components?.queryItems = parameters.map({$0.queryItem})
        }
        guard let url = components?.url else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0)))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data received", code: 0)))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode([T].self, from: data)
                completion(.success(decodedData))
            }catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    
    func fetchData<T>(endpoint: APIEndpoint, parameters: [Parameter]?, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        var components = URLComponents(string: Constant.baseURL + endpoint.rawValue)
        if let parameters = parameters {
            components?.queryItems = parameters.map({$0.queryItem})
        }
        guard let url = components?.url else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0)))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data received", code: 0)))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode(T.self, from: data)
                completion(.success(decodedData))
            }catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
}
