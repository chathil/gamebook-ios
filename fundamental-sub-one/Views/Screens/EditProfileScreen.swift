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
    @State var user: User
    @State var fName: String = ""
    @State var lName: String = ""
    @State var email: String = ""
    
    var body: some View {
        VStack {
            HStack {
                Text("Edit\nProfile").font(.largeTitle).fontWeight(.bold).lineLimit(2)
                Spacer()
                Image("profile").resizable().scaledToFill().frame(width: 186, height: 186)
            }.padding()
            TextField("First Name...", text: $fName).font(.body).padding(24).clipShape(Rectangle()).frame(height: 56).background(Color("primary-black")).cornerRadius(16).padding([.leading, .trailing])
            TextField("Last Name...", text: $lName).font(.body).padding(24).clipShape(Rectangle()).frame(height: 56).background(Color("primary-black")).cornerRadius(16).padding([.leading, .trailing])
            TextField("Email...", text: $email).font(.body).padding(24).clipShape(Rectangle()).frame(height: 56).background(Color("primary-black")).cornerRadius(16).padding([.leading, .trailing])
            
            Spacer()
            
            GeometryReader { geo in
                Text("Save").font(.body).fontWeight(.medium).foregroundColor(.black).padding(24).frame(width:geo.size.width).onTapGesture {
                    self.user.firstName = self.fName
                    self.user.lastName = self.lName
                    self.user.email = self.email
                    self.showingForm = false
                }
            }.background(Color("primary")).cornerRadius(16).frame(height: 56).padding([.leading, .trailing])
            
            GeometryReader { geo in
                Text("Cancle").font(.body).fontWeight(.medium).foregroundColor(.black).padding(24).frame(width:geo.size.width).onTapGesture {
                    self.showingForm = false
                }
            }.background(Color("primary")).cornerRadius(16).frame(height: 56).padding([.leading, .trailing])
            
        }.onAppear {
            self.fName = self.user.firstName
            self.lName = self.user.lastName
            self.email = self.user.email
        }
    }
}

struct EditProfileScreen_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileScreen(showingForm: .constant(false), user: User.fakeUser)
    }
}
