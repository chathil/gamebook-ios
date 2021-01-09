//
//  EditProfileScreen.swift
//  fundamental-sub-one
//
//  Created by Abdul Chathil on 7/13/20.
//  Copyright © 2020 Abdul Chathil. All rights reserved.
//

import SwiftUI
import User
import Common

struct EditProfileScreen: View {
    @Binding var showingForm: Bool
    @EnvironmentObject var user: User
    @ObservedObject var presenter: UserPresenter
    
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var selectedImage: UIImage?
    @State private var isImagePickerDisplay = false
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Text(LocalizedStrings.editProfile).font(.largeTitle).fontWeight(.bold).lineLimit(2)
                    Spacer()
                    Image("profile").resizable().scaledToFill().frame(width: 186, height: 186)
                }.padding()
                HStack {
                    VStack {
                        Section(footer: Text(presenter.fNameMessage).foregroundColor(.red)) {
                            TextField("\(LocalizedStrings.firstName)...", text: $presenter.fName)
                                .font(.body)
                                .padding(24)
                                .clipShape(Rectangle())
                                .frame(height: 56)
                                .background(Color(.onSurfaceDark))
                                .cornerRadius(Dimens.cornerRadius)
                                .padding([.leading, .trailing])
                        }
                        Section(footer: Text(presenter.lNameMessage).foregroundColor(.red)) {
                            TextField("\(LocalizedStrings.lastName)...", text: $presenter.lName)
                                .font(.body)
                                .padding(24)
                                .clipShape(Rectangle())
                                .frame(height: 56)
                                .background(Color(.onSurfaceDark))
                                .cornerRadius(Dimens.cornerRadius)
                                .padding([.leading, .trailing])
                        }
                    }
                    ZStack(alignment: .bottom) {
                        if let selectedImage = selectedImage {
                            Image(uiImage: selectedImage).resizable().clipShape(Circle()).frame(width: 120, height: 120)
                        } else {
                            user.photo.resizable().scaledToFill().clipShape(Circle()).frame(width: 120, height: 120)
                        }
                        Image(systemName: "camera").resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24, alignment: .center)
                            .foregroundColor(.white)
                            .padding(Dimens.smallPadding)
                            .background(Color(.onSurfaceDark))
                            .clipShape(Circle()).clipped().offset(x: 32, y: 16)
                    }.onTapGesture {
                        self.sourceType = .photoLibrary
                        self.isImagePickerDisplay.toggle()
                    }
                }
                Section(footer: Text(presenter.emailMessage).foregroundColor(.red)) {
                    TextField("Email...", text: $presenter.email)
                        .font(.body)
                        .padding(24)
                        .clipShape(Rectangle())
                        .frame(height: 56)
                        .background(Color(.onSurfaceDark))
                        .cornerRadius(Dimens.cornerRadius)
                        .padding([.leading, .trailing])
                }
                
                TextField("\(LocalizedStrings.phoneNumber)...", text: $presenter.phoneNumber)
                    .font(.body)
                    .padding(24)
                    .clipShape(Rectangle())
                    .frame(height: 56)
                    .background(Color(.surfaceDark))
                    .cornerRadius(Dimens.cornerRadius)
                    .padding([.leading, .trailing, .bottom])
                
                Spacer()
                GeometryReader { geo in
                    Text(LocalizedStrings.save)
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
                                self.user.phoneNumber = self.presenter.phoneNumber
                                if let img = self.selectedImage {
                                    self.user.updatePhoto = img // notify changes to re-draw view
                                    self.user.photo = Image(uiImage: img)
                                }
                                self.showingForm = false
                            }
                        }
                }.background(Color(presenter.isFormValid ? .primary : .surfaceDark))
                .cornerRadius(16)
                .frame(height: 56)
                .padding([.leading, .trailing])
                GeometryReader { geo in
                    Text(LocalizedStrings.cancel)
                        .font(.body)
                        .fontWeight(.medium)
                        .foregroundColor(.black)
                        .padding(24)
                        .frame(width: geo.size.width)
                        .onTapGesture {
                            self.showingForm = false
                        }
                }.background(Color(.primary))
                .cornerRadius(Dimens.cornerRadius)
                .frame(height: 56)
                .padding([.leading, .trailing])
                
            }
        }.onAppear {
            self.presenter.fName = self.user.firstName
            self.presenter.lName = self.user.lastName
            self.presenter.email = self.user.email
            self.presenter.phoneNumber = self.user.phoneNumber
        }.sheet(isPresented: self.$isImagePickerDisplay) {
            ImagePickerView(selectedImage: self.$selectedImage, sourceType: self.sourceType)
        }
    }
}

struct EditProfileScreen_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileScreen(showingForm: .constant(false), presenter: UserPresenter())
    }
}
