//
//  File.swift
//  
//
//  Created by Abdul Chathil on 11/27/20.
//

import Core
import Combine
import RealmSwift
import Cleanse

public struct GetGamesLocalDataSource: LocalDataSource {
    public typealias Request = String
    public typealias Response = GameEntity
    
    private let realm: Realm
    
    public init(realm: Realm) {
        self.realm = realm
    }
    
    public func list(request: String?) -> AnyPublisher<[GameEntity], Error> {
        return Future<[GameEntity], Error> { completion in
            
            let games: Results<GameEntity> = {
                realm.objects(GameEntity.self)
            }()
            
            completion(.success(games.toArray(ofType: GameEntity.self)))
            
        }.eraseToAnyPublisher()
    }
    
    public func add(entities: [GameEntity]) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            
            do {
                try realm.write {
                    for game in entities {
                        realm.add(game, update: .all)
                    }
                    completion(.success(true))
                }
            } catch {
                completion(.failure(DatabaseError.requestFailed))
            }
            
        }.eraseToAnyPublisher()
    }
    
    public func get(id: Int32) -> AnyPublisher<GameEntity, Error> {
        fatalError()
    }
    
    public func update(id: Int32, entity: GameEntity) -> AnyPublisher<GameEntity, Error> {
        fatalError()
    }
    
}

extension GetGamesLocalDataSource {
    struct Module: Cleanse.Module {
        static func configure(binder: Binder<Singleton>) {
            binder.include(module: Realm.Module.self)
            binder.bind(GetGamesLocalDataSource.self).to(factory: GetGamesLocalDataSource.init)
        }
    }
}
