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
    GamesLocalDataSource.Response == GamesEntity,
    GamesRemoteDataSource.Request == String,
    GamesRemoteDataSource.Response == GamesResponseContainer,
    Transformer.Response == [GamesResponse],
    Transformer.Entity == [GamesEntity],
    Transformer.Domain == [GamesModel] {
    
    public typealias Request = String
    public typealias Response = [GamesModel]
    
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
    
    public func execute(request: String?) -> AnyPublisher<[GamesModel], Error> {
        if let request = request {
            return _remoteDataSource.execute(request: request)
                .map { _mapper.transformResponseToDomain(response: $0.results) }
                .eraseToAnyPublisher()
        } else {
            return _localDataSource.list(request: request)
                .flatMap { result -> AnyPublisher<[GamesModel], Error> in
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
