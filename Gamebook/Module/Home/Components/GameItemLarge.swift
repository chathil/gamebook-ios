//
//  GameItem+Preview.swift
//  Gamebook
//
//  Created by Abdul Chathil on 1/3/21.
//  Copyright © 2021 Abdul Chathil. All rights reserved.
//

import SwiftUI

struct GameItemLarge: View {
    var body: some View {
        VStack {
            Rectangle().frame(width: 192, height: 108).cornerRadius(Dimens.smallCornerRadius).foregroundColor(Color.Gamebook.surfaceDark)
            GameItem()
        }.frame(width: 192)
    }
}

struct GameItemLarge_Previews: PreviewProvider {
    static var previews: some View {
        GameItemLarge()
    }
}
