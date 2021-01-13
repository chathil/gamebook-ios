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
    public typealias Response = GamesEntity
    
    private let realm: Realm
    
    public init(realm: Realm) {
        self.realm = realm
    }
    
    public func list(request: String?) -> AnyPublisher<[GamesEntity], Error> {
        return Future<[GamesEntity], Error> { completion in
            
            let games: Results<GamesEntity> = {
                realm.objects(GamesEntity.self)
            }()
            
            completion(.success(games.toArray(ofType: GamesEntity.self)))
            
        }.eraseToAnyPublisher()
    }
    
    public func add(entities: [GamesEntity]) -> AnyPublisher<Bool, Error> {
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
    
    public func get(id: Int32) -> AnyPublisher<GamesEntity, Error> {
        fatalError()
    }
    
    public func update(id: Int32, entity: GamesEntity) -> AnyPublisher<GamesEntity, Error> {
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
