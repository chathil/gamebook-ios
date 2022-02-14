//
//  File.swift
//  
//
//  Created by Abdul Chathil on 11/27/20.
//

import Core
import Combine
import Alamofire
import Cleanse
import Foundation

public struct GetGamesRemoteDataSource: DataSource {
    public typealias Request = String
    
    public typealias Response = GamesResponse
    
    public func execute(request: Request?) -> AnyPublisher<GamesResponse, Error> {
        if let request = request {
            let queryMap = ["search": request]
            return Future<GamesResponse, Error> { completion in
                if let url = URL(string: API.baseUrl) {
                    AF.request(url, parameters: queryMap, interceptor: ApiKeyInterceptor()).validate().responseDecodable(of: GamesResponse.self) { response in
                        switch response.result {
                        case .success(let value): completion(.success(value))
                        case .failure: completion(.failure(URLError.invalidResponse))
                        }
                    }
                }
            }.eraseToAnyPublisher()
        } else {
            return Future<GamesResponse, Error> { completion in
                if let url = URL(string: API.baseUrl) {
                  AF.request(url, interceptor: ApiKeyInterceptor()).validate().responseDecodable(of: GamesResponse.self) { response in
                        switch response.result {
                        case .success(let value): completion(.success(value))
                        case .failure: completion(.failure(URLError.invalidResponse))
                        }
                    }
                }
            }.eraseToAnyPublisher()
        }
    }
}

extension GetGamesRemoteDataSource {
    struct Module: Cleanse.Module {
        static func configure(binder: Binder<Singleton>) {
            binder.bind(GetGamesRemoteDataSource.self).to(factory: GetGamesRemoteDataSource.init)
        }
    }
}
