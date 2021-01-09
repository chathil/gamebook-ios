//
//  Style.swift
//  Gamebook
//
//  Created by Abdul Chathil on 1/6/21.
//  Copyright © 2021 Abdul Chathil. All rights reserved.
//

import SwiftUI

struct ButtonFilledExpandedStyle: ButtonStyle {
    var bgColor: Color = Color(.surfaceDark)

    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .font(Font.Gamebook.button)
            .foregroundColor(Color.Gamebook.primary)
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding(14)
            .cornerRadius(Dimens.smallCornerRadius)
            .overlay(RoundedRectangle(cornerRadius: Dimens.smallCornerRadius).foregroundColor(bgColor))
    }
}

struct ButtonTextStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .font(Font.Gamebook.button)
            .foregroundColor(Color.Gamebook.primary)
            .padding(14)
    }
}

struct Button_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Button(action: {}, label: {
                Text("True")
            }).buttonStyle(ButtonFilledExpandedStyle())
            Button(action: {}, label: {
                Text("True")
            }).buttonStyle(ButtonTextStyle())
        
        }
    }
}
