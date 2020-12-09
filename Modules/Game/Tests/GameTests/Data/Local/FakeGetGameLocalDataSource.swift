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

struct FakeGetGameLocalDataSource: LocalDataSource {
    public typealias Request = Int32
    public typealias Response = GameEntity?
    public typealias UpdateResponse = Bool
    
    public func list(request: Int32?) -> AnyPublisher<[GameEntity?], Error> {
        fatalError()
    }
    
    public func add(entities: [GameEntity?]) -> AnyPublisher<Bool, Error> {
        fatalError()
    }
    
    public func get(id: Int32) -> AnyPublisher<GameEntity?, Error> {
        Future<GameEntity?, Error> { completion in
            completion(.success(GameTransformer().transformResponseToEntity(response: GameResponse.fakeGame)))
            
        }.eraseToAnyPublisher()
    }
    
    public func update(id: Int32, entity: GameEntity?) -> AnyPublisher<Bool, Error> {
        guard let entity = entity else {
            fatalError("entity is required to update")
        }
        return Future<Bool, Error> { completion in
                completion(.success(true))
        }.eraseToAnyPublisher()
    }
}

extension FakeGetGameLocalDataSource {
    struct Module: Cleanse.Module {
        static func configure(binder: Binder<Unscoped>) {
            binder.bind(FakeGetGameLocalDataSource.self).to(factory: FakeGetGameLocalDataSource.init)
        }
    }
}
