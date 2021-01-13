//
//  HomeRouter.swift
//  gamebook
//
//  Created by Abdul Chathil on 11/3/20.
//  Copyright © 2020 Abdul Chathil. All rights reserved.
//

import SwiftUI
import Cleanse
import Games
import Core
import User

class HomeRouter {
    let gamePresenter: Factory<GamePresenter.AssistedSeed>
    let favoriteGamesPresenter: FavoriteGamesPresenter
    let updateFavoriteGamesPresenter: UpdateFavoriteGamesPresenter
    
    init(gamePresenter: Factory<GamePresenter.AssistedSeed>, favoriteGamesPresenter: FavoriteGamesPresenter, updateFavoriteGamesPresenter: UpdateFavoriteGamesPresenter) {
        self.gamePresenter = gamePresenter
        self.favoriteGamesPresenter = favoriteGamesPresenter
        self.updateFavoriteGamesPresenter = updateFavoriteGamesPresenter
    }
    
    func makeDetailView(for game: GamesModel) -> some View {
        return DetailScreen(gamePresenter: gamePresenter.build(game))
    }
    
    func makeFavoriteView() -> some View {
        return FavoriteScreen(favoriteRouter: FavoriteRouter(gamePresenter: gamePresenter), favoriteGamesPresenter: favoriteGamesPresenter, updateFavoriteGamesPresenter: updateFavoriteGamesPresenter)
    }
    
    func makeAboutView() -> some View {
        let presenter = UserPresenter()
        return AboutScreen(presenter: presenter)
    }
}

extension HomeRouter {
    struct Module: Cleanse.Module {
        static func configure(binder: Binder<Singleton>) {
            binder.include(module: GamePresenter.Module.self)
            binder.bind(HomeRouter.self).to(factory: HomeRouter.init)
        }
    }
}
