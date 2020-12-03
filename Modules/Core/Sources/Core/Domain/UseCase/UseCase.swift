//
//  File.swift
//  
//
//  Created by Abdul Chathil on 11/27/20.
//

import Combine
 
public protocol UseCase {
    associatedtype Request
    associatedtype Response
    
    func execute(request: Request?) -> AnyPublisher<Response, Error>
}
