//
//  MovieData.swift
//  fundamental-sub-one
//
//  Created by Abdul Chathil on 7/2/20.
//  Copyright © 2020 Abdul Chathil. All rights reserved.
//

import Combine
import CoreData

final class GameHomeData: ObservableObject {
    private let gameService: GameService
    private let context: NSManagedObjectContext
    @Published var error: String?
    @Published var isLoading: Bool = false
    @Published var games: [Game] = []
    @Published var likedIds: [Int32] = []
    
    init(gameService: GameService, context: NSManagedObjectContext) {
        self.gameService = gameService
        self.context = context
        loadGames()
    }
    
    func loadGames() {
        GameEntity.isLiked(context: context) {self.likedIds = $0}
        isLoading = true
        self.gameService.fetchGames(successHandler: {[weak self] (games) in
            self?.games = games.results
            self?.isLoading = false
        }, errorHandler: { (error) in
            self.isLoading = false
            self.error = error.localizedDescription
        })
    }
    
    func searchGames(query: String) {
        GameEntity.isLiked(context: context) {self.likedIds = $0}
        isLoading = true
        self.gameService.searchGame(query: query, params: nil, successHandler: {[weak self] (response) in
            self?.isLoading = false
            self?.games = response.results
        }, errorHandler: {[weak self] (error) in
            self?.isLoading = false
            self?.error = error.localizedDescription
        })
    }
}
