//
//  User.swift
//  fundamental-sub-one
//
//  Created by Abdul Chathil on 7/3/20.
//  Copyright © 2020 Abdul Chathil. All rights reserved.
//
import Foundation
import Combine

class User: ObservableObject {
    private let firstNameKey = "models.user.fname"
    private let lastNameKey = "models.user.lname"
    private let emailKey = "models.user.email"
    let photo = "me"
    
    init() {
        firstName = UserDefaults.standard.object(forKey: firstNameKey) as? String ?? "Abdul"
        self.lastName = UserDefaults.standard.object(forKey: lastNameKey) as? String ?? "Chathil"
        self.email = UserDefaults.standard.object(forKey: emailKey) as? String ?? "chathil98@gmail.com"
    }
    
    var fullName: String {
        "\(String(describing: firstName)) \(String(describing: lastName))"
    }
    
    @Published var firstName: String {
        didSet {
            UserDefaults.standard.set(firstName, forKey: firstNameKey)
        }
    }
    
    @Published var lastName: String {
        didSet {
            UserDefaults.standard.set(lastName, forKey: lastNameKey)
        }
    }
    
    @Published var email: String {
        didSet {
            UserDefaults.standard.set(email, forKey: emailKey)
        }
    }
    
}

extension User {
    static let fakeUser = User()
}
