//
//  File.swift
//  
//
//  Created by Abdul Chathil on 11/27/20.
//

import Core
import Combine
import Cleanse

public struct GetGamesRepository<
    GamesLocalDataSource: LocalDataSource,
    GamesRemoteDataSource: DataSource,
    Transformer: Mapper>: Repository
where
    GamesLocalDataSource.Request == String,
    GamesLocalDataSource.Response == GameEntity,
    GamesRemoteDataSource.Request == String,
    GamesRemoteDataSource.Response == GamesResponse,
    Transformer.Response == [GameResponse],
    Transformer.Entity == [GameEntity],
    Transformer.Domain == [GameModel] {
    
    public typealias Request = String
    public typealias Response = [GameModel]
    
    private let _localDataSource: GamesLocalDataSource
    private let _remoteDataSource: GamesRemoteDataSource
    private let _mapper: Transformer
    
    public init(
        localDataSource: GamesLocalDataSource,
        remoteDataSource: GamesRemoteDataSource,
        mapper: Transformer) {
        _localDataSource = localDataSource
        _remoteDataSource = remoteDataSource
        _mapper = mapper
    }
    
    public func execute(request: String?) -> AnyPublisher<[GameModel], Error> {
        if let request = request {
            return _remoteDataSource.execute(request: request)
                .map { _mapper.transformResponseToDomain(response: $0.results) }
                .eraseToAnyPublisher()
        } else {
            return _localDataSource.list(request: request)
                .flatMap { result -> AnyPublisher<[GameModel], Error> in
                    if result.isEmpty {
                        return _remoteDataSource.execute(request: request)
                            .map { _mapper.transformResponseToEntity(response: $0.results) }
                            .flatMap { _localDataSource.add(entities: $0) }
                            .filter { $0 }
                            .flatMap { _ in _localDataSource.list(request: request)
                                .map { _mapper.transformEntityToDomain(entity: $0) }
                            }.eraseToAnyPublisher()
                    } else {
                        return _localDataSource.list(request: request)
                            .map { _mapper.transformEntityToDomain(entity: $0) }
                            .eraseToAnyPublisher()
                    }
                }.eraseToAnyPublisher()
        }
    }
}

public extension GetGamesRepository {
    struct Module: Cleanse.Module {
        public static func configure(binder: Binder<Singleton>) {
            binder.include(module: GetGamesLocalDataSource.Module.self)
            binder.include(module: GetGamesRemoteDataSource.Module.self)
            binder.include(module: GamesTransformer<GameTransformer>.Module.self)
            binder.bind(GetGamesRepository.self).to(factory: GetGamesRepository.init)
        }
    }
}
