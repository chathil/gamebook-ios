//
//  File.swift
//  
//
//  Created by Abdul Chathil on 12/8/20.
//

import Core
import Game

typealias UpdateFavoriteGamesInteractor = Interactor<GameModel, [GameModel], UpdateFavoriteGamesRepository<GetFavoriteGamesLocalDataSource, GamesTransformer<GameTransformer>>>
