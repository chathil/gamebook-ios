//
//  AboutScreen.swift
//  fundamental-sub-one
//
//  Created by Abdul Chathil on 7/2/20.
//  Copyright © 2020 Abdul Chathil. All rights reserved.
//

import SwiftUI

struct AboutScreen: View {
    @ObservedObject var presenter: AboutPresenter
    @EnvironmentObject var user: User
    @State var showingForm = false
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ZStack(alignment: .topLeading) {
                    Circle().frame(width: 90, height: 90).padding(.top, 90).foregroundColor(Color("primary"))
                    Image(user.photo)
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                        .frame(height: 316, alignment: .center)
                        .padding(EdgeInsets(top: -56, leading: 62, bottom: 62, trailing: -120))
                    Circle().frame(width: 198, height: 156)
                        .padding(EdgeInsets(top: 220, leading: 36, bottom: 0, trailing: 0))
                        .foregroundColor(Color("primary"))
                }
                
                HStack {
                    VStack(alignment: .leading) {
                        Text(user.fullName).font(.largeTitle).fontWeight(.bold)
                        Text(user.email).font(.body).fontWeight(.bold)
                    }.padding()
                    Spacer()
                    Fab(systemImage: "pencil").onTapGesture {
                        self.showingForm = true
                    }.sheet(isPresented: $showingForm) {
                        EditProfileScreen(showingForm: self.$showingForm, presenter: self.presenter)
                    }
                }
                
                VStack(alignment: .leading) {
                    Text("About").font(.largeTitle).fontWeight(.bold)
                    Text("Dicoding iOS Expert Capstone 1 with rawg.io API").font(.body).fontWeight(.bold)
                }.padding()
                
                VStack(alignment: .leading) {
                    Text("Credits").font(.largeTitle).fontWeight(.bold)
                    Text("rawg.io\nfor the awesome api").lineLimit(2).padding(.bottom).fixedSize()
                    Text("Freepik\nfor the illustrations @stories").lineLimit(2).padding(.bottom).fixedSize()
                }.padding(.leading, Dimens.padding)
                Spacer()
                    .navigationBarTitle(Text("Account & About")).navigationBarHidden(false)
            }.edgesIgnoringSafeArea(.top)
        }
    }
}

struct AboutScreen_Previews: PreviewProvider {
    static var previews: some View {
        AboutScreen(presenter: AboutPresenter())
    }
}
