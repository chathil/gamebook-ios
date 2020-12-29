//
//  SearchBar.swift
//  fundamental-sub-one
//
//  Created by Abdul Chathil on 7/3/20.
//  Copyright © 2020 Abdul Chathil. All rights reserved.
//

import SwiftUI

struct SearchBar: View {
    @Binding var query: String
    @State private var isEditing = false
    var body: some View {
        return HStack {
            TextField("Assassin's Cree...", text: $query)
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(Dimens.smallCornerRadius).overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, Dimens.smallPadding)
                        if isEditing {
                            Image(systemName: "multiply.circle.fill")
                                .foregroundColor(.gray)
                                .padding(.trailing, Dimens.smallPadding).onTapGesture {
                                    self.query = ""
                                }
                        }
                    }
                )
                .padding(.horizontal, 10)
                .onTapGesture {
                    self.isEditing = true
                }
            
            if isEditing {
                Button(action: {
                    self.isEditing = false
                    self.query = ""
                    UIApplication.shared
                        .sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }, label: {
                    Text("Cancel")
                })
                .padding(.trailing, 10)
                .transition(.move(edge: .trailing))
                .animation(.default)
            }
        }
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(query: .constant("query"))
    }
}
