//
//  GamebookRepository.swift
//  gamebook
//
//  Created by Abdul Chathil on 11/3/20.
//  Copyright © 2020 Abdul Chathil. All rights reserved.
//

import Foundation
import Combine
import Cleanse

protocol GamebookRepositoryProtocol {
    func getGames() -> AnyPublisher<[GameModel], Error>
    func searchGames(query: String) -> AnyPublisher<[GameModel], Error>
    func getGame(id: Int32) -> AnyPublisher<GameModel?, Error>
    func likeDislike(game: GameModel) -> AnyPublisher<[GameModel], Error>
    func likedGames() -> AnyPublisher<[GameModel], Error>
}

final class GamebookRepository: NSObject {
    typealias GamebookInstance = (LocalDataSource, RemoteDataSource) -> GamebookRepository
    
    fileprivate let remote: RemoteDataSource
    fileprivate let local: LocalDataSource
    
    init(local: LocalDataSource, remote: RemoteDataSource) {
        self.local = local
        self.remote = remote
    }
}

extension GamebookRepository: GamebookRepositoryProtocol {
    func getGames() -> AnyPublisher<[GameModel], Error> {
        return self.local.getGames()
            .flatMap { result -> AnyPublisher<[GameModel], Error> in
                if result.isEmpty {
                    return self.remote.fetchGames()
                        .map { $0.toEntities() }
                        .flatMap { self.local.addGames(from: $0) }
                        .filter { $0 }
                        .flatMap { _ in self.local.getGames()
                            .map { GameEntities(entities: $0).toDomainModels() }
                        }.eraseToAnyPublisher()
                } else {
                    return self.local.getGames()
                        .map { GameEntities(entities: $0).toDomainModels() }
                        .eraseToAnyPublisher()
                }
            }.eraseToAnyPublisher()
    }
    
    func searchGames(query: String) -> AnyPublisher<[GameModel], Error> {
        
        return self.remote.searchGames(query: query).map { $0.toDomainModels()}.eraseToAnyPublisher()
    }
    
    func getGame(id: Int32) -> AnyPublisher<GameModel?, Error> {
        return self.local.getGame(id: id)
            .flatMap { result -> AnyPublisher<GameModel?, Error> in
                if result?.descriptionRaw.isEmpty == true {
                    return self.remote.fetchGame(id: id)
                        .map { $0.toEntity() }
                        .flatMap { self.local.updateGames(from: $0) }
                        .filter { $0 }
                        .flatMap { _ in self.local.getGame(id: id)
                            .map { $0?.toDomainModel() }
                        }.eraseToAnyPublisher()
                } else {
                    return self.local.getGame(id: id)
                        .map { $0?.toDomainModel() }
                        .eraseToAnyPublisher()
                }
            }.eraseToAnyPublisher()
    }
    
    func likeDislike(game: GameModel) -> AnyPublisher<[GameModel], Error> {
        return self.local.likeDislike(game: game.toEntity()).map {
            GameEntities(entities: $0).toDomainModels()
        }.eraseToAnyPublisher()
    }
    
    func likedGames() -> AnyPublisher<[GameModel], Error> {
        return self.local.initialLiked().eraseToAnyPublisher().map {
            GameEntities(entities: $0).toDomainModels()
        }.eraseToAnyPublisher()
    }
}

extension GamebookRepository {
    struct Module: Cleanse.Module {
        static func configure(binder: Binder<Singleton>) {
            binder.include(module: LocalDataSource.Module.self)
            binder.include(module: RemoteDataSource.Module.self)
            binder.bind(GamebookRepositoryProtocol.self).to(factory: GamebookRepository.init)
            binder.bind(GamebookRepository.self).to(factory: GamebookRepository.init)
        }
    }
}
