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

public struct GetGameRemoteDataSource: DataSource {
    public typealias Request = Int32
    
    public typealias Response = GameResponse
    let apiKey = ""
    public func execute(request: Request?) -> AnyPublisher<Response, Error> {
        guard let request = request else {
            fatalError("an id is needed")
        }
        return Future<GameResponse, Error> { completion in
            if let url = URL(string: "\(API.baseUrl)/\(request)") {
              AF.request(url, interceptor: ApiKeyInterceptor())
                .validate().responseDecodable(of: GameResponse.self) { response in
                    switch response.result {
                    case .success(let value): completion(.success(value))
                    case .failure: completion(.failure(URLError.invalidResponse))
                    }
                }
            }
        }.eraseToAnyPublisher()
    }
}

extension GetGameRemoteDataSource {
    struct Module: Cleanse.Module {
        static func configure(binder: Binder<Singleton>) {
            binder.bind(GetGameRemoteDataSource.self).to(factory: GetGameRemoteDataSource.init)
        }
    }
}
