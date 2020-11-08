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
    @State var showingForm = false
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
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
            Fab(systemImage: "plus").onTapGesture {
                self.showingForm.toggle()
            }.sheet(isPresented: $showingForm) {
                AddGameScreen(showingForm: self.$showingForm)
            }
            
        }.phoneOnlyStackNavigationView().navigationBarTitle(Text("Favorites"))
    }
}

//struct FavoriteScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        FavoriteScreen(showingForm: false)
//    }
//}
