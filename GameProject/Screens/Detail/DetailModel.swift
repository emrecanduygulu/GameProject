//
//  DetailModel.swift
//  GameProject
//
//  Created by emre can duygulu on 23.01.2023.
//

import Foundation

struct DetailModel: Codable {
    let slug: String?
    let name: String?
    let descriptionRaw: String?
    let metacritic: Int?
    let backgroundImage: String?
    let genres: [Genre]
    let rating: Double?
    let ratingCount: Int?
    let id: Int?
    
    enum CodingKeys: String, CodingKey {
        case slug
        case name
        case descriptionRaw = "description_raw"
        case metacritic
        case backgroundImage = "background_image"
        case genres
        case rating
        case ratingCount = "ratings_count"
        case id
    }
}
