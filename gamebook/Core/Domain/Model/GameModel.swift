//
//  GameModel.swift
//  gamebook
//
//  Created by Abdul Chathil on 11/3/20.
//  Copyright © 2020 Abdul Chathil. All rights reserved.
//

import Foundation

struct GameModel: Equatable, Identifiable {
    let id: Int32
    let name: String
    let descriptionRaw: String
    let backgroundImage: String
    let genres: [String]
    let gameRating: String
    let esrbRating: String
    let metacritic: Int16
    let publishers: [String]
    let released: String
}

extension GameModel {
    func toEntity() -> GameEntity {
        return GameEntity(id: self.id,
                          name: self.name,
                          descriptionRaw: self.descriptionRaw,
                          backgroundImage: self.backgroundImage,
                          genres: self.genres,
                          gameRating: self.gameRating,
                          esrbRating: self.esrbRating,
                          metacritic: self.metacritic,
                          publishers: self.publishers,
                          released: self.released)
    }
}
