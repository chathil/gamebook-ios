//
//  LikeButton.swift
//  fundamental-sub-one
//
//  Created by Abdul Chathil on 7/10/20.
//  Copyright © 2020 Abdul Chathil. All rights reserved.
//

import SwiftUI
import CoreData

struct LikeButton: View {
    let iconSystemName: String
    var body: some View {
        Image(systemName: iconSystemName)
            .resizable()
            .scaledToFill()
            .frame(width: 18, height: 18, alignment: .center)
            .foregroundColor(Color("primary"))
    }
}

struct LikeButton_Previews: PreviewProvider {
    static var previews: some View {
        LikeButton(iconSystemName: "heart.fill")
    }
}
