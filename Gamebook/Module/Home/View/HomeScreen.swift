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
import Introspect
import SwiftUIPager

struct HomeScreen: View {
    var homeRouter: HomeRouter
    
    var gamesPresenter: GamesPresenter
    var favoriteGamesPresenter: FavoriteGamesPresenter
    var updateFavoriteGamesPresenter: UpdateFavoriteGamesPresenter
    var search: Search
    @State var page2: Int = 0
    var data = Array(0..<10)
    @State private var navBarHidden: Bool = true
    var body: some View {
        VStack {
            HStack {
                SearchBar(query: .constant("")).padding(.trailing, Dimens.smallPadding)
                Circle()
                    .fill(Color("primary"))
                    .frame(width: 32, height: 32).padding(.horizontal, Dimens.smallPadding)
                Circle()
                    .fill(Color("primary"))
                    .frame(width: 32, height: 32).padding(.trailing, Dimens.padding)
            }.padding(.top, 24)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 24) {
                    Text("Explore").foregroundColor(self.page2 == 0 ? .yellow : .white)
                    Text("Stores").foregroundColor(self.page2 == 1 ? .yellow : .white)
                    Text("Platforms").foregroundColor(self.page2 == 2 ? .yellow : .white)
                    Text("Genres").foregroundColor(self.page2 == 3 ? .yellow : .white)
                    Text("Publisher").foregroundColor(self.page2 == 4 ? .yellow : .white)
                }
            }.padding()
            Divider()
            Pager(page: self.$page2,
                  data: self.data,
                  id: \.self) { page in
                if page == 0 {
                    ExploreView()
                } else if page == 1 {
                    StoresView()
                } else if page == 2 {
                    PlatformsView()
                } else {
                    ExploreView()
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
        }.onAppear {
            gamesPresenter.getList(request: nil)
            favoriteGamesPresenter.getList(request: nil)
        }.navigationBarTitle("")
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

extension View {
    
    func hideListRowSeparator() -> some View {
        return customListRowSeparator(insets: .init(), insetsColor: .clear)
    }
    
    func customListRowSeparator(
        insets: EdgeInsets,
        insetsColor: Color) -> some View {
        modifier(HideRowSeparatorModifier(insets: insets,
                                          background: insetsColor
        )) .onAppear {
            UITableView.appearance().separatorStyle = .none
            UITableView.appearance().separatorColor = .clear
        }
    }
}

// MARK: ViewModifier

private struct HideRowSeparatorModifier: ViewModifier {
    
    var insets: EdgeInsets
    var background: Color
    
    func body(content: Content) -> some View {
        content
            .padding(insets)
            .frame(
                minWidth: 0,
                maxWidth: .infinity,
                maxHeight: .infinity,
                alignment: .leading
            )
            .listRowInsets(EdgeInsets())
            .background(background)
    }
}
