//
//  AccountSnippet.swift
//  fundamental-sub-one
//
//  Created by Abdul Chathil on 7/2/20.
//  Copyright © 2020 Abdul Chathil. All rights reserved.
//

import SwiftUI
import User

struct AccountSnippet: View {
    @EnvironmentObject private var user: User
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Text(user.lastName).font(.largeTitle).fontWeight(.bold)
                    Text("Some text that supposed\nto describes something")
                        .font(.caption)
                        .fontWeight(.medium)
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)
                        .foregroundColor(.gray)
                    HStack {
                        Text("Account").font(.body).foregroundColor(.black)
                        Image(systemName: "chevron.right.2").foregroundColor(Color(.black))
                    }.padding(EdgeInsets(
                                top: Dimens.smallPadding,
                                leading: Dimens.padding,
                                bottom: Dimens.smallPadding,
                                trailing: Dimens.padding))
                    .background(Color("primary"))
                    .clipShape(Capsule())
                }
                Spacer()
                user.photo.resizable().scaledToFill().clipShape(Circle()).frame(width: 120, height: 120).clipShape(Circle())
            }
            Text(user.profileCompletion < 1 ? "Complete Your Profile" : "Profile Completed").font(.headline)
            ProgressBar(progress: user.profileCompletion).frame(width: 216)
            Spacer()
        }
    }
}

struct AccountSnippet_Previews: PreviewProvider {
    static var previews: some View {
        AccountSnippet()
    }
}
