//
//  HomeScreen.swift
//  fundamental-sub-one
//
//  Created by Abdul Chathil on 7/2/20.
//  Copyright © 2020 Abdul Chathil. All rights reserved.
//

import SwiftUI
import Core
import Cleanse
import Game
import Combine
import User
import Common

struct HomeScreen: View {
    var homeRouter: HomeRouter
    
    @ObservedObject var gamesPresenter: GamesPresenter
    @ObservedObject var favoriteGamesPresenter: FavoriteGamesPresenter
    @ObservedObject var updateFavoriteGamesPresenter: UpdateFavoriteGamesPresenter
    @ObservedObject var search: Search
    
    @EnvironmentObject private var user: User
    
    @State private var navBarHidden: Bool = true
    
    var body: some View {
        ZStack(alignment: .bottom) {
            List {
                self.aboutLinkBuilder {
                    AccountSnippet().padding(EdgeInsets(top: 32, leading: 0, bottom: 0, trailing: 0))
                }
                self.favoriteLinkBuilder {
                    FavoriteRow()
                }
                FindRow(query: $search.query)
                if self.gamesPresenter.isLoading {
                    ForEach(0...5, id: \.self) { _ in
                        GameRowLoading()
                    }
                } else {
                    ForEach(self.gamesPresenter.list, id: \.id) { game in
                        self.detailLinkBuilder(for: game) {
                            GameRow(game: game, isLiked: favoriteGamesPresenter.list.contains(game)) {
                                updateFavoriteGamesPresenter.getList(request: game)
                                favoriteGamesPresenter.getList(request: nil)
                            }
                        }
                    }
                }
            }
            if !gamesPresenter.errorMessage.isEmpty {
                GeometryReader { geo in
                    Text("Oh snap. Retry?").foregroundColor(Color("primary")).padding([.bottom, .top]).frame(width: geo.size.width).onTapGesture {
                        gamesPresenter.getList(request: nil)
                        favoriteGamesPresenter.getList(request: nil)
                        gamesPresenter.errorMessage = ""
                        favoriteGamesPresenter.errorMessage = ""
                    }
                }.background(Color("primary-black")).cornerRadius(Dimens.smallCornerRadius).frame(height: 56).padding([.leading, .trailing])
            }
        }
        .onAppear {
            gamesPresenter.getList(request: nil)
            favoriteGamesPresenter.getList(request: nil)
        }
        .environment(\.defaultMinListRowHeight, 132).listSeparatorStyleNone()
        .navigationBarTitle("")
        .navigationBarHidden(self.navBarHidden)
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
            self.navBarHidden = true
        }.gesture(DragGesture().onChanged {_ in
            UIApplication.shared
                .sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        })
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
            self.navBarHidden = false
        }
    }
}

extension HomeScreen {
    
    func detailLinkBuilder<Content: View>(
        for game: GameModel,
        @ViewBuilder content: () -> Content
    ) -> some View {
        ZStack {
            NavigationLink(destination: homeRouter.makeDetailView(for: game)) {  }
            content()
        }
    }
    func favoriteLinkBuilder<Content: View>(
        @ViewBuilder content: () -> Content
    ) -> some View {
        ZStack {
            NavigationLink(destination: homeRouter.makeFavoriteView()) {
            }
            content()
        }
    }
    
    func aboutLinkBuilder<Content: View> (
        @ViewBuilder content: () -> Content
    ) -> some View {
        ZStack {
            NavigationLink(destination: homeRouter.makeAboutView()) {}
            content()
        }
    }
}

class Search: ObservableObject {
    @Published var query: String = ""
    private var cancellables: Set<AnyCancellable> = []
    
    init(gamesPresenter: GamesPresenter) {
        $query
            .debounce(for: .milliseconds(400), scheduler: RunLoop.main)
            .removeDuplicates()
            .compactMap { $0 }
            .sink { _ in
            } receiveValue: { (searchField) in
                if !searchField.isEmpty {
                    gamesPresenter.getList(request: searchField)
                }
            }.store(in: &cancellables)
    }
}
