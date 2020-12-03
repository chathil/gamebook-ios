//
//  File.swift
//  
//
//  Created by Abdul Chathil on 11/29/20.
//

import Core
import Cleanse

public typealias GamePresenter = GetPresenter<Int32, GameModel, Interactor<Int32, GameModel, GetGameRepository<GetGameLocalDataSource, GetGameRemoteDataSource, GameTransformer>>>

public extension GamePresenter {
    struct AssistedSeed: AssistedFactory {
        public typealias Seed = GameModel
        public typealias Element = GamePresenter
    }
}
