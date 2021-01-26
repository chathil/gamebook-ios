//
//  DetailInteractor.swift
//  gamebook
//
//  Created by Abdul Chathil on 11/3/20.
//  Copyright © 2020 Abdul Chathil. All rights reserved.
//

import Cleanse
import Combine

protocol DetailUseCase {
    func getGame() -> AnyPublisher<GameModel?, Error>
    func getGame() -> GameModel
    func likeDislike(game: GameModel) -> AnyPublisher<[GameModel], Error>
    func likedGames() -> AnyPublisher<[GameModel], Error>
}

class DetailInteractor: DetailUseCase {
    private let repository: GamebookRepositoryProtocol
    private let game: GameModel
    
    required init(repository: GamebookRepositoryProtocol, game: Assisted<GameModel>) {
        self.repository = repository
        self.game = game.get()
    }
    
    func getGame() -> GameModel {
        return game
    }
    func getGame() -> AnyPublisher<GameModel?, Error> {
        return repository.getGame(id: game.id)
    }
  
    func likeDislike(game: GameModel) -> AnyPublisher<[GameModel], Error> {
        return repository.likeDislike(game: game)
    }
    
    func likedGames() -> AnyPublisher<[GameModel], Error> {
        return repository.likedGames()
    }
  
}

extension DetailInteractor {
    struct AssistedSeed: AssistedFactory {
        typealias Seed = GameModel
        typealias Element = DetailUseCase
    }
    struct Module: Cleanse.Module {
        public static func configure(binder: UnscopedBinder) {
            binder
                .bindFactory(DetailUseCase.self)
                .with(AssistedSeed.self)
                .to { (seed: Assisted<GameModel>, repository: Provider<GamebookRepository>) in
                    return DetailInteractor(repository: repository.get(), game: seed)
                }
        }
    }
}

class DetailInteractorPreview: DetailUseCase {
  
    func getGame() -> AnyPublisher<GameModel?, Error> {
        return Future<GameModel?, Error> { completion in
            completion(.success(GameResponse.fakeGame.toDomainModel()))
        }.eraseToAnyPublisher()
    }
    
    func getGame() -> GameModel {
        return GameResponse.fakeGame.toDomainModel()
    }
  
    func likeDislike(game: GameModel) -> AnyPublisher<[GameModel], Error> {
        return Future<[GameModel], Error> { completion in
            completion(.success([GameResponse.fakeGame.toDomainModel()]))
        }.eraseToAnyPublisher()
    }
    
    func likedGames() -> AnyPublisher<[GameModel], Error> {
        return Future<[GameModel], Error> { completion in
            completion(.success([GameResponse.fakeGame.toDomainModel()]))
        }.eraseToAnyPublisher()
    }
  
}
