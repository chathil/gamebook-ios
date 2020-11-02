//
//  GameRow.swift
//  fundamental-sub-one
//
//  Created by Abdul Chathil on 7/2/20.
//  Copyright © 2020 Abdul Chathil. All rights reserved.
//

import SwiftUI
import CoreData

struct GameRow: View {
    @Environment(\.imageCache) var cache: ImageCache
    @Environment(\.managedObjectContext)
    var context: NSManagedObjectContext
    
    @State var game: Game?
    let likedGame: GameEntity?
    
    var body: some View {
        HStack {
            AsyncImage(
                url: game?.backgroundUrl ?? likedGame?.backgroundUrl,
                cache: cache,
                placeholder: ImagePlaceholder())
                .scaledToFill()
                .frame(width: 112, height: 112, alignment: .center)
                .clipped()
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 12))
            
            VStack(alignment: .leading) {
                Text(game?.name ?? likedGame!.name ?? "No Name")
                    .font(.headline)
                    .fontWeight(.bold).lineLimit(2)
                HStack {
                    Chip(text: game?.releaseDate ?? likedGame?.released ?? "No Date")
                    Chip(text: game?.genre ?? likedGame?.genre ?? "No Genre")
                }.padding(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
                HStack {
                    LikeButton(game: self.game, likedGame: self.likedGame, context: self.context).padding(.trailing)
                    Image("meta").resizable().frame(width: 20, height: 20, alignment: .center)
                    Text(String(game?.metacritic ?? likedGame?.metacritic ?? 0)).font(.caption).bold()
                    Image(systemName: "star.fill")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 18, height: 18, alignment: .center)
                        .foregroundColor(Color("primary"))
                    Text(String(game?.gameRating ?? likedGame?.gameRating ?? "No Rating")).font(.caption).bold()
                }
            }
            Spacer()
        }.clipShape(RoundedRectangle(cornerRadius: 16.0))
        .padding(EdgeInsets(top: 8, leading: 0, bottom: 0, trailing: 0))
    }
}

struct ImagePlaceholder: View {
    var body : some View {
        Image("imgplaceholder").resizable().scaledToFit(
        ).background(Color(.darkGray))
        .frame(width: 112, height: 112, alignment: .center)
        .clipped()
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 12))
    }
}

struct GameRow_Previews: PreviewProvider {
    static var previews: some View {
        GameRow(game: Game.fakeGame, likedGame: nil)
    }
}
