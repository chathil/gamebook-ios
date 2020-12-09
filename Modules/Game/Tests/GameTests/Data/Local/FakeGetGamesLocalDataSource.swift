//
//  File.swift
//  
//
//  Created by Abdul Chathil on 12/8/20.
//

import Core
import Combine
import Cleanse
import Game

struct FakeGetGamesLocalDataSource: LocalDataSource {
    public typealias Request = String
    public typealias Response = GameEntity
    public typealias UpdateResponse = [GameEntity]

    public func list(request: String?) -> AnyPublisher<[GameEntity], Error> {
        return Future<[GameEntity], Error> { completion in
            completion(.success(GamesTransformer(gameMapper: GameTransformer()).transformResponseToEntity(response: GameResponse.fakeGames)))
        }.eraseToAnyPublisher()
    }
    
    public func add(entities: [GameEntity]) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
                completion(.success(true))
            }.eraseToAnyPublisher()
    }
    
    public func get(id: Int32) -> AnyPublisher<GameEntity, Error> {
        fatalError()
    }
    
    func update(id: Int32, entity: GameEntity) -> AnyPublisher<[GameEntity], Error> {
        fatalError()
    }
}

extension FakeGetGamesLocalDataSource {
    struct Module: Cleanse.Module {
        static func configure(binder: Binder<Unscoped>) {
            binder.bind(FakeGetGamesLocalDataSource.self).to(factory: FakeGetGamesLocalDataSource.init)
        }
    }
}
