//
//  Game+CoreDataProperties.swift
//  GameProject
//
//  Created by emre can duygulu on 24.01.2023.
//
//

import Foundation
import CoreData


extension Game {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Game> {
        return NSFetchRequest<Game>(entityName: "Game")
    }
    @NSManaged public var backgroundImage: String
    @NSManaged public var descriptionRaw: String
    @NSManaged public var genre: String
    @NSManaged public var slug: String
    @NSManaged public var isFavorited: Bool
    @NSManaged public var isNoted: Bool
    @NSManaged public var metacritic: Int32
    @NSManaged public var name: String
    @NSManaged public var note: String?
    @NSManaged public var rating: Double
    @NSManaged public var ratingCount: Int32
    @NSManaged public var id: Int32

}

extension Game: Identifiable {

}
