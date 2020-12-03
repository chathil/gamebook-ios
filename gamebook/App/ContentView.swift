//
//  ContentView.swift
//  gamebook
//
//  Created by Abdul Chathil on 11/3/20.
//  Copyright © 2020 Abdul Chathil. All rights reserved.
//

import SwiftUI
import Core
import Game

struct ContentView: View {
    let gamesPresenter: GamesPresenter
    let favoriteGamesPresenter: FavoriteGamesPresenter
    let updateFavoriteGamesPresenter: UpdateFavoriteGamesPresenter
    let homeRouter: HomeRouter
    var body: some View {
        NavigationView {
            HomeScreen(homeRouter: homeRouter, gamesPresenter: gamesPresenter, favoriteGamesPresenter: favoriteGamesPresenter, updateFavoriteGamesPresenter: updateFavoriteGamesPresenter, search: Search(gamesPresenter: gamesPresenter))
        }.phoneOnlyStackNavigationView()
    }
}
