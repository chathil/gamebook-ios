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
        HStack(alignment: .center) {
//            GeometryReader { geo in
                Image("like").resizable().scaledToFill().frame(height: 186)
            
            Text("Your Favorite Game").font(.largeTitle).fontWeight(.bold)
        }.background(Color("primary-black")).cornerRadius(16)
    }
}

//struct FavoriteRow_Previews: PreviewProvider {
//    static var previews: some View {
//        FavoriteRow()
//    }
//}
