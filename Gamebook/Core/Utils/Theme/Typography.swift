//
//  Typography.swift
//  Gamebook
//
//  Created by Abdul Chathil on 1/6/21.
//  Copyright © 2021 Abdul Chathil. All rights reserved.
//

import SwiftUI

extension Font {
    struct Gamebook {
        public static let subtitle1 = system(size: 16, weight: .regular)
        public static let subtitle2 = system(size: 14, weight: .medium)
        public static let caption = system(size: 12, weight: .regular)
        public static let body1 = system(size: 14, weight: .regular)
        public static let button = system(size: 14, weight: .medium).uppercaseSmallCaps()
    }
}

struct Typpgraphy_Previews: PreviewProvider {
    static var previews: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Subtitle 2").font(Font.Gamebook.subtitle2)
            Text("BUTTON").font(Font.Gamebook.button)
            Text("Caption").font(Font.Gamebook.caption)
        }
    }
}
