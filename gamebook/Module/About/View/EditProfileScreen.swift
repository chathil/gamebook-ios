//
//  EditProfileScreen.swift
//  fundamental-sub-one
//
//  Created by Abdul Chathil on 7/13/20.
//  Copyright © 2020 Abdul Chathil. All rights reserved.
//

import SwiftUI

struct EditProfileScreen: View {
    @Binding var showingForm: Bool
    @EnvironmentObject var user: User
    @ObservedObject var presenter: AboutPresenter
    
    var body: some View {
        VStack {
            HStack {
                Text("Edit\nProfile").font(.largeTitle).fontWeight(.bold).lineLimit(2)
                Spacer()
                Image("profile").resizable().scaledToFill().frame(width: 186, height: 186)
            }.padding()
            Section(footer: Text(presenter.fNameMessage).foregroundColor(.red)) {
                TextField("First Name...", text: $presenter.fName)
                    .font(.body)
                    .padding(24)
                    .clipShape(Rectangle())
                    .frame(height: 56)
                    .background(Color("primary-black"))
                    .cornerRadius(Dimens.cornerRadius)
                    .padding([.leading, .trailing])
            }
            Section(footer: Text(presenter.lNameMessage).foregroundColor(.red)) {
                TextField("Last Name...", text: $presenter.lName)
                    .font(.body)
                    .padding(24)
                    .clipShape(Rectangle())
                    .frame(height: 56)
                    .background(Color("primary-black"))
                    .cornerRadius(Dimens.cornerRadius)
                    .padding([.leading, .trailing])
            }
            Section(footer: Text(presenter.emailMessage).foregroundColor(.red)) {
                TextField("Email...", text: $presenter.email)
                    .font(.body)
                    .padding(24)
                    .clipShape(Rectangle())
                    .frame(height: 56)
                    .background(Color("primary-black"))
                    .cornerRadius(Dimens.cornerRadius)
                    .padding([.leading, .trailing])
            }
            Spacer()
            GeometryReader { geo in
                Text("Save")
                    .font(.body)
                    .fontWeight(.medium)
                    .foregroundColor(.black)
                    .padding(24)
                    .frame(width: geo.size.width)
                    .onTapGesture {
                        if self.presenter.isFormValid {
                            self.user.firstName = self.presenter.fName
                            self.user.lastName = self.presenter.lName
                            self.user.email = self.presenter.email
                            self.showingForm = false
                        }
                    }
            }.background(Color(presenter.isFormValid ? "primary" : "primary-black")).cornerRadius(16).frame(height: 56).padding([.leading, .trailing])
            
            GeometryReader { geo in
                Text("Cancel")
                    .font(.body)
                    .fontWeight(.medium)
                    .foregroundColor(.black)
                    .padding(24)
                    .frame(width: geo.size.width)
                    .onTapGesture {
                        self.showingForm = false
                    }
            }.background(Color("primary")).cornerRadius(Dimens.cornerRadius).frame(height: 56).padding([.leading, .trailing])
            
        }.onAppear {
            self.presenter.fName = self.user.firstName
            self.presenter.lName = self.user.lastName
            self.presenter.email = self.user.email
        }
    }
}

struct EditProfileScreen_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileScreen(showingForm: .constant(false), presenter: AboutPresenter())
    }
}
