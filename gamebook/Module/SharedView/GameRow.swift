//
//  GameRow.swift
//  fundamental-sub-one
//
//  Created by Abdul Chathil on 7/2/20.
//  Copyright © 2020 Abdul Chathil. All rights reserved.
//

import SwiftUI
import CoreData
import SDWebImageSwiftUI

struct GameRow: View {
    let game: GameModel
    let isLiked: Bool
    let like: () -> Void
    
    var body: some View {
        HStack {
            WebImage(url: URL(string: game.backgroundImage))
                .resizable()
                .placeholder {
                        Rectangle().foregroundColor(.gray)
                    }
                    .indicator(.activity) 
                .transition(.fade(duration: 0.5)) // Fade Transition with duration
                .scaledToFill()
                .frame(width: 112, height: 112, alignment: .center)
                .clipped()
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 12))
            
            VStack(alignment: .leading) {
                Text(game.name)
                    .font(.headline)
                    .fontWeight(.bold).lineLimit(2)
                HStack {
                    Chip(text: game.released)
                    Chip(text: game.genres[0])
                }.padding(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
                HStack {
                    LikeButton(iconSystemName: isLiked ? "heart.fill" : "heart").onTapGesture {
                        like()
                    }.padding(.trailing)
                    Image("meta").resizable().frame(width: 20, height: 20, alignment: .center)
                    Text(String(game.metacritic)).font(.caption).bold()
                    Image(systemName: "star.fill")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 18, height: 18, alignment: .center)
                        .foregroundColor(Color("primary"))
                    Text(String(game.gameRating)).font(.caption).bold()
                }
            }
            Spacer()
        }.clipShape(RoundedRectangle(cornerRadius: 16.0))
        .padding(EdgeInsets(top: 8, leading: 0, bottom: 0, trailing: 0))
    }
}

//struct GameRow_Previews: PreviewProvider {
//    static var previews: some View {
//        GameRow(game: Game.fakeGame, likedGame: nil)
//    }
//}
