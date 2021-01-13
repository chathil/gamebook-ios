//
//  FavoriteScreen.swift
//  fundamental-sub-one
//
//  Created by Abdul Chathil on 7/10/20.
//  Copyright © 2020 Abdul Chathil. All rights reserved.
//

import SwiftUI
import Core
import CoreData
import Games
import Common

struct FavoriteScreen: View {
    var favoriteRouter: FavoriteRouter
    @ObservedObject var favoriteGamesPresenter: FavoriteGamesPresenter
    @ObservedObject var updateFavoriteGamesPresenter: UpdateFavoriteGamesPresenter
    var body: some View {
            List {
                ForEach(favoriteGamesPresenter.list, id: \.id) { game in
                    self.detailLinkBuilder(for: game) {
                        GameRow(game: game, isLiked: true) {
                            updateFavoriteGamesPresenter.getList(request: game)
                            favoriteGamesPresenter.getList(request: nil)
                        }
                    }
                }
            }.onAppear {
                self.favoriteGamesPresenter.getList(request: nil)
            }
            .phoneOnlyStackNavigationView().navigationBarTitle(Text(LocalizedStrings.favorites))
    }
}

extension FavoriteScreen {
    func detailLinkBuilder<Content: View>(
            for game: GamesModel,
            @ViewBuilder content: () -> Content
        ) -> some View {
            ZStack {
                NavigationLink(destination: favoriteRouter.makeDetailView(for: game)) {  }
                content()
            }
        }
}
