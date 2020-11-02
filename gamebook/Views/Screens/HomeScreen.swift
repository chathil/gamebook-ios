//
//  HomeScreen.swift
//  fundamental-sub-one
//
//  Created by Abdul Chathil on 7/2/20.
//  Copyright © 2020 Abdul Chathil. All rights reserved.
//

import SwiftUI
import CoreData

struct HomeScreen: View {
    
    @EnvironmentObject private var gameData: GameHomeData
    @State private var navBarHidden: Bool = true
    @State private var action: Int? = 0
    @State private var showingActionSheet = false
    
    var body: some View {
        return NavigationView {
            List {
                AccountSnippet(user: User.fakeUser).padding(EdgeInsets(top: 32, leading: 0, bottom: 0, trailing: 0))
                FavoriteRow()
                FindRow()
                ForEach(gameData.games) {(game) in
                    NavigationLink(destination: DetailScreen(gameData: GameItemData(gameService: GameStore.shared,
                                                                                    gameId: game.id,
                                                                                    game: game),
                                                             likedGame: nil)) {
                        GameRow(game: game, likedGame: nil).environmentObject(self.gameData)
                    }
                }
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
        }.phoneOnlyStackNavigationView()
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen().environmentObject(
            GameHomeData(gameService: GameStore.shared,
                         context: CoreDataStack(containerName: "LikedGame").viewContext))
            .environment(\.colorScheme, .dark)
    }
}
