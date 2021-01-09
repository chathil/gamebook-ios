//
//  Explore.swift
//  Gamebook
//
//  Created by Abdul Chathil on 1/3/21.
//  Copyright © 2021 Abdul Chathil. All rights reserved.
//

import SwiftUI

struct ExploreView: View {
    var body: some View {
        NonSeparatedList {
            Group {
                HStack {
                    Text("Top rated").font(Font.Gamebook.subtitle2).foregroundColor(Color.Gamebook.primary).padding(.leading, 32)
                    Spacer()
                    Button(action: {}, label: {
                        Text("MORE")
                    }).buttonStyle(ButtonTextStyle()).padding(.trailing, 18)
                }
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(Array((1...10).enumerated()), id: \.offset) { index, _ in
                            GameItemLarge().padding(.leading, index == 0 ? 32 : 0)
                        }
                    }
                }
            }
            Spacer(minLength: 24)
            Group {
                HStack {
                    Text("Fun trivia").font(Font.Gamebook.subtitle2).foregroundColor(Color.Gamebook.primary).padding(.leading, 32)
                    Spacer()
                    Button(action: {}, label: {
                        Text("ANOTHER")
                    }).buttonStyle(ButtonTextStyle()).padding(.trailing, 18)
                }
                TriviaItem().padding(.horizontal, 32)
            }
            Spacer(minLength: 16)
            Group {
                HStack {
                    Text("New & updated games").font(Font.Gamebook.subtitle2).foregroundColor(Color.Gamebook.primary).padding(.leading, 32)
                    Spacer()
                    Button(action: {}, label: {
                        Text("MORE")
                    }).buttonStyle(ButtonTextStyle()).padding(.trailing, 18)
                }
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(Array((1...10).enumerated()), id: \.offset) { index, _ in
                            GameItemMedium().padding(.leading, index == 0 ? 32 : 0)
                        }
                    }
                }
            }
            Spacer(minLength: 16)
            Group {
                HStack {
                    Text("Being played now").font(Font.Gamebook.subtitle2).foregroundColor(Color.Gamebook.primary).padding(.leading, 32)
                    Spacer()
                    Button(action: {}, label: {
                        Text("MORE")
                    }).buttonStyle(ButtonTextStyle()).padding(.trailing, 18)
                }
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(Array((1...10).enumerated()), id: \.offset) { index, _ in
                            GameItemMedium().padding(.leading, index == 0 ? 32 : 0)
                        }
                    }
                }
            }
            Spacer(minLength: 16)
            Group {
                HStack {
                    Text("Recently viewed").font(Font.Gamebook.subtitle2).foregroundColor(Color.Gamebook.primary).padding(.leading, 32)
                    Spacer()
                    Button(action: {}, label: {
                        Text("MORE")
                    }).buttonStyle(ButtonTextStyle()).padding(.trailing, 18)
                }
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(Array((1...10).enumerated()), id: \.offset) { index, _ in
                            GameItemMedium().padding(.leading, index == 0 ? 32 : 0)
                        }
                    }
                }
            }
        }
    }
}

struct Explore_Previews: PreviewProvider {
    static var previews: some View {
        ExploreView()
    }
}
