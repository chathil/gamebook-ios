//
//  EditProfileSpec.swift
//  gamebookUITests
//
//  Created by Abdul Chathil on 12/13/20.
//  Copyright © 2020 Abdul Chathil. All rights reserved.
//

import Quick
import Nimble
import XCTest
import Common

class EditProfileSpec: QuickSpec {
    override func spec() {
        let subject = XCUIApplication()
        let scrollViewsQuery = subject.scrollViews
        let elementsQuery = scrollViewsQuery.otherElements
        elementsQuery.images["pencil"].tap()
        let element = subject.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element(boundBy: 0)
        describe("EditProfileScreen") {
            context("When editing text") {
                it("has edit profile title, illustration, 4 textfields, picture edit button, and save & cancel button") {
                    
                    expect(elementsQuery.staticTexts[LocalizedStrings.editProfile].exists).to(beTrue())
                    expect(elementsQuery.images["profile"].exists).to(beTrue())
                    expect(elementsQuery.textFields.count).to(equal(4))
                    expect(elementsQuery.images["camera"].exists).to(beTrue())
                    
                    expect(elementsQuery.staticTexts[LocalizedStrings.save].exists).to(beTrue())
                    expect(elementsQuery.staticTexts[LocalizedStrings.cancel].exists).to(beTrue())
                    
                }
            }
            context("When editing photo") {
                it("it opened a popup to choose photos") {
                    elementsQuery.images["camera"].tap()
                    element.swipeDown(velocity: XCUIGestureVelocity.fast)
                    element.swipeDown(velocity: XCUIGestureVelocity.fast)
                    subject.navigationBars[LocalizedStrings.accountAbout].buttons["Back"].tap()
                }
            }
        }
    }
}
