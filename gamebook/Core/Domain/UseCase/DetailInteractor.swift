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
}

extension DetailInteractor {
    struct AssistedSeed: AssistedFactory {
        typealias Seed = GameModel
        typealias Element = DetailInteractor
    }
    struct Module: Cleanse.Module {
        public static func configure(binder: UnscopedBinder) {
            binder
                .bindFactory(DetailInteractor.self)
                .with(AssistedSeed.self)
                .to { (seed: Assisted<GameModel>, repository: Provider<GamebookRepository>) in
                    return DetailInteractor(repository: repository.get(), game: seed)
                }
        }
    }
}
