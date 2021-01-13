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
    GameMapper.Response == GamesResponse,
    GameMapper.Entity == GamesEntity,
    GameMapper.Domain == GamesModel {
    
    public typealias Request = String
    public typealias Response = [GamesResponse]
    public typealias Entity = [GamesEntity]
    public typealias Domain = [GamesModel]
    
    private let _gameMapper: GameMapper
    
    public init(gameMapper: GameMapper) {
        _gameMapper = gameMapper
    }
    
    public func transformResponseToEntity(response: [GamesResponse]) -> [GamesEntity] {
        response.map { result in
            _gameMapper.transformResponseToEntity(response: result)
        }
    }
    
    public func transformResponseToDomain(response: Response) -> [GamesModel] {
        response.map { result in
            _gameMapper.transformResponseToDomain(response: result)
        }
    }
    
    public func transformEntityToDomain(entity: [GamesEntity]) -> [GamesModel] {
        entity.map { result in
            _gameMapper.transformEntityToDomain(entity: result)
        }
    }
    
    public func transformDomainToEntity(domain: [GamesModel]) -> [GamesEntity] {
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
    
