//
//  TriviaItem.swift
//  Gamebook
//
//  Created by Abdul Chathil on 1/6/21.
//  Copyright © 2021 Abdul Chathil. All rights reserved.
//

import SwiftUI

struct TriviaItem: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Peter Molyneux was the founder of Bullfrog Productions.").font(Font.Gamebook.body1)
            HStack {
                Button(action: {}, label: {
                    Text("TRUE")
                }).buttonStyle(ButtonFilledExpandedStyle())
                Button(action: {}, label: {
                    Text("FALSE")
                }).buttonStyle(ButtonFilledExpandedStyle())
            }
        }
    }
}

struct TriviaItem_Previews: PreviewProvider {
    static var previews: some View {
        TriviaItem()
    }
}
