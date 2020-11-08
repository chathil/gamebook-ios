//
//  FavoriteRouter.swift
//  gamebook
//
//  Created by Abdul Chathil on 11/7/20.
//  Copyright © 2020 Abdul Chathil. All rights reserved.
//

import SwiftUI
import Cleanse

class FavoriteRouter {
    let detailUseCase: Factory<DetailInteractor.AssistedSeed>
    init(detailUseCase: Factory<DetailInteractor.AssistedSeed>) {
        self.detailUseCase = detailUseCase
    }
    func makeDetailView(for game: GameModel) -> some View {
        let presenter = DetailPresenter(detailUseCase: detailUseCase.build(game))
        return DetailScreen(presenter: presenter)
    }
}

extension FavoriteRouter {
    struct Module: Cleanse.Module {
        static func configure(binder: Binder<Unscoped>) {
            binder.include(module: DetailInteractor.Module.self)
            binder.bind(FavoriteRouter.self).to(factory: FavoriteRouter.init)
        }
    }
}


