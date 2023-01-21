//
//  GameModel.swift
//  GameProject
//
//  Created by emre can duygulu on 17.01.2023.
//

import Foundation

// MARK: - GameModel
struct GameModel: Codable {
    let count: Int
    let results: [Result]
    

    enum CodingKeys: String, CodingKey {
        case count, results
        
    }
}


// MARK: - Result
struct Result: Codable {
    let id: Int
    let name: String
    let released: String
    let backgroundImage: String
    let rating: Double
    let ratingsCount: Int
    let metacritic, playtime : Int
    let genres: [Genre]
    let shortScreenshots: [ShortScreenshot]

    enum CodingKeys: String, CodingKey {
        case id
        case name = "name"
        case released
        case backgroundImage = "background_image"
        case rating
        case ratingsCount = "ratings_count"
        case metacritic, playtime
        case genres
        case shortScreenshots = "short_screenshots"
    }
}


// MARK: - Genre
struct Genre: Codable {
    let id: Int
    let name: String
    let gamesCount: Int
   
    enum CodingKeys: String, CodingKey {
        case id, name
        case gamesCount = "games_count"
    }
}


// MARK: - Rating
struct Rating: Codable {
    let id: Int
    let title: Title
    let count: Int
    let percent: Double
}

enum Title: String, Codable {
    case exceptional = "exceptional"
    case meh = "meh"
    case recommended = "recommended"
    case skip = "skip"
}

// MARK: - ShortScreenshot
struct ShortScreenshot: Codable {
    let id: Int
    let image: String
}

// MARK: - Encode/decode helpers


