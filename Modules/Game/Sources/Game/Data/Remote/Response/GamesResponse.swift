//
//  File.swift
//  
//
//  Created by Abdul Chathil on 11/27/20.
//

import Foundation

public struct GamesResponse: Codable {
    public let results: [GameResponse]
}

public struct GameResponse: Codable, Identifiable {
    public let id: Int32
    public let name: String
    private let released: String?
    private let backgroundImage: String?
    private let rating: Double?
    private let ratingTop: Double?
    public let metacritic: Int16?
    private let genres: [Genre]?
    public let descriptionRaw: String?
    private let esrbRating: EsrbRating?
    private let publishers: [GamePublishers]?
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case released = "released"
        case backgroundImage = "background_image"
        case rating = "rating"
        case ratingTop = "rating_top"
        case metacritic = "metacritic"
        case genres = "genres"
        case descriptionRaw = "description_raw"
        case esrbRating = "esrb_rating"
        case publishers = "publishers"
        
    }
    
    public var backgroundUrl: String {
        return backgroundImage ?? "https://api.rawg.io/api/games"
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
    
    public var releaseDate: String? {
        if let dateStr = released {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            let date = formatter.date(from: dateStr)
            formatter.dateFormat = "MMM d, yyyy"
            return date.map {
                formatter.string(from: $0)
            }
        }
        return nil
    }
}

extension GameResponse {
    func toEntity() -> GameEntity {
        print(self.backgroundUrl)
        return GameEntity(id: self.id,
                          name: self.name,
                          descriptionRaw: self.descriptionRaw ?? "",
                          backgroundImage: self.backgroundUrl,
                          genres: self.genreNames,
                          gameRating: self.gameRating,
                          esrbRating: self.esrb ?? "",
                          metacritic: self.metacritic ?? 0,
                          publishers: self.publisherNames,
                          released: self.releaseDate ?? "")
    }
    
    func toDomainModel() -> GameModel {
        return GameModel(id: self.id,
                         name: self.name,
                         descriptionRaw: self.descriptionRaw ?? "No Description",
                         backgroundImage: self.backgroundUrl,
                         genres: self.genreNames,
                         gameRating: self.gameRating,
                         esrbRating: self.esrb ?? "No Rating",
                         metacritic: self.metacritic ?? 0,
                         publishers: self.publisherNames,
                         released: self.releaseDate ?? "No Date")
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

public struct GamePublishers: Codable {
    public let id: Int
    public let name: String
}

extension GameResponse {
    static var fakeGames: [GameResponse] {
        return [GameResponse.fakeGame, GameResponse.fakeGame, GameResponse.fakeGame, GameResponse.fakeGame]
    }
    
    public static var fakeGame: GameResponse {
        GameResponse(id: 1,
                     name: "Fake Game 2020",
                     released: "Date()",
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
