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
    
    public typealias Response = GamesResponse
    
    public func execute(request: Request?) -> AnyPublisher<GamesResponse, Error> {
        
        if let request = request {
            // fake filtering is needed
            return Future<GamesResponse, Error> { completion in
                completion(.success(GamesResponse(results: GameResponse.fakeGames)))
            }.eraseToAnyPublisher()
        } else {
            return Future<GamesResponse, Error> { completion in
                completion(.success(GamesResponse(results: GameResponse.fakeGames)))
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
