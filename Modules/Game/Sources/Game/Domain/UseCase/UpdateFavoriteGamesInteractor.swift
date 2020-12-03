//
//  File.swift
//  
//
//  Created by Abdul Chathil on 12/1/20.
//

import Core

public typealias UpdateFavoriteGamesInteractor = Interactor<GameModel, [GameModel], UpdateFavoriteGamesRepository<GetFavoriteGamesLocalDataSource, GamesTransformer<GameTransformer>>>
