//
//  File.swift
//  
//
//  Created by Abdul Chathil on 11/27/20.
//

import Foundation
import RealmSwift

public class GamesEntity: Object {
    @objc dynamic var id: Int32 = -1
    @objc dynamic var name: String = ""
    @objc dynamic var backgroundImage: String = ""
    let genres = List<String>()
    @objc dynamic var gameRating: String = ""
    @objc dynamic var esrbRating: String = ""
    @objc dynamic var metacritic: Int16 = 0
    let publishers = List<String>()
    @objc dynamic var released: String = ""
    
    override init() {
        
    }
    
    required init(id: Int32,
                  name: String,
                  backgroundImage: String,
                  genres: [String],
                  gameRating: String,
                  esrbRating: String,
                  metacritic: Int16,
                  publishers: [String],
                  released: String) {
        self.id = id
        self.name = name
        self.backgroundImage = backgroundImage
        self.genres.append(objectsIn: genres.map { $0 })
        self.gameRating = gameRating
        self.esrbRating = esrbRating
        self.metacritic = metacritic
        self.publishers.append(objectsIn: publishers.map { $0 })
        self.released = released
    }
    
    public override static func primaryKey() -> String? {
        return "id"
    }
}
