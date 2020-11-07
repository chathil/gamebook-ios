//
//  HomePresenter.swift
//  gamebook
//
//  Created by Abdul Chathil on 11/3/20.
//  Copyright © 2020 Abdul Chathil. All rights reserved.
//

import SwiftUI
import Combine
import Cleanse

class HomePresenter: ObservableObject {
    private var cancellables: Set<AnyCancellable> = []
    private let homeRouter: HomeRouter?
    private let homeUseCase: HomeUseCase
    
    @Published var games: [GameModel] = []
    @Published var likedIds: [GameModel] = []
    @Published var errorMessage: String = ""
    @Published var loadingState: Bool = false
    
    init(homeUseCase: HomeUseCase, homeRouter: HomeRouter?) {
        self.homeUseCase = homeUseCase
        self.homeRouter = homeRouter
    }
    
    func getGames() {
        loadingState = true
        homeUseCase.getGames().receive(on: RunLoop.main)
            .sink(receiveCompletion: { [self] completion in
                switch completion {
                case .failure: self.errorMessage = String(describing: completion)
                case .finished: self.loadingState = false
                }
            }, receiveValue: { games in
                self.games = games
            }).store(in: &cancellables)
    }
    
    func likeDislike(game: GameModel) {
        homeUseCase.likeDislike(game: game).receive(on: RunLoop.main)
            .sink(receiveCompletion: { _ in },
                  receiveValue: {
                    self.likedIds = $0
                  }).store(in: &cancellables)
    }
    
    func initialLiked() {
        homeUseCase.likedIds().receive(on: RunLoop.main)
            .sink(receiveCompletion: {_ in},
                  receiveValue: {
                    self.likedIds = $0
                  }).store(in: &cancellables)
    }
    
    func linkBuilder<Content: View>(
        for game: GameModel,
        @ViewBuilder content: () -> Content
    ) -> some View {
        NavigationLink(
            destination: homeRouter?.makeDetailView(for: game)) { content() }
    }
}
    
extension HomePresenter {
    struct Module: Cleanse.Module {
        static func configure(binder: Binder<Singleton>) {
            binder.include(module: HomeInteractor.Module.self)
            binder.include(module: HomeRouter.Module.self)
            binder.bind(HomePresenter.self).to(factory: HomePresenter.init)
        }
    }
}
