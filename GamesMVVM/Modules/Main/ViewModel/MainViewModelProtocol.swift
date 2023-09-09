//
//  MainViewModelProtocol.swift
//  GamesMVVM
//
//  Created by Cenk Bahadır Çark on 10.09.2023.
//

import Foundation

protocol MainViewModelProtocol {
    var delegate: MainViewModelDelegate? { get set }
    var games: [GamesResponseModelElement] { get set }
    var cellType: [MainCellType] { get set }
    
    func fetchGames()
}

protocol MainViewModelDelegate: AnyObject {
    func handleNotify(notify: MainViewNotify)
}

enum MainViewNotify {
    case didFetchGames
    case errorFetchAgents(error :String)
    case reloadTableView
}

enum MainCellType {
    case games
}
