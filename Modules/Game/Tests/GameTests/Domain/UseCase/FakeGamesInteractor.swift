//
//  File.swift
//  
//
//  Created by Abdul Chathil on 12/8/20.
//

import Core
import Game

typealias FakeGamesInteractor = Interactor<String, [GameModel], GetGamesRepository<FakeGetGamesLocalDataSource, FakeGetGamesRemoteDataSource, GamesTransformer<GameTransformer>>>
