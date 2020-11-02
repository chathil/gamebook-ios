//
//  GameStore.swift
//  fundamental-sub-one
//
//  Created by Abdul Chathil on 7/2/20.
//  Copyright © 2020 Abdul Chathil. All rights reserved.
//

import Foundation

public class GameStore: GameService {
    
    public static let shared = GameStore()
    private init() {}
    private let baseUrl = "https://api.rawg.io/api/games"
    private let urlSession = URLSession.shared
    
    private let jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
        return jsonDecoder
    }()
    
    func fetchGames(successHandler: @escaping (Games) -> Void, errorHandler: @escaping (Error) -> Void) {
        guard let urlComponents = URLComponents(string: baseUrl) else { errorHandler(GameError.invalidEndpoint)
            return
        }
        
        guard let url = urlComponents.url else {
            errorHandler(GameError.invalidEndpoint)
            return
        }
        
        urlSession.dataTask(with: url) { (data, response, error) in
            if error != nil {
                self.handleError(errorHandler: errorHandler, error: GameError.apiError)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                200..<300 ~= httpResponse.statusCode else {
                    self.handleError(errorHandler: errorHandler, error: GameError.invalidResponse)
                    return
            }
            
            guard let data = data else {
                self.handleError(errorHandler: errorHandler, error: GameError.noData)
                return
            }
            
            do {
                let gamesResponse = try
                    self.jsonDecoder.decode(Games.self, from: data)
                DispatchQueue.main.async {
                    successHandler(gamesResponse)
                }
            } catch {
                self.handleError(errorHandler: errorHandler, error: GameError.serializationError)
            }
        }.resume()
    }
    
    func searchGame(query: String,
                    params: [String: String]?,
                    successHandler: @escaping (Games) -> Void,
                    errorHandler: @escaping (Error) -> Void) {
        
        guard var urlComponents = URLComponents(string: baseUrl) else {
            errorHandler(GameError.invalidEndpoint)
            return
        }
        
        urlComponents.queryItems = [URLQueryItem(name: "search", value: query)]
        
        guard let url = urlComponents.url else {
            errorHandler(GameError.invalidEndpoint)
            return
        }
        
        urlSession.dataTask(with: url) {(data, response, error) in
            if error != nil {
                self.handleError(errorHandler: errorHandler, error: GameError.apiError)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                self.handleError(errorHandler: errorHandler, error: GameError.invalidResponse)
                return
            }
            
            guard let data = data else {
                self.handleError(errorHandler: errorHandler, error: GameError.noData)
                return
            }
            
            do {
                let gameResponse = try
                    self.jsonDecoder.decode(Games.self, from: data)
                DispatchQueue.main.async {
                    successHandler(gameResponse)
                }
            } catch {
                self.handleError(errorHandler: errorHandler, error: GameError.serializationError)
            }
            
        }.resume()
    }
    
    public func fetchGame(id: Int32,
                          successHandler: @escaping (Game) -> Void,
                          errorHandler: @escaping (Error) -> Void) {
        guard let url = URL(string: "\(baseUrl)/\(id)") else {
            handleError(errorHandler: errorHandler, error: GameError.invalidEndpoint)
            return
        }
        
        urlSession.dataTask(with: url) { (data, response, error) in
            if error != nil {
                self.handleError(errorHandler: errorHandler, error: GameError.apiError)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~=
                httpResponse.statusCode else {
                    self.handleError(errorHandler: errorHandler, error: GameError.invalidResponse)
                    return
            }
            
            guard let data = data else {
                self.handleError(errorHandler: errorHandler, error: GameError.noData)
                return
            }
            
            do {
                let game = try self.jsonDecoder.decode(Game.self, from: data)
                DispatchQueue.main.async {
                    successHandler(game)
                }
            } catch {
                self.handleError(errorHandler: errorHandler, error: GameError.serializationError)
            }
        }.resume()
    }
    
    private func handleError(errorHandler: @escaping(_ error: Error) -> Void, error: Error) {
        DispatchQueue.main.async {
            errorHandler(error)
        }
    }
}
