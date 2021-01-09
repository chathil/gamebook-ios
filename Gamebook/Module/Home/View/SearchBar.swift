//
//  SearchBar.swift
//  fundamental-sub-one
//
//  Created by Abdul Chathil on 7/3/20.
//  Copyright © 2020 Abdul Chathil. All rights reserved.
//

import SwiftUI
import Core

struct SearchBar: View {
    @Binding var query: String
    @State private var isEditing = false
    var body: some View {
        return HStack {
            TextField("Assassin's Cree...", text: $query)
                .padding(.vertical, 26)
                .padding(.leading, 32)
                .background(Color.Gamebook.surfaceDark)
                .cornerRadius(Dimens.smallPadding, corners: [.topRight, .bottomRight])
                .onTapGesture {
                    self.isEditing = true
                }
        }
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(query: .constant("query"))
    }
}
