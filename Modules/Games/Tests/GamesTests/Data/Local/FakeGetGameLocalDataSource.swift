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
    public typealias Response = GamesEntity?
    public typealias UpdateResponse = Bool
    
    public func list(request: Int32?) -> AnyPublisher<[GamesEntity?], Error> {
        fatalError()
    }
    
    public func add(entities: [GamesEntity?]) -> AnyPublisher<Bool, Error> {
        fatalError()
    }
    
    public func get(id: Int32) -> AnyPublisher<GamesEntity?, Error> {
        Future<GamesEntity?, Error> { completion in
            completion(.success(GameTransformer().transformResponseToEntity(response: GamesResponse.fakeGame)))
            
        }.eraseToAnyPublisher()
    }
    
    public func update(id: Int32, entity: GamesEntity?) -> AnyPublisher<Bool, Error> {
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
