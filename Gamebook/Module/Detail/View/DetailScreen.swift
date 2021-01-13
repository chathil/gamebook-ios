//
//  DetailScreen.swift
//  fundamental-sub-one
//
//  Created by Abdul Chathil on 7/2/20.
//  Copyright © 2020 Abdul Chathil. All rights reserved.
//

import SwiftUI
import Cleanse
import SDWebImageSwiftUI
import Games
import Core

struct DetailScreen: View {
    @ObservedObject var gamePresenter: GamePresenter
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                if let game = gamePresenter.response {
                    ZStack(alignment: .bottomLeading) {
                        GamePoster(url: URL(string: game.backgroundImage)!)
                            .frame(height: 316)
                            .padding(.bottom)
                        ScrollView(.horizontal, showsIndicators: false) {
                            
                            HStack {
                                ForEach(game.publishers, id: \.self) {
                                    Chip(text: $0).padding(.leading, Dimens.padding)
                                }
                            }
                            
                        }
                    }.padding(.bottom)
                    
                    Text(game.name).font(.largeTitle).fontWeight(.bold).padding(.leading)
                    
                    HStack {
                        Image("meta").resizable().frame(width: 26, height: 26, alignment: .center)
                        Text(String(game.metacritic)).font(.body).bold()
                        Image(systemName: "star.fill")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 24, height: 24, alignment: .center)
                            .foregroundColor(Color(.primary))
                        Text(String(game.gameRating)).font(.body).bold()
                    }.padding(.leading)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            Chip(text: game.released)
                                .lineLimit(1)
                                .padding(.leading)
                                .frame(minWidth: 126, alignment: .leading)
                            Chip(text: game.esrbRating)
                            ForEach(game.genres, id: \.self) {
                                Chip(text: $0)
                            }
                        }
                    }
                    Text("No code yet").font(.body).padding()
                    
                } else {
                    DetailLoading()
                }
            }
        }.onAppear {
            self.gamePresenter.get()
        }.edgesIgnoringSafeArea(.all)
    }
}

private struct GamePoster: View {
    @State var url: URL
    var body: some View {
        GeometryReader {geo in
            WebImage(url: url)
                .resizable()
                .placeholder {
                    Rectangle().foregroundColor(.gray)
                }
                .indicator(.activity)
                .transition(.fade(duration: 0.5))
                .scaledToFill()
                .frame(width: geo.size.width, height: 316, alignment: .center)
        }
    }
}

private struct DetailLoading: View {
    var body: some View {
        VStack(alignment: .leading) {
            ShimmerView().frame(height: 346)
            ShimmerView().frame(height: 24).padding()
            ShimmerView().frame(height: 24).padding()
            ShimmerView().frame(height: 24).padding()
            ShimmerView().frame(height: 24).padding()
            ShimmerView().frame(height: 24).padding()
            ShimmerView().frame(width: 156, height: 24).padding()
        }
    }
}
