//
//  Fab.swift
//  fundamental-sub-one
//
//  Created by Abdul Chathil on 7/14/20.
//  Copyright © 2020 Abdul Chathil. All rights reserved.
//

import SwiftUI

struct Fab: View {
    let systemImage: String
    var body: some View {
        Image(systemName: systemImage)
            .foregroundColor(.black)
            .padding(24)
            .background(Color("primary"))
            .cornerRadius(Dimens.cornerRadius)
            .padding()
            .shadow(color: Color("accent").opacity(0.6), radius: 16, x: 0, y: 0)
    }
}

struct Fab_Previews: PreviewProvider {
    static var previews: some View {
        Fab(systemImage: "pencil")
    }
}
