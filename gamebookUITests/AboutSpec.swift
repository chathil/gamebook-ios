//
//  AboutSpec.swift
//  gamebookUITests
//
//  Created by Abdul Chathil on 12/13/20.
//  Copyright © 2020 Abdul Chathil. All rights reserved.
//

import Quick
import Nimble
import XCTest
import Common

class AboutSpec: QuickSpec {
    override func spec() {
        let subject = XCUIApplication()
        subject.launch()
        subject.activate()
        let scrollViewsQuery = subject.scrollViews
        let elementsQuery = scrollViewsQuery.otherElements
        subject.tables.staticTexts[LocalizedStrings.account].tap()
        describe("Account & About") {
                it("Has navigation, edit profile button, about, and credits") {
                    expect(subject.navigationBars[LocalizedStrings.accountAbout].staticTexts[LocalizedStrings.accountAbout].exists).to(beTrue())
                    expect(elementsQuery.images["pencil"].firstMatch.exists).to(beTrue())
                    expect(elementsQuery.staticTexts[LocalizedStrings.about].exists).to(beTrue())
                    expect(elementsQuery.staticTexts[LocalizedStrings.credits].exists).to(beTrue())
                }
        }
        
    }
}
