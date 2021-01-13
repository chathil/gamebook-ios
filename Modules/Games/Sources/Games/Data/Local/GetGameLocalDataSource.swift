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

public struct GetGameLocalDataSource: LocalDataSource {
    public typealias Request = Int32
    public typealias Response = GamesEntity?
    public typealias UpdateResponse = Bool
    
    private let realm: Realm
    
    public init(realm: Realm) {
        self.realm = realm
    }
    
    public func list(request: Int32?) -> AnyPublisher<[GamesEntity?], Error> {
        fatalError()
    }
    
    public func add(entities: [GamesEntity?]) -> AnyPublisher<Bool, Error> {
        fatalError()
    }
    
    public func get(id: Int32) -> AnyPublisher<GamesEntity?, Error> {
        Future<GamesEntity?, Error> { completion in
            
            let game: Results<GamesEntity> = {
                realm.objects(GamesEntity.self).filter("id == \(id)")
            }()
            completion(.success(game.toArray(ofType: GamesEntity.self).first))
            
        }.eraseToAnyPublisher()
    }
    
    public func update(id: Int32, entity: GamesEntity?) -> AnyPublisher<Bool, Error> {
        guard let entity = entity else {
            fatalError("entity is required to update")
        }
        return Future<Bool, Error> { completion in
            do {
                try realm.write {
                    realm.add(entity, update: .all)
                }
                completion(.success(true))
            } catch {
                completion(.failure(DatabaseError.requestFailed))
            }
        }.eraseToAnyPublisher()
    }
    
}

extension GetGameLocalDataSource {
    struct Module: Cleanse.Module {
        static func configure(binder: Binder<Singleton>) {
            binder.bind(GetGameLocalDataSource.self).to(factory: GetGameLocalDataSource.init)
        }
    }
}
