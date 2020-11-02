//
//  GameItemData.swift
//  fundamental-sub-one
//
//  Created by Abdul Chathil on 7/3/20.
//  Copyright © 2020 Abdul Chathil. All rights reserved.
//

import Combine

final class GameItemData: ObservableObject {
    private let gameService: GameService
    
    @Published var game: Game?
    @Published var isLoading: Bool = false
    private let gameId: Int32
    
    init(gameService: GameService, gameId: Int32, game: Game?) {
        self.gameService = gameService
        self.gameId = gameId
        self.game = game
    }
    
    func loadGame() {
        
        guard gameId != 0 else {
            return
        }
        
        isLoading = true
        gameService.fetchGame(id: gameId, successHandler: {[weak self] (game) in
            self?.game = game
            self?.isLoading = false
        }, errorHandler: { (error) in
            self.isLoading = false
            print(error.localizedDescription)
        })
    }
}
