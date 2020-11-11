//
//  AccountSnippet.swift
//  fundamental-sub-one
//
//  Created by Abdul Chathil on 7/2/20.
//  Copyright © 2020 Abdul Chathil. All rights reserved.
//

import SwiftUI

struct AccountSnippet: View {
    @State var user: User
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Text(user.lastName ?? "24B").font(.largeTitle).fontWeight(.bold)
                    Text("Some text that supposed\nto describes something")
                        .font(.caption)
                        .fontWeight(.medium)
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)
                        .foregroundColor(.gray)
                    HStack {
                        Text("Account").font(.body).foregroundColor(.black)
                        Image(systemName: "chevron.right.2").foregroundColor(Color(.black))
                    }.padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                    .background(Color("primary"))
                    .clipShape(Capsule())
                }
                Spacer()
                Image(user.photo).resizable().frame(width: 120, height: 120).clipShape(Circle())
            }
            Text("Complete Your Profile").font(.headline)
            ProgressBar().frame(width: 216)
            Spacer()
        }
    }
}

struct AccountSnippet_Previews: PreviewProvider {
    static var previews: some View {
        AccountSnippet(user: User.fakeUser)
    }
}
