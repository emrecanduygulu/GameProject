//
//  CoreDataManager.swift
//  GameProject
//
//  Created by emre can duygulu on 24.01.2023.
//

import Foundation

import UIKit
import CoreData

struct CoreDataManager {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var games: [Game] = []
    
    init() {
        getAllGames()
    }
    
    private mutating func getAllGames() {
        do {
            let allGames = try context.fetch(Game.fetchRequest())
            games = allGames
        }
        catch {
            print("CannotFetchGames")
        }
    }
    
    func getGame(slug: String)-> Game? {
        let game = games.first(where: {
            $0.slug == slug
        })
        return game
    }
    
    mutating func updateGame(slug: String, newVersion: Game) {
        getAllGames()
        guard let game = games.first(where: { $0.slug == slug }) else { return }
            game.setValue(newVersion.backgroundImage, forKey: "backgroundImage")
            game.setValue(newVersion.descriptionRaw, forKey: "descriptionRaw")
            game.setValue(newVersion.genre, forKey: "genre")
            game.setValue(newVersion.slug, forKey: "slug")
            game.setValue(newVersion.isFavorited, forKey: "isFavorited")
            game.setValue(newVersion.isNoted, forKey: "isNoted")
            game.setValue(newVersion.metacritic, forKey: "metacritic")
            game.setValue(newVersion.name, forKey: "name")
            game.setValue(newVersion.note, forKey: "note")
            game.setValue(newVersion.rating, forKey: "rating")
            game.setValue(newVersion.ratingCount, forKey: "ratingCount")
            game.setValue(newVersion.id, forKey: "id")
            save()
            getAllGames()
    }
    
    mutating func saveGame(game: GameInterface) {
        guard
            let entityDescription = NSEntityDescription.entity(
                forEntityName: "Game",
                in: context
            )
        else { return }
        let newValue = NSManagedObject(
            entity: entityDescription,
            insertInto: context
        )
        newValue.setValue(game.backgroundImage, forKey: "backgroundImage")
        newValue.setValue(game.descriptionRaw, forKey: "descriptionRaw")
        newValue.setValue(game.genre, forKey: "genre")
        newValue.setValue(game.slug, forKey: "slug")
        newValue.setValue(game.isFavorited, forKey: "isFavorited")
        newValue.setValue(game.isNoted, forKey: "isNoted")
        newValue.setValue(game.metacritic, forKey: "metacritic")
        newValue.setValue(game.name, forKey: "name")
        newValue.setValue(game.note, forKey: "note")
        newValue.setValue(game.rating, forKey: "rating")
        newValue.setValue(game.ratingCount, forKey: "ratingCount")
        newValue.setValue(game.id, forKey: "id")
        context.insert(newValue)
        save()
        getAllGames()
    }
    
    func getFavorites() -> [Game] {
        do {
            let favoritedGames = try context.fetch(Game.fetchRequest())
            return favoritedGames.filter { $0.isFavorited }
        }
        catch {
            print("CannotFetchGames")
            return []
        }
    }
    
    func getNotedGames() -> [Game] {
        do {
            let notedGames = try context.fetch(Game.fetchRequest())
            return notedGames.filter { $0.isNoted }
        }
        catch {
            print("CannotFetchGames")
            return []
        }
    }
    
    private func save() {
        do {
            try context.save()
        }
        catch {
            print("Cannot Save")
        }
    }
}
