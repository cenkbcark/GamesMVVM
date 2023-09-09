//
//  MainDataProvider.swift
//  GamesMVVM
//
//  Created by Cenk Bahadır Çark on 10.09.2023.
//

import Foundation

final class MainDataProvider: MainDataProviderProtocol {
    
    private let serviceManager: Networking
    
    init(serviceManager: Networking) {
        self.serviceManager = serviceManager
    }
    
    func fetchGames(endPoint: APIEndpoint, parameters: [Parameter], completion: @escaping (Result<[GamesResponseModelElement], Error>) -> Void) {
        serviceManager.fetchData(endpoint: endPoint, parameters: parameters, completion: completion)
    }
    
}
