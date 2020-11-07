//
//  HomeRouter.swift
//  gamebook
//
//  Created by Abdul Chathil on 11/3/20.
//  Copyright © 2020 Abdul Chathil. All rights reserved.
//

import SwiftUI
import Cleanse

protocol HomeRouterProtocol {}

class HomeRouter: HomeRouterProtocol {
    let detailUseCase: Factory<DetailInteractor.AssistedSeed>
    init(detailUseCase: Factory<DetailInteractor.AssistedSeed>) {
        self.detailUseCase = detailUseCase
    }
    func makeDetailView(for game: GameModel) -> some View {
        let presenter = DetailPresenter(detailUseCase: detailUseCase.build(game))
        return DetailScreen(presenter: presenter)
    }
}

extension HomeRouter {
    struct Module: Cleanse.Module {
        static func configure(binder: Binder<Unscoped>) {
            binder.include(module: DetailInteractor.Module.self)
            binder.bind(HomeRouterProtocol.self).to(factory: HomeRouter.init)
            binder.bind(HomeRouter.self).to(factory: HomeRouter.init)
        }
    }
}

class HomeRouterPreview: HomeRouterProtocol {}
