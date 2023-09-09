//
//  MainDataProviderProtocol.swift
//  GamesMVVM
//
//  Created by Cenk Bahadır Çark on 10.09.2023.
//

import Foundation

protocol MainDataProviderProtocol {
    func fetchGames(endPoint: APIEndpoint, parameters: [Parameter], completion: @escaping (Result<[GamesResponseModelElement],Error>) -> Void)
}
