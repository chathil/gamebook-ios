//
//  FavoriteScreen.swift
//  fundamental-sub-one
//
//  Created by Abdul Chathil on 7/10/20.
//  Copyright © 2020 Abdul Chathil. All rights reserved.
//

import SwiftUI
import CoreData

struct FavoriteScreen: View {
    @ObservedObject var presenter: FavoritePresenter
    var body: some View {
        
            List {
                ForEach(self.presenter.games, id: \.id) { game in
                    self.presenter.linkBuilder(for: game) {
                        GameRow(game: game, isLiked: true) {
                            presenter.likeDislikeGame(game: game)
                        }
                    }
                }
            }.onAppear {
                self.presenter.initialLiked()
            }
        .phoneOnlyStackNavigationView().navigationBarTitle(Text("Favorites"))
    }
}
