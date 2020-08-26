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
    
    @Environment(\.managedObjectContext)
    var context: NSManagedObjectContext
    @State var showingForm = false
    
    @FetchRequest(
        entity: GameEntity.entity(),
        sortDescriptors: []
    )
    
    private var result: FetchedResults<GameEntity>
    
    init() {
        let fetchRequest = NSFetchRequest<GameEntity>(entityName: GameEntity.entity().name ?? "Game")
        fetchRequest.sortDescriptors = []
        _result = FetchRequest(fetchRequest: fetchRequest)
    }
    
    var body: some View {
        ZStack(alignment: .bottomTrailing){
            List {
                ForEach(result, id: \.uuid) { (game: GameEntity) in
                    NavigationLink(destination: DetailScreen(gameData:
                        GameItemData(gameService: GameStore.shared, gameId: game.id, game: nil), likedGame: game)) {
                            GameRow(game: nil, likedGame: game)
                    }
                }
            }
            Fab(systemImage: "plus").onTapGesture {
                self.showingForm.toggle()
            }.sheet(isPresented: $showingForm) {
                AddGameScreen(context: self.context, showingForm: self.$showingForm)
            }
            
        }.phoneOnlyStackNavigationView().navigationBarTitle(Text("Favorites"))
    }
}

struct FavoriteScreen_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteScreen().environment(\.managedObjectContext, CoreDataStack(containerName: "LikedGame").viewContext)
    }
}
