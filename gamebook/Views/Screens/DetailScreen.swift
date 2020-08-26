//
//  DetailScreen.swift
//  fundamental-sub-one
//
//  Created by Abdul Chathil on 7/2/20.
//  Copyright © 2020 Abdul Chathil. All rights reserved.
//

import SwiftUI

struct DetailScreen: View {
    @ObservedObject var gameData: GameItemData
    @State var likedGame: GameEntity?
    
    var game: Game? {
        return gameData.game
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ZStack(alignment: .bottomLeading) {
                    GamePoster(url: (likedGame?.backgroundUrl ??  gameData.game?.backgroundUrl ?? URL(string: "http://www.google.com"))! ).frame(height: 316).padding(.bottom)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(game?.publisherNames ?? likedGame?.publishersString ?? [], id: \.self) {
                                Chip(text: $0)
                            }
                        }
                    }
                }.padding(.bottom)
                
                Text(game?.name ?? likedGame?.name ?? "No Name").font(.largeTitle).fontWeight(.bold).padding(.leading)
                
                HStack{
                    Image("meta").resizable().frame(width: 26, height: 26, alignment: .center)
                    Text(String(game?.metacritic ?? likedGame?.metacritic ?? 0)).font(.body).bold()
                    Image(systemName: "star.fill").resizable().scaledToFill().frame(width: 24, height: 24, alignment: .center).foregroundColor(Color("primary"))
                    Text(String(game?.gameRating ?? likedGame?.gameRating ?? "0/ 0")).font(.body).bold()
                }.padding(.leading)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        Chip(text: game?.releaseDate ?? likedGame?.released ?? "No Date").lineLimit(1).padding(.leading).frame(minWidth: 126, alignment: .leading)
                        if game?.esrb != nil {
                            Chip(text: game!.esrb!)
                        }
                        ForEach(game?.genreNames ?? likedGame?.genresString ?? [], id: \.self) {
                            Chip(text: $0)
                        }
                    }
                }
                
                Text(game?.descriptionRaw ?? likedGame?.descriptionRaw ?? "No Description").font(.body).padding()
                
            }
        }.onAppear{
        self.gameData.loadGame()
        
        }.edgesIgnoringSafeArea(.all)
        
    }
    
}


struct GamePoster: View {
    @Environment(\.imageCache) var cache: ImageCache
    @State var url: URL
    
    var body: some View {
        GeometryReader {geo in
            AsyncImage(url: self.url, cache: self.cache, placeholder: DetailImagePlaceholder()).scaledToFill().frame(width: geo.size.width, height: 316, alignment: .center)
        }
    }
}

struct DetailImagePlaceholder: View {
    var body : some View {
        Image("game").resizable().scaledToFill().frame(height: 316).clipped()
    }
}

struct DetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        DetailScreen(gameData: GameItemData(gameService: GameStore.shared, gameId: Game.fakeGame.id, game: Game.fakeGame))
    }
}
