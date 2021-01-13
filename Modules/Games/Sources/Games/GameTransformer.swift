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
    public typealias Response = GamesResponse
    public typealias Entity = GamesEntity
    public typealias Domain = GamesModel
    public init() {
        
    }
    public func transformResponseToEntity(response: Response) -> GamesEntity {
        GamesEntity(id: response.id,
                   name: response.name,
                   backgroundImage: response.backgroundUrl,
                   genres: response.genreNames,
                   gameRating: response.gameRating,
                   esrbRating: response.esrb ?? "",
                   metacritic: response.metacritic ?? 0,
                   publishers: response.publisherNames,
                   released: response.releaseDate ?? "")
    }
    
    public func transformResponseToDomain(response: Response) -> GamesModel {
        GamesModel(id: response.id,
                  name: response.name,
                  backgroundImage: response.backgroundUrl,
                  genres: response.genreNames,
                  gameRating: response.gameRating,
                  esrbRating: response.esrb ?? "No Rating",
                  metacritic: response.metacritic ?? 0,
                  publishers: response.publisherNames,
                  released: response.releaseDate ?? "No Date")
    }
    
    public func transformEntityToDomain(entity: GamesEntity) -> GamesModel {
        GamesModel(id: entity.id,
                  name: entity.name,
                  backgroundImage: entity.backgroundImage,
                  genres: entity.genres.map { $0 },
                  gameRating: entity.gameRating,
                  esrbRating: entity.esrbRating,
                  metacritic: entity.metacritic,
                  publishers: entity.publishers.map { $0 },
                  released: entity.released)
    }
    
    public func transformDomainToEntity(domain: GamesModel) -> GamesEntity {
        GamesEntity(id: domain.id,
                   name: domain.name,
                   backgroundImage: domain.backgroundImage,
                   genres: domain.genres,
                   gameRating: domain.gameRating,
                   esrbRating: domain.esrbRating,
                   metacritic: domain.metacritic,
                   publishers: domain.publishers,
                   released: domain.released)
    }
    
}

public extension GameTransformer {
    struct Module: Cleanse.Module {
        public static func configure(binder: Binder<Singleton>) {
            binder.bind(GameTransformer.self).to(factory: GameTransformer.init)
        }
    }
}
