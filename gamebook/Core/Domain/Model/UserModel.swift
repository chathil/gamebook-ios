//
//  User.swift
//  fundamental-sub-one
//
//  Created by Abdul Chathil on 7/3/20.
//  Copyright © 2020 Abdul Chathil. All rights reserved.
//

import Foundation

struct User {
    private let firstNameKey = "models.user.fname"
    private let lastNameKey = "models.user.lname"
    private let emailKey = "models.user.email"
    let photo = "me"
    
    var fullName: String {
        firstName + " " + lastName
    }
    
    var firstName: String {
        get {
            return UserDefaults.standard.string(forKey: firstNameKey) ?? "Abdul"
        }
        set {
            UserDefaults.standard.set(newValue, forKey: firstNameKey)
        }
    }
    
    var lastName: String {
        get {
            return UserDefaults.standard.string(forKey: lastNameKey) ?? "Chathil"
        }
        set {
            UserDefaults.standard.set(newValue, forKey: lastNameKey)
        }
    }
    
    var email: String {
        get {
            return UserDefaults.standard.string(forKey: emailKey) ?? "chathil98@gmail.com"
        }
        set {
            UserDefaults.standard.set(newValue, forKey: emailKey)
        }
    }
    
}

extension User {
    static let fakeUser = User()
}
