//
//  File.swift
//  
//
//  Created by Abdul Chathil on 12/8/20.
//

import Core
import Game

typealias FakeFavoriteGamesInteractor = Interactor<Int32, [GameModel], GetFavoriteGamesRepository<FakeGetFavoriteGamesLocalDataSource, GamesTransformer<GameTransformer>>>
