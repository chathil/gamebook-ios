//
//  LikeButton.swift
//  fundamental-sub-one
//
//  Created by Abdul Chathil on 7/10/20.
//  Copyright © 2020 Abdul Chathil. All rights reserved.
//

import SwiftUI
import CoreData

struct LikeButton: View {
    @EnvironmentObject private var gameData: GameHomeData
    
    @State var game: Game?
    @State var likedGame: GameEntity?
    
    var context: NSManagedObjectContext
    
    var body: some View {
        Image(systemName: (likedGame != nil || gameData.likedIds.contains(game?.id ?? 0)) ? "heart.fill" : "heart").resizable().scaledToFill().frame(width: 18, height: 18, alignment: .center).foregroundColor(Color("primary")).onTapGesture {
            self.likeDislike()
        }
    }
    // MARK: repeated code
    private func likeDislike() {
        if let game = self.game, !gameData.likedIds.contains(game.id ) {
            let newGame = GameEntity(context: self.context)
            
            newGame.backgroundImage = game.backgroundUrl.absoluteString
            newGame.descriptionRaw = game.descriptionRaw
            newGame.esrbRating = game.esrb
            newGame.gameRating = game.gameRating
            newGame.name = game.name
            newGame.id = game.id
            newGame.metacritic = game.metacritic ?? 0
            newGame.released = game.releaseDate
            newGame.genresString = game.genreNames
            newGame.publishersString = game.publisherNames
            newGame.uuid = UUID()
            
            gameData.likedIds.append(game.id)
            do {
                try self.context.save()
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }else {
            if let likedGame = self.likedGame {
                if let idx = gameData.likedIds.firstIndex(of: likedGame.id) {
                    print(idx)
                    gameData.likedIds.remove(at: idx)
                }
                self.context.delete(likedGame)
                try? self.context.saveContext()
            } else {
                GameEntity.delete(context: self.context, id: self.game?.id ?? self.likedGame!.id) {
                    
                    print(self.game!.id)
                    
                    if let idx = self.gameData.likedIds.firstIndex(of: self.game?.id ?? -1) {
                        print(idx)
                        self.gameData.likedIds.remove(at: idx)
                    }
                }
            }
        }
    }
    
}

struct LikeButton_Previews: PreviewProvider {
    static var previews: some View {
        LikeButton(game: Game.fakeGame, likedGame: nil, context: CoreDataStack(containerName: "LikedGame").viewContext)
    }
}
