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
         HStack {
            GeometryReader { geo in
                Image("like").resizable().scaledToFill().frame(width: geo.size.width)
            }
            Text("Your Favorite Game").font(.largeTitle).fontWeight(.bold)
        }.padding([.bottom, .top, .trailing]).background(Color("primary-black")).cornerRadius(16)
    }
}

//struct FavoriteRow_Previews: PreviewProvider {
//    static var previews: some View {
//        FavoriteRow()
//    }
//}
