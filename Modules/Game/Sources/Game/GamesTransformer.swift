//
//  File.swift
//  
//
//  Created by Abdul Chathil on 11/28/20.
//

import Core
import Cleanse

public struct GamesTransformer<GameMapper: Mapper>: Mapper
where
    GameMapper.Response == GameResponse,
    GameMapper.Entity == GameEntity,
    GameMapper.Domain == GameModel {
    
    public typealias Request = String
    public typealias Response = [GameResponse]
    public typealias Entity = [GameEntity]
    public typealias Domain = [GameModel]
    
    private let _gameMapper: GameMapper
    
    public init(gameMapper: GameMapper) {
        _gameMapper = gameMapper
    }
    
    public func transformResponseToEntity(response: [GameResponse]) -> [GameEntity] {
        response.map { result in
            _gameMapper.transformResponseToEntity(response: result)
        }
    }
    
    public func transformResponseToDomain(response: Response) -> [GameModel] {
        response.map { result in
            _gameMapper.transformResponseToDomain(response: result)
        }
    }
    
    public func transformEntityToDomain(entity: [GameEntity]) -> [GameModel] {
        entity.map { result in
            _gameMapper.transformEntityToDomain(entity: result)
        }
    }
    
    public func transformDomainToEntity(domain: [GameModel]) -> [GameEntity] {
        domain.map { result in
            _gameMapper.transformDomainToEntity(domain: result)
        }
    }
    
}

public extension GamesTransformer {
    struct Module: Cleanse.Module {
        public static func configure(binder: Binder<Singleton>) {
            binder.include(module: GameTransformer.Module.self)
            binder.bind(GamesTransformer.self).to(factory: GamesTransformer.init)
        }
    }
}
    
