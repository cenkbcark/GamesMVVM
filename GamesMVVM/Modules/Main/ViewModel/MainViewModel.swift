//
//  MainViewModel.swift
//  GamesMVVM
//
//  Created by Cenk Bahadır Çark on 10.09.2023.
//

import Foundation

final class MainViewModel: MainViewModelProtocol {
    weak var delegate: MainViewModelDelegate?
    var games: [GamesResponseModelElement] = []
    var cellType: [MainCellType] = []
    
    private let dataProvider: MainDataProviderProtocol
    
    init(dataProvider: MainDataProviderProtocol) {
        self.dataProvider = dataProvider
    }
    
    func fetchGames() {
        dataProvider.fetchGames(endPoint: .game, parameters: []) { result in
            switch result {
            case .success(let games):
                self.cellType.append(.games)
                self.games = games
                self.notify(with: .didFetchGames)
            case .failure(let error):
                self.notify(with: .errorFetchAgents(error: error.localizedDescription))
            }
        }
    }
    
    private func notify(with notify: MainViewNotify) {
        DispatchQueue.main.async {
            self.delegate?.handleNotify(notify: notify)
        }
    }
}
