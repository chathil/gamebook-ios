//
//  FavoriteInteractor.swift
//  gamebook
//
//  Created by Abdul Chathil on 11/6/20.
//  Copyright © 2020 Abdul Chathil. All rights reserved.
//

import Foundation
import Combine
import Cleanse

protocol FavoriteUseCase {
    func getFavoriteGame() -> AnyPublisher<[GameModel], Error>
    func likeDislikeGame(game: GameModel) -> AnyPublisher<[GameModel], Error>
}

class FavoriteInteractor: FavoriteUseCase {
    private let repository: GamebookRepositoryProtocol
    
    required init(repository: GamebookRepositoryProtocol) {
        self.repository = repository
    }
    
    func getFavoriteGame() -> AnyPublisher<[GameModel], Error> {
        return repository.likedGames()
    }
    func likeDislikeGame(game: GameModel) -> AnyPublisher<[GameModel], Error> {
        return repository.likeDislike(game: game)
    }
}

extension FavoriteInteractor {
    struct Module: Cleanse.Module {
        static func configure(binder: Binder<Singleton>) {
            binder.include(module: GamebookRepository.Module.self)
            binder.bind(FavoriteUseCase.self).to(factory: FavoriteInteractor.init)
            binder.bind(FavoriteInteractor.self).to(factory: FavoriteInteractor.init)
        }
    }
}

class FavoriteInteractorPreview: FavoriteUseCase {
    func getFavoriteGame() -> AnyPublisher<[GameModel], Error> {
        return Future<[GameModel], Error> { completion in
            completion(.success(GameResponse.fakeGames.map { $0.toDomainModel() }))
        }.eraseToAnyPublisher()
    }
    
    func likeDislikeGame(game: GameModel) -> AnyPublisher<[GameModel], Error> {
        return Future<[GameModel], Error> { completion in
            completion(.success(GameResponse.fakeGames.map { $0.toDomainModel() }))
        }.eraseToAnyPublisher()
    }
}
