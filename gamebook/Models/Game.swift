//
//  Game.swift
//  fundamental-sub-one
//
//  Created by Abdul Chathil on 7/2/20.
//  Copyright © 2020 Abdul Chathil. All rights reserved.
//
import Foundation

public struct Games: Codable {
    public let results: [Game]
}

public struct Game: Codable, Identifiable {
    public let id: Int32
    public let name: String
    private let released: Date?
    private let backgroundImage: String?
    private let rating: Double?
    private let ratingTop: Double?
    public let metacritic: Int16?
    private let genres: [Genre]?
    public let descriptionRaw: String?
    private let esrbRating: EsrbRating?
    private let publishers: [Publishers]?
    
    public var backgroundUrl: URL {
        return URL(string: backgroundImage ?? "https://api.rawg.io/api/games")!
    }
    
    public var gameRating: String {
        return "\(rating ?? 0)/ \(ratingTop ?? 5)"
    }
    
    public var genre: String {
        if let genres = genres {
            return genres.isEmpty ? "No Genre" : genres[0].name
        }
        return "No Genre"
    }
    
    public var genreNames: [String] {
        return genres?.map {$0.name} ?? ["No Genre"]
    }
    
    public var esrb: String? {
        return esrbRating?.name ?? "No ESRB Rating"
    }
    
    public var publisherNames: [String] {
        return publishers?.map {$0.name} ?? ["No Publisher"]
    }
    
    public var releaseDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy"
        if released == nil {
            return "Unknown"
        }
        return formatter.string(from: released!)
    }
}

public struct Genre: Codable {
    public let id: Int
    public let name: String
}

public struct EsrbRating: Codable {
    public let id: Int
    public let name: String
}

public struct Publishers: Codable {
    public let id: Int
    public let name: String
}

extension Game {
    static var fakeGames: [Game] {
        return [Game.fakeGame, Game.fakeGame, Game.fakeGame, Game.fakeGame]
    }
    
    static var fakeGame: Game {
        Game(id: 1,
             name: "Fake Game 2020",
             released: Date(),
             backgroundImage: "bgimg",
             rating: 1.0,
             ratingTop: 5.0,
             metacritic: 90,
             genres: [],
             descriptionRaw: nil,
             esrbRating: nil,
             publishers: nil)
    }
    
}
