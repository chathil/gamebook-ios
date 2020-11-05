//
//  HomeInteractor.swift
//  gamebook
//
//  Created by Abdul Chathil on 11/3/20.
//  Copyright © 2020 Abdul Chathil. All rights reserved.
//

import Combine
import Cleanse

protocol HomeUseCase {
    func getGames() -> AnyPublisher<[GameModel], Error>
    func likeDislike(game: GameModel) -> AnyPublisher<[Int32], Error>
    func likedIds() -> AnyPublisher<[Int32], Error>
}

class HomeInteractor: HomeUseCase {
    private let repository: GamebookRepositoryProtocol
    required init(repository: GamebookRepositoryProtocol) {
        self.repository = repository
    }
    
    func getGames() -> AnyPublisher<[GameModel], Error> {
        return repository.getGames()
    }
    
    func likeDislike(game: GameModel) -> AnyPublisher<[Int32], Error> {
        return repository.likeDislike(game: game)
    }
    
    func likedIds() -> AnyPublisher<[Int32], Error> {
        return repository.likedIds()
    }
    
}
extension HomeInteractor {
    struct Module: Cleanse.Module {
        static func configure(binder: Binder<Singleton>) {
            binder.include(module: GamebookRepository.Module.self)
            binder.bind(HomeUseCase.self).to(factory: HomeInteractor.init)
            binder.bind(HomeInteractor.self).to(factory: HomeInteractor.init)
        }
    }
}
