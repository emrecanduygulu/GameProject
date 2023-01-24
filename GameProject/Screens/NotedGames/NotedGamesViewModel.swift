//
//  NotedGamesViewModel.swift
//  GameProject
//
//  Created by emre can duygulu on 24.01.2023.
//

import Foundation

class NotedGamesViewModel {
    
    var games: [Result] = [Result]()
    var output: NotedGamesViewModelOutput?
    
    private func getNotedGamesFromCoreData() {
        
    }
    
}
protocol NotedGamesViewModelInput {
    func openGameDetail(indexPath: IndexPath)
    func onViewDidLoad()
}

protocol NotedGamesViewModelOutput {
    func showData()
    func showError(errorMessage: String)
    func openGameDetail(game: Result)
}


extension NotedGamesViewModel: NotedGamesViewModelInput {
    func onViewDidLoad() {
        getNotedGamesFromCoreData()
    }
    func openGameDetail(indexPath: IndexPath) {
        let game = games[indexPath.row]
        output?.openGameDetail(game: game)
    }
}
