//
//  Chip.swift
//  fundamental-sub-one
//
//  Created by Abdul Chathil on 7/2/20.
//  Copyright © 2020 Abdul Chathil. All rights reserved.
//

import SwiftUI

struct Chip: View {
    let text: String
    var body: some View {
        Text(text).font(.caption)
            .fontWeight(.regular).foregroundColor(.black).lineLimit(1)
            .padding(EdgeInsets(top: Dimens.smallPadding, leading: Dimens.padding, bottom: Dimens.smallPadding, trailing: Dimens.padding))
            .background(Color("primary"))
            .clipShape(Capsule())
    }
}

struct Chip_Previews: PreviewProvider {
    static var previews: some View {
        Chip(text: "Hello World")
    }
}
