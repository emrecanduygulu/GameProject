//
//  FavoritesViewModel.swift
//  GameProject
//
//  Created by emre can duygulu on 25.01.2023.
//

import Foundation

class FavoritesViewModel {
    
    var games: [Result] = [Result]()
    var output: FavoritesViewModelOutput?
    
    private func getFavoritesCoreData() {
        let games = Current.coreDataManager.getFavorites()
        let results = games.map(convert(game:))
        self.games = results
        output?.showData()
    }
    
    private func convert(game: Game) -> Result {
        Result(id: Int(game.id), name: game.name, released: nil, backgroundImage: game.backgroundImage, rating: game.rating, ratingsCount: Int(game.ratingCount), metacritic: Int(game.metacritic), playtime: nil, genres: nil, shortScreenshots: nil)
    }
}
protocol FavoritesViewModelInput {
    func openGameDetail(indexPath: IndexPath)
    func onViewDidAppear()
}

protocol FavoritesViewModelOutput {
    func showData()
    func showError(errorMessage: String)
    func openGameDetail(game: Result)
}


extension FavoritesViewModel: FavoritesViewModelInput {
    func onViewDidAppear() {
        getFavoritesCoreData()
    }
    func openGameDetail(indexPath: IndexPath) {
        let game = games[indexPath.row]
        output?.openGameDetail(game: game)
    }
}

