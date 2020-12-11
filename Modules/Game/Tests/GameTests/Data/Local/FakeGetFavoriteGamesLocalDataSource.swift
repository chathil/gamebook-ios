//
//  File.swift
//  
//
//  Created by Abdul Chathil on 12/8/20.
//

import Core
import Combine
import RealmSwift
import Game
import Cleanse

struct FakeGetFavoriteGamesLocalDataSource: LocalDataSource {
    public typealias Request = Int32
    public typealias Response = GameEntity
    public typealias UpdateResponse = [GameEntity]
    
    public func list(request: Int32?) -> AnyPublisher<[GameEntity], Error> {
        return Future<[GameEntity], Error> { completion in
            completion(.success(GamesTransformer(gameMapper: GameTransformer()).transformResponseToEntity(response: GameResponse.fakeGames)))
        }.eraseToAnyPublisher()
    }
    
    public func add(entities: [GameEntity]) -> AnyPublisher<Bool, Error> {
        fatalError()
    }
    
    public func get(id: Int32) -> AnyPublisher<GameEntity, Error> {
        fatalError()
    }
    
    public func update(id: Int32, entity: GameEntity) -> AnyPublisher<[GameEntity], Error> {
        return Future<[GameEntity], Error> { completion in
                completion(.success([entity]))
            
        }.eraseToAnyPublisher()
    }
}

extension FakeGetFavoriteGamesLocalDataSource {
    struct Module: Cleanse.Module {
        static func configure(binder: Binder<Unscoped>) {
            binder.bind(FakeGetFavoriteGamesLocalDataSource.self).to(factory: FakeGetFavoriteGamesLocalDataSource.init)
        }
    }
}
