//
//  User.swift
//  fundamental-sub-one
//
//  Created by Abdul Chathil on 7/3/20.
//  Copyright © 2020 Abdul Chathil. All rights reserved.
//
import Foundation
import Combine
import SwiftUI

public class User: ObservableObject {
    private let firstNameKey = "models.user.fname"
    private let lastNameKey = "models.user.lname"
    private let emailKey = "models.user.email"
    private let phoneNumberKey = "models.user.phoneNumber"
    static let photoName = "user.jpg"
    static let defaultPhotoName = "me"
    
    init() {
        firstName = UserDefaults.standard.object(forKey: firstNameKey) as? String ?? "Abdul"
        self.lastName = UserDefaults.standard.object(forKey: lastNameKey) as? String ?? "Chathil"
        self.email = UserDefaults.standard.object(forKey: emailKey) as? String ?? "chathil98@gmail.com"
        self.phoneNumber = UserDefaults.standard.object(forKey: phoneNumberKey) as? String ?? ""
        self.photo = {
            let documentDirectory = FileManager.SearchPathDirectory.documentDirectory
            let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
            let paths = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)
            
            if let dirPath = paths.first {
                let imageUrl = URL(fileURLWithPath: dirPath).appendingPathComponent(User.photoName)
                guard let image = UIImage(contentsOfFile: imageUrl.path) else { return Image(User.defaultPhotoName) }
                return Image(uiImage: image)
            }
            return Image(User.defaultPhotoName)
        }()
        calculateCompletion()
    }
    
    public var fullName: String {
        "\(String(describing: firstName)) \(String(describing: lastName))"
    }
    
    @Published public var firstName: String {
        didSet {
            UserDefaults.standard.set(firstName, forKey: firstNameKey)
            calculateCompletion()
        }
    }
    
    @Published public var lastName: String {
        didSet {
            UserDefaults.standard.set(lastName, forKey: lastNameKey)
            calculateCompletion()
        }
    }
    
    @Published public var email: String {
        didSet {
            UserDefaults.standard.set(email, forKey: emailKey)
            calculateCompletion()
        }
    }
    
    @Published public var phoneNumber: String {
        didSet {
            UserDefaults.standard.set(phoneNumber, forKey: phoneNumberKey)
            calculateCompletion()
        }
    }
    
    @Published public var updatePhoto: UIImage?
    
    @Published public var photo: Image {
        didSet {
            saveImage(image: updatePhoto)
            calculateCompletion()
        }
    }
    
    @Published public var profileCompletion: Double = 0.0
    
    // dummy profile completion calculation. everything except
    // phoneNumber can't be empty/ nil but i check it anyway
    private func calculateCompletion() {
        var completion = 0.0
        if !firstName.isEmpty {
            completion += 0.2
        }
        if !lastName.isEmpty {
            completion += 0.2
        }
        if !email.isEmpty {
            completion += 0.2
        }
        if !phoneNumber.isEmpty {
            completion += 0.2
        }
        if photo != nil {
            completion += 0.2
        }
        profileCompletion = completion
    }
    
    private func saveImage(image: UIImage?) {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let fileURL = documentsDirectory.appendingPathComponent(User.photoName)
        guard let data = image?.jpegData(compressionQuality: 1) else { return }
        
        //Checks if file exists, removes it if so.
        if FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                try FileManager.default.removeItem(atPath: fileURL.path)
                print("Removed old image")
            } catch let removeError {
                print("couldn't remove file at path", removeError)
            }
        }
        
        do {
            try data.write(to: fileURL)
        } catch let error {
            print("error saving file with error", error)
        }
    }
}

public extension User {
    static let fakeUser = User()
}
