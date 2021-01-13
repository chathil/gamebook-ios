//
//  File.swift
//  
//
//  Created by Abdul Chathil on 12/8/20.
//

import Foundation
import Game
import Combine
import Cleanse
import Core

struct FakeGetGameRemoteDataSource: DataSource {
    public typealias Request = Int32
    
    public typealias Response = GamesResponse
    
    public func execute(request: Request?) -> AnyPublisher<Response, Error> {
        guard let request = request else {
            fatalError("an id is needed")
        }
        return Future<GamesResponse, Error> { completion in
            if let url = URL(string: "\(API.baseUrl)/\(request)") {
                Future<GamesResponse, Error> { completion in
                    completion(.success(GamesResponse.fakeGame))
                }
            }
        }.eraseToAnyPublisher()
    }
}

extension FakeGetGameRemoteDataSource {
    struct Module: Cleanse.Module {
        static func configure(binder: Binder<Unscoped>) {
            binder.bind(FakeGetGameRemoteDataSource.self).to(factory: FakeGetGameRemoteDataSource.init)
        }
    }
}
