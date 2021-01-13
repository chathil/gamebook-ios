//
//  File.swift
//  
//
//  Created by Abdul Chathil on 12/1/20.
//

import Core

public typealias FavoriteGamesInteractor = Interactor<Int32, [GamesModel], GetFavoriteGamesRepository<GetFavoriteGamesLocalDataSource, GamesTransformer<GameTransformer>>>
