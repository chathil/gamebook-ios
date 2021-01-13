//
//  FavoriteRouter.swift
//  gamebook
//
//  Created by Abdul Chathil on 11/7/20.
//  Copyright © 2020 Abdul Chathil. All rights reserved.
//

import SwiftUI
import Cleanse
import Games

class FavoriteRouter {
    let gamePresenter: Factory<GamePresenter.AssistedSeed>
    
    init(gamePresenter: Factory<GamePresenter.AssistedSeed>) {
        self.gamePresenter = gamePresenter
    }
    
    func makeDetailView(for game: GamesModel) -> some View {
        return DetailScreen(gamePresenter: gamePresenter.build(game))
    }
}

extension FavoriteRouter {
    struct Module: Cleanse.Module {
        static func configure(binder: Binder<Unscoped>) {
            binder.bind(FavoriteRouter.self).to(factory: FavoriteRouter.init)
        }
    }
}
