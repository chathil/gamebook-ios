//
//  GameItemMedium.swift
//  Gamebook
//
//  Created by Abdul Chathil on 1/6/21.
//  Copyright © 2021 Abdul Chathil. All rights reserved.
//

import SwiftUI

struct GameItemMedium: View {
    var body: some View {
        VStack(alignment: .leading) {
            Rectangle().frame(width: 146, height: 146).foregroundColor(Color.Gamebook.surfaceDark)
            Text("The duhh").font(Font.Gamebook.subtitle2).padding(8).foregroundColor(Color.Gamebook.onSurfaceDark)
            HStack {
                Spacer()
                Image(fluent: .games24Filled).foregroundColor(.primary).foregroundColor(Color.Gamebook.onSurfaceDark)
                Image(fluent: .heart24Filled).foregroundColor(.red)
            }.padding(8)
        }.frame(width: 146).background(Color(.surfaceDark)).cornerRadius(Dimens.smallCornerRadius)
    }
}

struct GameItemMedium_Previews: PreviewProvider {
    static var previews: some View {
        GameItemMedium()
    }
}
