//
//  File.swift
//
//
//  Created by Abdul Chathil on 12/5/20.
//

import Nimble
import XCTest
import SwiftUI
@testable import User

final class UserModelTests: XCTestCase {
    let user: User! = User.fakeUser
    override func setUp() {
        user.firstName = "Abdul"
        user.lastName = "Chathil"
        user.email = ""
        user.updatePhoto = nil
    }
    
    func testUser() {
        expect(self.user.fullName) == "Abdul Chathil"
    }
    
    func testCalculateCompletion() {
        expect((self.user.profileCompletion * 100).rounded()) == 60
    }
    
    func testSaveImage() {
        let defaultImage = Image(systemName: "heart.fill")
        user.photo = defaultImage
        expect(self.user.photo) == defaultImage
    }
    
    static var allTests = [
        ("testUser", testUser),
        ("testCalculateCompletion", testCalculateCompletion),
        ("testSaveImage", testSaveImage)
    ]
}
