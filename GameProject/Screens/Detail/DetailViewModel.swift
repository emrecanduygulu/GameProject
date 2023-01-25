//
//  DetailViewModel.swift
//  GameProject
//
//  Created by emre can duygulu on 23.01.2023.
//

import Foundation

class DetailViewModel {
  
    var gameId: Int
    var detailModel: DetailModel?
    var output: DetailViewModelOutput?
    
    private func fetchDetails(for gameId: Int) {
        output?.isLoading(true)
        
        guard let url = URL(string: "https://api.rawg.io/api/games/\(gameId)?key=dfcc34b246fe42bea540f6fcd701f590") else {
            return
        }
        URLSession.shared.dataTask(with: url) {
            data, response, error in
            
            if let error = error {
                print("URLSession error: \(error.localizedDescription)")
            } else if let data = data {
                do {
                    let result = try JSONDecoder().decode(DetailModel.self, from: data)
                    DispatchQueue.main.async {
                        self.output?.isLoading(false)
                        self.output?.showDetails(details: result)
                        self.detailModel = result
                        self.gameAlreadyFavorited()
                    }
                } catch {
                    print("Decoding error")
                    self.output?.showError(errorMessage: "Decoding Error")
                    self.output?.isLoading(false)
                    
                }
            }
        }.resume()
    }
    
    private func gameAlreadyFavorited() {
        if let game = Current.coreDataManager.getGame(slug: detailModel?.slug ?? ""), game.isFavorited {
            output?.updateFavoritesLabel(string: "already_favorite".localized())
        }
    }
    
    init(gameId: Int) {
    self.gameId = gameId
    }
}

protocol DetailViewModelInput {
    func onViewDidAppear()
    func addFavTapped()
    func addNoteTapped()
}

protocol DetailViewModelOutput {
    func showDetails(details: DetailModel)
    func showError(errorMessage: String)
    func isLoading(_ value: Bool)
    func addNoteTapped(details: DetailModel)
    func updateFavoritesLabel(string: String)
}

extension DetailViewModel: DetailViewModelInput {
    func onViewDidAppear() {
        fetchDetails(for: gameId)
    }
    func addFavTapped() {
        if let game = Current.coreDataManager.getGame(slug: detailModel?.slug ?? "") {
            let copy = game
            copy.isFavorited = !game.isFavorited
            output?.updateFavoritesLabel(string: copy.isFavorited ? "already_favorite".localized() : "add_to_favorites".localized())
            Current.coreDataManager.updateGame(slug: detailModel?.slug ?? "", newVersion: copy)
        } else {
            let game = GameInterface(backgroundImage: detailModel?.backgroundImage ?? "", descriptionRaw: detailModel?.descriptionRaw ?? "", genre: detailModel?.genres.first?.name ?? "", slug: detailModel?.slug ?? "", isFavorited: true, isNoted: false, metacritic: detailModel?.metacritic ?? 0, name: detailModel?.name ?? "", note: "", rating: detailModel?.rating ?? 0.0, ratingCount: detailModel?.ratingCount ?? 0, id: detailModel?.id ?? 0)
            output?.updateFavoritesLabel(string: "already_favorite".localized())
            Current.coreDataManager.saveGame(game: game)
        }
    }
    func addNoteTapped() {
        guard let detailModel = detailModel else {return }
        output?.addNoteTapped(details: detailModel)
    }
}
