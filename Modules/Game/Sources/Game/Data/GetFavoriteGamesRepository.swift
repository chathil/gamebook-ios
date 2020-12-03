//
//  File.swift
//  
//
//  Created by Abdul Chathil on 11/27/20.
//

import Core
import Combine
import Cleanse

public struct GetFavoriteGamesRepository<
    GameLocalDataSource: LocalDataSource,
    Transformer: Mapper>: Repository
where
    GameLocalDataSource.Request == Int32,
    GameLocalDataSource.Response == GameEntity,
    Transformer.Response == [GameResponse],
    Transformer.Entity == [GameEntity],
    Transformer.Domain == [GameModel] {
    
    public typealias Request = Int32
    public typealias Response = [GameModel]
    
    private let _localDataSource: GameLocalDataSource
    private let _mapper: Transformer
    
    public init(
        localDataSource: GameLocalDataSource,
        mapper: Transformer) {
        _localDataSource = localDataSource
        _mapper = mapper
    }
    
    public func execute(request: Int32?) -> AnyPublisher<[GameModel], Error> {
        return _localDataSource.list(request: request)
            .map { _mapper.transformEntityToDomain(entity: $0) }
            .eraseToAnyPublisher()
    }
}

extension GetFavoriteGamesRepository {
    struct Module: Cleanse.Module {
        static func configure(binder: Binder<Singleton>) {
            binder.bind(GetFavoriteGamesRepository.self).to(factory: GetFavoriteGamesRepository.init)
        }
    }
}
