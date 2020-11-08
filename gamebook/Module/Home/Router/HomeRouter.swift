//
//  HomeRouter.swift
//  gamebook
//
//  Created by Abdul Chathil on 11/3/20.
//  Copyright © 2020 Abdul Chathil. All rights reserved.
//

import SwiftUI
import Cleanse

class HomeRouter {
    let detailUseCase: Factory<DetailInteractor.AssistedSeed>
    let favoriteUseCase: FavoriteInteractor
    
    init(detailUseCase: Factory<DetailInteractor.AssistedSeed>, favoriteUseCase: FavoriteInteractor) {
        self.detailUseCase = detailUseCase
        self.favoriteUseCase = favoriteUseCase
    }
    
    func makeDetailView(for game: GameModel) -> some View {
        let presenter = DetailPresenter(detailUseCase: detailUseCase.build(game))
        return DetailScreen(presenter: presenter)
    }
    
    func makeFavoriteView(showingFrom: Bool) -> some View {
        let presenter = FavoritePresenter(
            favoriteUseCase: favoriteUseCase,
            favoriteRouter: FavoriteRouter(detailUseCase: detailUseCase))
        return FavoriteScreen(presenter: presenter, showingForm: showingFrom)
    }
}

extension HomeRouter {
    struct Module: Cleanse.Module {
        static func configure(binder: Binder<Singleton>) {
            binder.include(module: DetailInteractor.Module.self)
            binder.include(module: FavoriteInteractor.Module.self)
            binder.bind(HomeRouter.self).to(factory: HomeRouter.init)
        }
    }
}
