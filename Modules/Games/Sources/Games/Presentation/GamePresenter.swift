//
//  File.swift
//  
//
//  Created by Abdul Chathil on 11/29/20.
//

import Core
import Cleanse

public typealias GamePresenter = GetPresenter<Int32, GamesModel, Interactor<Int32, GamesModel, GetGameRepository<GetGameLocalDataSource, GetGameRemoteDataSource, GameTransformer>>>

public extension GamePresenter {
    struct AssistedSeed: AssistedFactory {
        public typealias Seed = GamesModel
        public typealias Element = GamePresenter
    }
}
