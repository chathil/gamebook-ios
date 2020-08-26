//
//  FindRow.swift
//  fundamental-sub-one
//
//  Created by Abdul Chathil on 7/2/20.
//  Copyright © 2020 Abdul Chathil. All rights reserved.
//

import SwiftUI

struct FindRow: View {
    @State private var searchText : String = ""
    
    var body: some View {
        VStack{
            HStack {
                VStack(alignment: .leading) {
                    Text("Find").font(.largeTitle).fontWeight(.bold)
                    Text("Type the name of the game below to find it").font(.caption).fontWeight(.medium).foregroundColor(.gray).multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)
                        .foregroundColor(.gray)
                }
                Image("game").resizable().scaledToFill().frame(width: 186, height: 186)
                Spacer()
            }
            SearchBar()
        }.padding([.bottom, .leading]).background(Color("primary-black")).cornerRadius(16)
    }
}

struct FindRow_Previews: PreviewProvider {
    static var previews: some View {
        FindRow()
    }
}
