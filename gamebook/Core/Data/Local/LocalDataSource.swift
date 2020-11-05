//
//  LocalDataSource.swift
//  gamebook
//
//  Created by Abdul Chathil on 11/3/20.
//  Copyright © 2020 Abdul Chathil. All rights reserved.
//

import Foundation
import RealmSwift
import Combine
import Cleanse

protocol LocalDataSourceProtocol: class {
    func getGames() -> AnyPublisher<[GameEntity], Error>
    func getGame(id: Int32) -> AnyPublisher<GameEntity?, Error>
    func addGames(from games: [GameEntity]) -> AnyPublisher<Bool, Error>
    func likeDislike(game: GameEntity) -> AnyPublisher<[GameEntity], Error>
    func initialLiked() -> AnyPublisher<[GameEntity], Error>
}

final class LocalDataSource: NSObject {
    private let realm: Realm?
    
    init(realm: Realm?) {
        self.realm = realm
    }
    
}

extension LocalDataSource: LocalDataSourceProtocol {
    
    func getGames() -> AnyPublisher<[GameEntity], Error> {
        return Future<[GameEntity], Error> { completion in
            if let realm = self.realm {
                let games: Results<GameEntity> = {
                    realm.objects(GameEntity.self)
                }()
                
                completion(.success(games.toArray(ofType: GameEntity.self)))
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    func getGame(id: Int32) -> AnyPublisher<GameEntity?, Error> {
        return Future<GameEntity?, Error> { completion in
            if let realm = self.realm {
                let game: Results<GameEntity> = {
                    realm.objects(GameEntity.self).filter("id == \(id)")
                }()
                completion(.success(game.toArray(ofType: GameEntity.self).first))
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    func addGames(from games: [GameEntity]) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            if let realm = self.realm {
                do {
                    try realm.write {
                        for game in games {
                            print("\(game.name) added \(game.id)")
                            realm.add(game, update: .all)
                        }
                        completion(.success(true))
                    }
                } catch {
                    completion(.failure(DatabaseError.requestFailed))
                }
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    func updateGames(from game: GameEntity) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            if let realm = self.realm {
                do {
                    try realm.write {
                        realm.add(game, update: .all)
                    }
                    completion(.success(true))
                } catch {
                    completion(.failure(DatabaseError.requestFailed))
                }
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    func likeDislike(game: GameEntity) -> AnyPublisher<[GameEntity], Error> {
        return Future<[GameEntity], Error> { completion in
            if let realm = self.realm {
                let cachedGame: Results<GameEntity> = {
                    realm.objects(GameEntity.self).filter("id == \(game.id)")
                }()
                let alreadyLiked: Results<LikedGameIdEntity> = {
                    realm.objects(LikedGameIdEntity.self).filter("id == \(game.id)")
                }()
                do {
                    try realm.write {
                        if cachedGame.first == nil {
                            realm.add(game, update: .all)
                        }
                        if alreadyLiked.first == nil {
                            realm.add(LikedGameIdEntity(id: game.id), update: .all)
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
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    func initialLiked() -> AnyPublisher<[GameEntity], Error> {
        return Future<[GameEntity], Error> { completion in
            if let realm = self.realm {
                let likedIds = {
                    realm.objects(LikedGameIdEntity.self)
                }().toArray(ofType: LikedGameIdEntity.self).map { $0.id }
               
                let likedGames: Results<GameEntity> = {
                    realm.objects(GameEntity.self).filter("id IN %@", likedIds)
                }()
                completion(.success(likedGames.toArray(ofType: GameEntity.self)))
            }
        }.eraseToAnyPublisher()
    }
    
}

extension Results {
    
    func toArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()
        for index in 0 ..< count {
            if let result = self[index] as? T {
                array.append(result)
            }
        }
        return array
    }
    
}

extension LocalDataSource {
    struct Module: Cleanse.Module {
        static func configure(binder: Binder<Singleton>) {
            binder.bind(LocalDataSource.self).to { () -> LocalDataSource in
                LocalDataSource.init(realm: try? Realm()) }
        }
    }
}
