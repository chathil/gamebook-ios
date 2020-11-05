//
//  SearchBar.swift
//  fundamental-sub-one
//
//  Created by Abdul Chathil on 7/3/20.
//  Copyright © 2020 Abdul Chathil. All rights reserved.
//

import SwiftUI

struct SearchBar: View {
    @State private var query = ""
    @State private var isEditing = false
    
    private func textFieldChanged(_ text: String) {
//        gameData.searchGames(query: text)
    }
    
    var body: some View {
        let binding = Binding<String>(
            get: { self.query },
            set: { self.query = $0; self.textFieldChanged($0) }
        )
        
        return HStack {
            TextField("Assassin's Cree...", text: binding)
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(8).overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                        if isEditing {
                            Button(action: {
                                self.query = ""
                            }, label: {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            })
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
//                    self.gameData.loadGames()
                    UIApplication.shared
                        .sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }, label: {
                    Text("Cancel")
                })
                .padding(.trailing, 10)
                .transition(.move(edge: .trailing))
                .animation(.default)
            }
        }.onDisappear(perform: {
            self.query = ""
        })
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar()
    }
}
