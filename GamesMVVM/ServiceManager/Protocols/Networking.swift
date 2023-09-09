//
//  Networking.swift
//  GamesMVVM
//
//  Created by Cenk Bahadır Çark on 10.09.2023.
//

import Foundation

protocol Networking {
    func fetchDataArray<T: Decodable>(endpoint: APIEndpoint, parameters: [Parameter]?, completion: @escaping (Result<[T], Error>) -> Void)
    func fetchData<T: Decodable>(endpoint: APIEndpoint, parameters: [Parameter]?, completion: @escaping (Result<T, Error>) -> Void)
}
