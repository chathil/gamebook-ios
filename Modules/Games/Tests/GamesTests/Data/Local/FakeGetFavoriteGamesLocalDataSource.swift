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
    public typealias Response = GamesEntity
    public typealias UpdateResponse = [GamesEntity]
    
    public func list(request: Int32?) -> AnyPublisher<[GamesEntity], Error> {
        return Future<[GamesEntity], Error> { completion in
            completion(.success(GamesTransformer(gameMapper: GameTransformer()).transformResponseToEntity(response: GamesResponse.fakeGames)))
        }.eraseToAnyPublisher()
    }
    
    public func add(entities: [GamesEntity]) -> AnyPublisher<Bool, Error> {
        fatalError()
    }
    
    public func get(id: Int32) -> AnyPublisher<GamesEntity, Error> {
        fatalError()
    }
    
    public func update(id: Int32, entity: GamesEntity) -> AnyPublisher<[GamesEntity], Error> {
        return Future<[GamesEntity], Error> { completion in
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
