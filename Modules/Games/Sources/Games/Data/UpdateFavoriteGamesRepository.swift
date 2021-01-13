//
//  File.swift
//  
//
//  Created by Abdul Chathil on 11/27/20.
//

import Core
import Combine
import Cleanse

public struct UpdateFavoriteGamesRepository<
    GameLocalDataSource: LocalDataSource,
    Transformer: Mapper>: Repository
where
    GameLocalDataSource.Request == Int32,
    GameLocalDataSource.Response == GamesEntity,
    GameLocalDataSource.UpdateResponse == [GamesEntity],
    Transformer.Response == [GamesResponse],
    Transformer.Entity == [GamesEntity],
    Transformer.Domain == [GamesModel] {
    
    public typealias Request = GamesModel
    public typealias Response = [GamesModel]
    
    private let _localDataSource: GameLocalDataSource
    private let _mapper: Transformer
    
    public init(
        localDataSource: GameLocalDataSource,
        mapper: Transformer) {
        _localDataSource = localDataSource
        _mapper = mapper
    }
    
    public func execute(request: GamesModel?) -> AnyPublisher<[GamesModel], Error> {
        guard  let request = request else {
            fatalError("a game is needed")
        }
        guard let tranformedRequest = _mapper.transformDomainToEntity(domain: [request]).first else {
            fatalError("failed to like")
        }
        return _localDataSource.update(id: request.id, entity: tranformedRequest)
            .map {
                _mapper.transformEntityToDomain(entity: $0)
            }.eraseToAnyPublisher()
    }
}

extension UpdateFavoriteGamesRepository {
    struct Module: Cleanse.Module {
        static func configure(binder: Binder<Singleton>) {
            binder.include(module: GetFavoriteGamesLocalDataSource.Module.self)
            binder.bind(UpdateFavoriteGamesRepository.self).to(factory: UpdateFavoriteGamesRepository.init)
        }
    }
}
