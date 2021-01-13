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
    public typealias Response = GamesEntity
    public typealias UpdateResponse = [GamesEntity]

    public func list(request: String?) -> AnyPublisher<[GamesEntity], Error> {
        return Future<[GamesEntity], Error> { completion in
            completion(.success(GamesTransformer(gameMapper: GameTransformer()).transformResponseToEntity(response: GamesResponse.fakeGames)))
        }.eraseToAnyPublisher()
    }
    
    public func add(entities: [GamesEntity]) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
                completion(.success(true))
            }.eraseToAnyPublisher()
    }
    
    public func get(id: Int32) -> AnyPublisher<GamesEntity, Error> {
        fatalError()
    }
    
    func update(id: Int32, entity: GamesEntity) -> AnyPublisher<[GamesEntity], Error> {
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
