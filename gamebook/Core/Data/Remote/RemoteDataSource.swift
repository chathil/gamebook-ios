//
//  RemoteDataSource.swift
//  gamebook
//
//  Created by Abdul Chathil on 11/3/20.
//  Copyright © 2020 Abdul Chathil. All rights reserved.
//

import Foundation
import Alamofire
import Combine
import Cleanse

protocol RemoteDataSourceProtocol: class {
    func fetchGames() -> AnyPublisher<GamesResponse, Error>
    func searchGames(query: String) -> AnyPublisher<GamesResponse, Error>
    func fetchGame(id: Int32) -> AnyPublisher<GameResponse, Error>
}

final class RemoteDataSource: NSObject {
    
}

extension RemoteDataSource: RemoteDataSourceProtocol {
    func fetchGames() -> AnyPublisher<GamesResponse, Error> {
        return Future<GamesResponse, Error> { completion in
            if let url = URL(string: API.baseUrl) {
                AF.request(url).validate().responseDecodable(of: GamesResponse.self) { response in
                    switch response.result {
                    case .success(let value): completion(.success(value))
                    case .failure: completion(.failure(URLError.invalidResponse))
                    }
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func searchGames(query: String) -> AnyPublisher<GamesResponse, Error> {
        let queryMap = ["search": query]
        return Future<GamesResponse, Error> { completion in
            if let url = URL(string: API.baseUrl) {
                AF.request(url, parameters: queryMap).validate().responseDecodable(of: GamesResponse.self) { response in
                    switch response.result {
                    case .success(let value): completion(.success(value))
                    case .failure: completion(.failure(URLError.invalidResponse))
                    }
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func fetchGame(id: Int32) -> AnyPublisher<GameResponse, Error> {
        return Future<GameResponse, Error> { completion in
            if let url = URL(string: "\(API.baseUrl)/\(id)") {
                AF.request(url).validate().responseDecodable(of: GameResponse.self) { response in
                    switch response.result {
                    case .success(let value): completion(.success(value))
                    case .failure: completion(.failure(URLError.invalidResponse))
                    }
                }
            }
        }.eraseToAnyPublisher()
    }
}

extension RemoteDataSource {
    struct Module: Cleanse.Module {
        static func configure(binder: Binder<Singleton>) {
            binder.bind(RemoteDataSource.self).to(factory: RemoteDataSource.init)
        }
    }
}

struct API {
    static let baseUrl = "https://api.rawg.io/api/games"
}
