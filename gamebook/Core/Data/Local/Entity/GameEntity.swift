//
//  GameEntity.swift
//  gamebook
//
//  Created by Abdul Chathil on 11/3/20.
//  Copyright © 2020 Abdul Chathil. All rights reserved.
//

import Foundation
import RealmSwift

struct GameEntities {
    let entities: [GameEntity]
}

extension GameEntities {
    func toDomainModels() -> [GameModel] {
        entities.map { $0.toDomainModel() }
    }
}

class GameEntity: Object {
    @objc dynamic var id: Int32 = -1
    @objc dynamic var name: String = ""
    @objc dynamic var descriptionRaw: String = ""
    @objc dynamic var backgroundImage: String = ""
    let genres = List<String>()
    @objc dynamic var gameRating: String = ""
    @objc dynamic var esrbRating: String = ""
    @objc dynamic var metacritic: Int16 = 0
    let publishers = List<String>()
    @objc dynamic var released: String = ""
    
    override init() {
        
    }
    
    required init(id: Int32,
                  name: String,
                  descriptionRaw: String,
                  backgroundImage: String,
                  genres: [String],
                  gameRating: String,
                  esrbRating: String,
                  metacritic: Int16,
                  publishers: [String],
                  released: String) {
        self.id = id
        self.name = name
        self.descriptionRaw = descriptionRaw
        self.backgroundImage = backgroundImage
        self.genres.append(objectsIn: genres.map { $0 })
        self.gameRating = gameRating
        self.esrbRating = esrbRating
        self.metacritic = metacritic
        self.publishers.append(objectsIn: publishers.map { $0 })
        self.released = released
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

extension GameEntity {
    public func toDomainModel() -> GameModel {
        return GameModel(id: self.id,
                         name: self.name,
                         descriptionRaw: self.descriptionRaw,
                         backgroundImage: self.backgroundImage,
                         genres: self.genres.map { $0 },
                         gameRating: self.gameRating,
                         esrbRating: self.esrbRating,
                         metacritic: self.metacritic,
                         publishers: self.publishers.map { $0 },
                         released: self.released)
    }
}
