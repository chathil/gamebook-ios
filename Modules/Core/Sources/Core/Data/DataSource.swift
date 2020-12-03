//
//  File.swift
//  
//
//  Created by Abdul Chathil on 11/27/20.
//

import Combine
 
public protocol DataSource {
    associatedtype Request
    associatedtype Response
    
    func execute(request: Request?) -> AnyPublisher<Response, Error>
}

public struct API {
    public static let baseUrl = "https://api.rawg.io/api/games"
}
