//
//  FavoritePresenter.swift
//  gamebook
//
//  Created by Abdul Chathil on 11/7/20.
//  Copyright © 2020 Abdul Chathil. All rights reserved.
//

import SwiftUI
import Combine
import Cleanse

class FavoritePresenter: ObservableObject {
    private var cancellables: Set<AnyCancellable> = []
    private var favoriteRouter: FavoriteRouter
    private let favoriteUseCase: FavoriteUseCase
    
    @Published var games: [GameModel] = []
    @Published var errorMessage: String = ""
    @Published var loadingState: Bool = false
    
    init(favoriteUseCase: FavoriteUseCase, favoriteRouter: FavoriteRouter) {
        self.favoriteRouter = favoriteRouter
        self.favoriteUseCase = favoriteUseCase
    }
    
    func likeDislikeGame(game: GameModel) {
        favoriteUseCase.likeDislikeGame(game: game).receive(on: RunLoop.main)
            .sink(receiveCompletion: { _ in },
                  receiveValue: {
                    self.games = $0
                  }).store(in: &cancellables)
    }
    
    func initialLiked() {
        favoriteUseCase.getFavoriteGame().receive(on: RunLoop.main)
            .sink(receiveCompletion: {_ in},
                  receiveValue: {
                    self.games = $0
                  }).store(in: &cancellables)
    }
    
    func linkBuilder<Content: View>(
        for game: GameModel,
        @ViewBuilder content: () -> Content
    ) -> some View {
        NavigationLink(
            destination: favoriteRouter.makeDetailView(for: game)) { content() }
    }
}

extension FavoritePresenter {
    struct Module: Cleanse.Module {
        static func configure(binder: Binder<Singleton>) {
            binder.include(module: FavoriteInteractor.Module.self)
            binder.include(module: FavoriteRouter.Module.self)
            binder.bind(FavoritePresenter.self).to(factory: FavoritePresenter.init)
        }
    }
}
