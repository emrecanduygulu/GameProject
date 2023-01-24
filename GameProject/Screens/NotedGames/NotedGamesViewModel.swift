//
//  NotedGamesViewModel.swift
//  GameProject
//
//  Created by emre can duygulu on 25.01.2023.
//

import Foundation

class NotedGamesViewModel {
    
    var games: [Result] = [Result]()
    var output: NotedGamesViewModelOutput?
    
    private func getNotedGamesFromCoreData() {
        let games = Current.coreDataManager.getNotedGames()
        let results = games.map(convert(game:))
        self.games = results
        output?.showData()
    }
    
    private func convert(game: Game) -> Result {
        Result(id: Int(game.id), name: game.name, released: nil, backgroundImage: game.backgroundImage, rating: game.rating, ratingsCount: Int(game.ratingCount), metacritic: Int(game.metacritic), playtime: nil, genres: nil, shortScreenshots: nil)
    }
}
protocol NotedGamesViewModelInput {
    func openGameDetail(indexPath: IndexPath)
    func onViewDidAppear()
}

protocol NotedGamesViewModelOutput {
    func showData()
    func showError(errorMessage: String)
    func openGameDetail(game: Result)
}


extension NotedGamesViewModel: NotedGamesViewModelInput {
    func onViewDidAppear() {
        getNotedGamesFromCoreData()
    }
    func openGameDetail(indexPath: IndexPath) {
        let game = games[indexPath.row]
        output?.openGameDetail(game: game)
    }
}
