//
//  File.swift
//  
//
//  Created by Abdul Chathil on 11/27/20.
//

import Combine
 
public protocol LocalDataSource {
    associatedtype Request
    associatedtype Response
    associatedtype UpdateResponse
    
    func list(request: Request?) -> AnyPublisher<[Response], Error>
    func add(entities: [Response]) -> AnyPublisher<Bool, Error>
    func get(id: Int32) -> AnyPublisher<Response, Error>
    func update(id: Int32, entity: Response) -> AnyPublisher<UpdateResponse, Error>
}
