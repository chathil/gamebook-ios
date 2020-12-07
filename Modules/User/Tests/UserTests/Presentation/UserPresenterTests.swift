//
//  File.swift
//
//
//  Created by Abdul Chathil on 12/5/20.
//

import Nimble
import XCTest
import SwiftUI
import Common
@testable import User

final class UserPresenterTests: XCTestCase {
    let userPresenter = UserPresenter()
    
    func testFirstNameValidity() {
        userPresenter.fName = "Abdul"
        expect(self.userPresenter.fNameMessage).toEventually(equal(""))
    }
    
    func testFirstNameValidityError() {
        userPresenter.fName = "A"
        expect(self.userPresenter.fNameMessage).toEventually(equal(LocalizedStrings.firstNameError))
    }
    
    func testLastNameValidity() {
        userPresenter.lName = "Chathil"
        expect(self.userPresenter.lNameMessage).toEventually(equal(""))
    }
    
    func testLastNameValidityError() {
        userPresenter.lName = "C"
        expect(self.userPresenter.lNameMessage).toEventually(equal(LocalizedStrings.lastNameError))
    }
    
    func testEmailValidity() {
        userPresenter.email = "chathil98@gmail.com"
        expect(self.userPresenter.emailMessage).toEventually(equal(""))
    }
    
    func testEmailValidityError() {
        userPresenter.email = "googoogaga*gmail.com"
        expect(self.userPresenter.emailMessage).toEventually(equal(LocalizedStrings.emailError))
        
    }
    
    func testFormValidity() {
        userPresenter.fName = "Abdul"
        userPresenter.lName = "Chathil"
        userPresenter.email = "chathil98@gmail.com"
        expect(self.userPresenter.isFormValid).toEventually(equal(true))
    }
    
    func testFormValidityError() {
        userPresenter.fName = "Abdul"
        userPresenter.lName = "Chathil"
        userPresenter.email = "chathil98*gmail.com"
        expect(self.userPresenter.isFormValid).toEventually(equal(false))
    }
    
    static var allTests = [
        ("testFirstNameValidity", testFirstNameValidity),
        ("testFirstNameValidityError", testFirstNameValidityError),
        ("testLastNameValidity", testLastNameValidity),
        ("testLastNameValidityError", testLastNameValidityError),
        ("testEmailValidity", testEmailValidity),
        ("testEmailValidityError", testEmailValidityError),
        ("testFormValidity", testFormValidity),
        ("testFormValidityError", testFormValidityError)
    ]
}
