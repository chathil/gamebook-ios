//
//  File.swift
//  
//
//  Created by Abdul Chathil on 11/27/20.
//

import Core
import Combine
import Cleanse

public struct GetGameRepository<
    GameLocalDataSource: LocalDataSource,
    GameRemoteDataSource: DataSource,
    Transformer: Mapper>: Repository
where
    GameLocalDataSource.Request == Int32,
    GameLocalDataSource.Response == GamesEntity?,
    GameLocalDataSource.UpdateResponse == Bool,
    GameRemoteDataSource.Request == Int32,
    GameRemoteDataSource.Response == GamesResponse,
    Transformer.Response == GamesResponse,
    Transformer.Entity == GamesEntity,
    Transformer.Domain == GamesModel {
    
    public typealias Request = Int32
    public typealias Response = GamesModel
    
    private let _localDataSource: GameLocalDataSource
    private let _remoteDataSource: GameRemoteDataSource
    private let _mapper: Transformer
    
    public init(
        localDataSource: GameLocalDataSource,
        remoteDataSource: GameRemoteDataSource,
        mapper: Transformer) {
        _localDataSource = localDataSource
        _remoteDataSource = remoteDataSource
        _mapper = mapper
    }
    
    public  func execute(request: Int32?) -> AnyPublisher<GamesModel, Error> {
        guard let request = request else {
            fatalError("id is needed")
        }
        return _localDataSource.get(id: request)
            .flatMap { result -> AnyPublisher<GamesModel, Error> in
                guard let result = result else {
                    return _remoteDataSource.execute(request: request)
                        .map { _mapper.transformResponseToDomain(response: $0) }
                        .eraseToAnyPublisher()
                }
                // MARK need revisit
                if true {
                    return _remoteDataSource.execute(request: request)
                        .map { _mapper.transformResponseToEntity(response: $0) }
                        .flatMap { _localDataSource.update(id: $0.id, entity: $0) }
                        .filter { $0 }
                        .flatMap { _ in _localDataSource.get(id: request)
                            .map {
                                guard let response = $0 else {
                                    fatalError("cannot find game with id \(request)")
                                }
                                return _mapper.transformEntityToDomain(entity: response) }
                        }.eraseToAnyPublisher()
                    
                } else {
                    return _localDataSource.get(id: request)
                        .map {
                            guard let response = $0 else {
                                fatalError("cannot find game with id \(request)")
                            }
                            return _mapper.transformEntityToDomain(entity: response) }
                        .eraseToAnyPublisher()
                }
                
            }.eraseToAnyPublisher()
    }
}

extension GetGameRepository {
    struct Module: Cleanse.Module {
        static func configure(binder: Binder<Singleton>) {
            binder.include(module: GetGameLocalDataSource.Module.self)
            binder.include(module: GetGameRemoteDataSource.Module.self)
            binder.include(module: GameTransformer.Module.self)
            binder.bind(GetGameRepository.self).to(factory: GetGameRepository.init)
        }
    }
}
