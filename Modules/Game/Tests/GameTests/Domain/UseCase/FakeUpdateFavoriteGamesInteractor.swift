//
//  File.swift
//  
//
//  Created by Abdul Chathil on 12/8/20.
//

import Core
import Game

typealias FakeUpdateFavoriteGamesInteractor = Interactor<GameModel, [GameModel], UpdateFavoriteGamesRepository<FakeGetFavoriteGamesLocalDataSource, GamesTransformer<GameTransformer>>>
