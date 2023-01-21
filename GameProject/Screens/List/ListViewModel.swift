//
//  Api.swift
//  GameProject
//
//  Created by emre can duygulu on 17.01.2023.
//
// https://api.rawg.io/api/games?key=dfcc34b246fe42bea540f6fcd701f590

import Foundation

class ListViewModel {
    
    var games: [Result] = [Result]()
    var output: ListViewModelOutput?
    
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
    
    
    func fetchGamesWithFilter(for searchTerm: String) {
        
        guard let url = URL(string: "https://api.rawg.io/api/games?key=dfcc34b246fe42bea540f6fcd701f590&search=\(searchTerm)")
        else {
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                print("URLSession error: \(error.localizedDescription)")
                self.output?.showError(errorMessage: "Error")
            } else if let data = data {
                do {
                    let result = try JSONDecoder().decode(GameModel.self, from: data)
                    DispatchQueue.main.async {
                        self.games = result.results
                        self.output?.isLoading(false)
                        self.output?.showData()
                    }
                } catch {
                    print("Decoding error")
                    self.output?.showError(errorMessage: "Decoding error")
                    self.output?.isLoading(false)
                }
            }
            
        }.resume()
    }
}
    
    protocol ListViewModelInput {
        func openGameDetail(indexPath: IndexPath)
        func loadGamesWithFilter(searchTerm: String)
        func onViewDidLoad()
    }
    
    protocol ListViewModelOutput {
        func showData()
        func showError(errorMessage: String)
        func openGameDetail(game: Result)
        func isLoading(_ value: Bool)
    }
    
extension ListViewModel: ListViewModelInput {
   func openGameDetail(indexPath: IndexPath) {
        let game = games[indexPath.row]
        output?.openGameDetail(game: game)
    }
    func loadGamesWithFilter(searchTerm: String) {
        if searchTerm.isEmpty {
            fetchGames()
        } else {
            fetchGamesWithFilter(for: searchTerm)
        }
    }
    func onViewDidLoad() {
        fetchGames()
    }
}
