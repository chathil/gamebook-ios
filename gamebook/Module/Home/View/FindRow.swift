//
//  FindRow.swift
//  fundamental-sub-one
//
//  Created by Abdul Chathil on 7/2/20.
//  Copyright © 2020 Abdul Chathil. All rights reserved.
//

import SwiftUI
import Common

struct FindRow: View {
    @Binding var query: String
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text(LocalizedStrings.find).font(.largeTitle).fontWeight(.bold)
                    Text(LocalizedStrings.findDescription)
                        .font(.caption)
                        .fontWeight(.medium)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)
                        .foregroundColor(.gray)
                }
                Image("game").resizable().scaledToFill().frame(width: 186, height: 186)
                Spacer()
            }
            SearchBar(query: $query)
        }.padding([.bottom, .leading]).background(Color("primary-black")).cornerRadius(Dimens.cornerRadius)
    }
}

struct FindRow_Previews: PreviewProvider {
    static var previews: some View {
        FindRow(query: .constant("Search here"))
    }
}
