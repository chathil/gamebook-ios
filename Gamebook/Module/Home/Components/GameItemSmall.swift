//
//  GameItem.swift
//  Gamebook
//
//  Created by Abdul Chathil on 1/3/21.
//  Copyright © 2021 Abdul Chathil. All rights reserved.
//

import SwiftUI
import FluentIcons

struct GameItem: View {
    var body: some View {
        HStack {
            Rectangle().frame(width: 48, height: 48).cornerRadius(Dimens.smallCornerRadius).foregroundColor(Color.Gamebook.surfaceDark)
            VStack(alignment: .leading, spacing: 2) {
                Text("Endless Zone").font(Font.Gamebook.subtitle2).foregroundColor(Color.Gamebook.onBackgroundDark)
                HStack(alignment: .bottom) {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Action").font(Font.Gamebook.caption).foregroundColor(Color.Gamebook.onBackgroundDark)
                        HStack {
                            Text("4.6").font(Font.Gamebook.caption).foregroundColor(Color.Gamebook.onBackgroundDark)
                            Image(fluent: .star16Filled).foregroundColor(Color.Gamebook.onBackgroundDark)
                        }.padding(.bottom, 0)
                    }
                    Spacer()
                    Image(fluent: .games24Filled).foregroundColor(Color.Gamebook.onBackgroundDark)
                    Image(fluent: .heart24Filled).foregroundColor(.red)
                }
            }
        }
    }
}

struct GameItem_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            GameItem()
            GameItem()
        }
    }
}
