//
//  DetailViewModel.swift
//  GameProject
//
//  Created by emre can duygulu on 23.01.2023.
//

import Foundation

class DetailViewModel {
  
    var gameId: Int
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
                        
                    }
                } catch {
                    print("Decoding error")
                    self.output?.showError(errorMessage: "Decoding Error")
                    self.output?.isLoading(false)
                }
            }
        }.resume()
    }
    
    init(gameId: Int) {
    self.gameId = gameId
    }
}

protocol DetailViewModelInput {
    func onViewDidLoad()
}

protocol DetailViewModelOutput {
    func showDetails(details: DetailModel)
    func showError(errorMessage: String)
    func isLoading(_ value: Bool)
}

extension DetailViewModel: DetailViewModelInput {
    func onViewDidLoad() {
        fetchDetails(for: gameId)
    }
}
