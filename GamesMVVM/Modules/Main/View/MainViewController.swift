//
//  MainViewController.swift
//  GamesMVVM
//
//  Created by Cenk Bahadır Çark on 10.09.2023.
//

import UIKit

final class MainViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModel: MainViewModelProtocol? {
        didSet {
            viewModel?.delegate = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareCollectionView()
        registerCells()
        viewModel?.fetchGames()
    }
    
    private func prepareCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func registerCells() {
        let cellName = String(describing: GameCell.self)
        let nibName = UINib(nibName: cellName, bundle: .main)
        collectionView.register(nibName, forCellWithReuseIdentifier: cellName)
    }
}
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        guard let section = viewModel?.cellType.count else { return 0 }
        return section
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let section = viewModel?.cellType[section], let games = viewModel?.games else { return 0 }
        switch section {
        case .games:
            return games.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let section = viewModel?.cellType[indexPath.section] else { return UICollectionViewCell() }
        switch section {
        case .games:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: GameCell.self), for: indexPath) as? GameCell {
                cell.setModels(viewModel?.games[indexPath.row])
                return cell
            }
        }
        return UICollectionViewCell()
    }
}
extension MainViewController: MainViewModelDelegate {
    func handleNotify(notify: MainViewNotify) {
        switch notify {
        case .didFetchGames:
            self.collectionView.reloadData()
        case .errorFetchAgents(error: let error):
            printContent(error)
        case .reloadTableView:
            self.collectionView.reloadData()
        }
    }
}
