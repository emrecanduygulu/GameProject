//
//  DetailModel.swift
//  GameProject
//
//  Created by emre can duygulu on 23.01.2023.
//

import Foundation

struct DetailModel: Codable {
    let name: String?
    let descriptionRaw: String?
    let metacritic: Int?
    let backgroundImage: String?
    let genres: [Genre]
    
    enum CodingKeys: String, CodingKey {
        case name
        case descriptionRaw = "description_raw"
        case metacritic
        case backgroundImage = "background_image"
        case genres
    }
}
