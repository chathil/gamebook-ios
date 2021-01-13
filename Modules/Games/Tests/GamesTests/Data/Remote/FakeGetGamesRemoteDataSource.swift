//
//  File.swift
//  
//
//  Created by Abdul Chathil on 12/8/20.
//

import Foundation
import Game
import Combine
import Core
import Cleanse

struct FakeGetGamesRemoteDataSource: DataSource {
    public typealias Request = String
    
    public typealias Response = GamesResponseContainer
    
    public func execute(request: Request?) -> AnyPublisher<GamesResponseContainer, Error> {
        
        if let request = request {
            // fake filtering is needed
            return Future<GamesResponseContainer, Error> { completion in
                completion(.success(GamesResponseContainer(results: GameResponse.fakeGames)))
            }.eraseToAnyPublisher()
        } else {
            return Future<GamesResponseContainer, Error> { completion in
                completion(.success(GamesResponseContainer(results: GameResponse.fakeGames)))
            }.eraseToAnyPublisher()
        }
    }
}

extension FakeGetGamesRemoteDataSource {
    struct Module: Cleanse.Module {
        static func configure(binder: Binder<Unscoped>) {
            binder.bind(FakeGetGamesRemoteDataSource.self).to(factory: FakeGetGamesRemoteDataSource.init)
        }
    }
}
