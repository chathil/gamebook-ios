//
//  FavoriteSpec.swift
//  gamebookUITests
//
//  Created by Abdul Chathil on 12/14/20.
//  Copyright © 2020 Abdul Chathil. All rights reserved.
//

import Quick
import Nimble
import XCTest
import Common

class FavoriteSpec: QuickSpec {
    override func spec() {
        let subject = XCUIApplication()
        describe("Favorite Games") {
            it("Has navigation") {
                subject.tables.staticTexts[LocalizedStrings.yourFavoriteGames].tap()
                let favoritNavigationBar = subject.navigationBars[LocalizedStrings.favorites]
                expect(favoritNavigationBar.exists).to(beTrue())
                favoritNavigationBar.buttons["Back"].tap()
            }
        }
    }
}
