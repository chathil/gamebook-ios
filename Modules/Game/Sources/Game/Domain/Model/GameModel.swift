//
//  File.swift
//  
//
//  Created by Abdul Chathil on 11/28/20.
//

import Foundation

public struct GameModel: Equatable, Identifiable {
    public let id: Int32
    public let name: String
    public let descriptionRaw: String
    public let backgroundImage: String
    public let genres: [String]
    public let gameRating: String
    public let esrbRating: String
    public let metacritic: Int16
    public let publishers: [String]
    public let released: String
}
