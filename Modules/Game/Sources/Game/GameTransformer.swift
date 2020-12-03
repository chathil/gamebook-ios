//
//  File.swift
//  
//
//  Created by Abdul Chathil on 11/28/20.
//

import Core
import RealmSwift
import Cleanse

public struct GameTransformer: Mapper {
    public typealias Request = Int32
    public typealias Response = GameResponse
    public typealias Entity = GameEntity
    public typealias Domain = GameModel
    
    public func transformResponseToEntity(response: Response) -> GameEntity {
        GameEntity(id: response.id,
                   name: response.name,
                   descriptionRaw: response.descriptionRaw ?? "",
                   backgroundImage: response.backgroundUrl,
                   genres: response.genreNames,
                   gameRating: response.gameRating,
                   esrbRating: response.esrb ?? "",
                   metacritic: response.metacritic ?? 0,
                   publishers: response.publisherNames,
                   released: response.releaseDate ?? "")
    }
    
    public func transformResponseToDomain(response: Response) -> GameModel {
        GameModel(id: response.id,
                  name: response.name,
                  descriptionRaw: response.descriptionRaw ?? "No Description",
                  backgroundImage: response.backgroundUrl,
                  genres: response.genreNames,
                  gameRating: response.gameRating,
                  esrbRating: response.esrb ?? "No Rating",
                  metacritic: response.metacritic ?? 0,
                  publishers: response.publisherNames,
                  released: response.releaseDate ?? "No Date")
    }
    
    public func transformEntityToDomain(entity: GameEntity) -> GameModel {
        GameModel(id: entity.id,
                  name: entity.name,
                  descriptionRaw: entity.descriptionRaw,
                  backgroundImage: entity.backgroundImage,
                  genres: entity.genres.map { $0 },
                  gameRating: entity.gameRating,
                  esrbRating: entity.esrbRating,
                  metacritic: entity.metacritic,
                  publishers: entity.publishers.map { $0 },
                  released: entity.released)
    }
    
    public func transformDomainToEntity(domain: GameModel) -> GameEntity {
        GameEntity(id: domain.id,
                   name: domain.name,
                   descriptionRaw: domain.descriptionRaw,
                   backgroundImage: domain.backgroundImage,
                   genres: domain.genres,
                   gameRating: domain.gameRating,
                   esrbRating: domain.esrbRating,
                   metacritic: domain.metacritic,
                   publishers: domain.publishers,
                   released: domain.released)
    }
    
}

extension GameTransformer {
    struct Module: Cleanse.Module {
        static func configure(binder: Binder<Singleton>) {
            binder.bind(GameTransformer.self).to(factory: GameTransformer.init)
        }
    }
}
