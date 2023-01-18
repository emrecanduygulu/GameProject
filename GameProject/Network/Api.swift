//
//  Api.swift
//  GameProject
//
//  Created by emre can duygulu on 17.01.2023.
//
// https://api.rawg.io/api/games?key=dfcc34b246fe42bea540f6fcd701f590

import Foundation

class Api {
    
    var games: [Result] = [Result]()
    var output: ApiOutput?
    
    func fetchGames() {
        output?.isLoading(true)
        
        guard let url = URL(string: "https://api.rawg.io/api/games?key=dfcc34b246fe42bea540f6fcd701f590") else {
            return
            }
        URLSession.shared.dataTask(with: url) {
            data, response, error in
            
            if let error = error {
                print("URLSession error: \(error.localizedDescription)")
                self.output?.showError(errorMessage: "Error, \(error.localizedDescription)")
            } else if let data = data {
                do {
                    let result = try JSONDecoder().decode(GameModel.self, from: data)
                    DispatchQueue.main.async {
                        self.games = result.results
                        self.output?.isLoading(false)
                        self.output?.showData()
                        
                    }
                }   catch {
                        print("Decoding error")
                    self.output?.showError(errorMessage: "Decoding error")
                    self.output?.isLoading(false)
                    }
                }
            }.resume()
        }
    }

protocol ApiInput {
    func loadGameList()
    func openGameDetail(indexPath: IndexPath)
}

protocol ApiOutput {
    func showData()
    func showError(errorMessage: String)
    func openGameDetail(game: Result)
    func isLoading(_ value: Bool)
}

extension Api: ApiInput {
    func loadGameList() {
        fetchGames()
    }
    func openGameDetail(indexPath: IndexPath) {
        let game = games[indexPath.row]
        output?.openGameDetail(game: game)
    }
}
