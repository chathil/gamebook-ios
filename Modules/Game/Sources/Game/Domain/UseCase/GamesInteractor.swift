//
//  File.swift
//  
//
//  Created by Abdul Chathil on 12/1/20.
//

import Core

public typealias GamesInteractor = Interactor<String, [GameModel], GetGamesRepository<GetGamesLocalDataSource, GetGamesRemoteDataSource, GamesTransformer<GameTransformer>>>
