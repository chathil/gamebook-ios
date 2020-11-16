//
//  FavoriteRow.swift
//  fundamental-sub-one
//
//  Created by Abdul Chathil on 7/10/20.
//  Copyright © 2020 Abdul Chathil. All rights reserved.
//

import SwiftUI
import CoreData

struct FavoriteRow: View {
    var body: some View {
        GeometryReader { geo in
            HStack(alignment: .center) {
                Image("like").resizable().scaledToFill().frame(width: 186)
                Text("Your Favorite Game").font(.largeTitle).fontWeight(.bold)
            }.frame(width: geo.size.width)
        }.background(Color("primary-black")).cornerRadius(Dimens.cornerRadius).frame(height: 186)
    }
}

struct FavoriteRow_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteRow()
    }
}
