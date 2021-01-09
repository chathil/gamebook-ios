//
//  NonSeparatedList.swift
//  Gamebook
//
//  Created by Abdul Chathil on 1/8/21.
//  Copyright © 2021 Abdul Chathil. All rights reserved.
//

import SwiftUI

struct NonSeparatedList<Content: View>: View {
    var content: () -> Content
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
    
    var body: some View {
        if #available(iOS 14.0, *) {
            ScrollView {
                LazyVStack(spacing: 0) {
                    content()
                }
            }
        } else {
            List {
                content()
            }.listSeparatorStyleNone() // set spacing
        }
    }
}

struct NonSeparatedList_Previews: PreviewProvider {
    static var previews: some View {
        NonSeparatedList {
            Text("Hello World!")
        }
    }
}
