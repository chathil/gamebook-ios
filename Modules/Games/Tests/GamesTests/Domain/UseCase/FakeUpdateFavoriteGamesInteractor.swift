//
//  File.swift
//  
//
//  Created by Abdul Chathil on 12/8/20.
//

import Core
import Game

typealias FakeUpdateFavoriteGamesInteractor = Interactor<GamesModel, [GamesModel], UpdateFavoriteGamesRepository<FakeGetFavoriteGamesLocalDataSource, GamesTransformer<GameTransformer>>>
