//
//  GameService.swift
//  fundamental-sub-one
//
//  Created by Abdul Chathil on 7/2/20.
//  Copyright © 2020 Abdul Chathil. All rights reserved.
//

protocol GameService{
    func fetchGames(successHandler: @escaping (_ response: Games) -> Void, errorHandler: @escaping(_ error: Error) -> Void)
    func searchGame(query: String, params: [String: String]?, successHandler: @escaping (_ response: Games) -> Void, errorHandler: @escaping(_ error: Error) -> Void)
    func fetchGame(id: Int32, successHandler: @escaping (_ response: Game) -> Void, errorHandler: @escaping(_ error: Error) -> Void)
}

public enum GameError: Error {
    case apiError
    case invalidEndpoint
    case invalidResponse
    case noData
    case serializationError
}
