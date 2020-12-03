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

public struct GetFavoriteGamesLocalDataSource: LocalDataSource {
    public typealias Request = Int32
    public typealias Response = GameEntity
    public typealias UpdateResponse = [GameEntity]
    
    private let realm: Realm
    
    public init(realm: Realm) {
        self.realm = realm
    }
    
    public func list(request: Int32?) -> AnyPublisher<[GameEntity], Error> {
        return Future<[GameEntity], Error> { completion in
            
            let likedIds = {
                realm.objects(LikedGameIdEntity.self)
            }().toArray(ofType: LikedGameIdEntity.self).map { $0.id }
            
            let likedGames: Results<GameEntity> = {
                realm.objects(GameEntity.self).filter("id IN %@", likedIds)
            }()
            completion(.success(likedGames.toArray(ofType: GameEntity.self)))
            
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
            let cachedGame: Results<GameEntity> = {
                realm.objects(GameEntity.self).filter("id == \(id)")
            }()
            let alreadyLiked: Results<LikedGameIdEntity> = {
                realm.objects(LikedGameIdEntity.self).filter("id == \(id)")
            }()
            do {
                try realm.write {
                    if cachedGame.first == nil {
                        realm.add(entity, update: .all)
                    }
                    if alreadyLiked.first == nil {
                        realm.add(LikedGameIdEntity(id: id), update: .all)
                    } else {
                        realm.delete(alreadyLiked)
                    }
                }
                let likedIds = {
                    realm.objects(LikedGameIdEntity.self)
                }().toArray(ofType: LikedGameIdEntity.self).map { $0.id }
                let likedGames: Results<GameEntity> = {
                    realm.objects(GameEntity.self).filter("id IN %@", likedIds)
                }()
                completion(.success(likedGames.toArray(ofType: GameEntity.self)))
            } catch {
                completion(.failure(DatabaseError.requestFailed))
            }
        }.eraseToAnyPublisher()
    }
}

extension GetFavoriteGamesLocalDataSource {
    struct Module: Cleanse.Module {
        static func configure(binder: Binder<Singleton>) {
            binder.bind(GetFavoriteGamesLocalDataSource.self).to(factory: GetFavoriteGamesLocalDataSource.init)
        }
    }
}
