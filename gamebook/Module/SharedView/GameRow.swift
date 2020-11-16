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

private struct GameRowDimens {
    static let imageWidth: CGFloat = 112
    static let imageHeight: CGFloat = 112
    static let imageEdgeInsets: EdgeInsets = EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: Dimens.smallPadding)
    static let gameRowEdgeInsets: EdgeInsets = EdgeInsets(top: Dimens.smallPadding, leading: 0, bottom: Dimens.smallPadding, trailing: 0)
}

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
                .transition(.fade(duration: 0.5))
                .scaledToFill()
                .frame(width: GameRowDimens.imageWidth, height: GameRowDimens.imageHeight, alignment: .center)
                .cornerRadius(Dimens.smallCornerRadius)
                .clipped()
                .padding(GameRowDimens.imageEdgeInsets)
            
            VStack(alignment: .leading) {
                Text(game.name)
                    .font(.headline)
                    .fontWeight(.bold).lineLimit(2)
                HStack {
                    Chip(text: game.released)
                    Chip(text: game.genres.isEmpty ? "No Genre" : game.genres[0])
                }.padding(EdgeInsets(top: Dimens.smallPadding, leading: 0, bottom: Dimens.smallPadding, trailing: 0))
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
        }
        .padding(GameRowDimens.gameRowEdgeInsets)
    }
}

struct GameRowLoading: View {
    var body: some View {
        HStack {
            ShimmerView().frame(width: GameRowDimens.imageWidth, height: GameRowDimens.imageHeight).cornerRadius(Dimens.smallCornerRadius)
            VStack(alignment: .leading) {
                ShimmerView().frame(width: 216, height: 26)
                HStack {
                    ShimmerView().frame(width: 86, height: 26)
                    ShimmerView().frame(width: 46, height: 26)
                }
                
            }
        }.padding(GameRowDimens.gameRowEdgeInsets)
    }
}

struct GameRow_Previews: PreviewProvider {
    static var previews: some View {
        GameRow(game: GameResponse.fakeGame.toDomainModel(), isLiked: false, like: {})
    }
}
