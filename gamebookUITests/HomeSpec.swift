//
//  HomeSpec.swift
//  gamebookUITests
//
//  Created by Abdul Chathil on 12/12/20.
//  Copyright © 2020 Abdul Chathil. All rights reserved.
//

import Quick
import Nimble
import XCTest
import Common

class HomeSpec: QuickSpec {
    
    override func spec() {
        let subject = XCUIApplication()
        
        describe("HomeScreen") {
            context("When loading data") {
                it("Has account snippet card, favorite games card, and find card") {
                    expect(subject.tables.staticTexts[LocalizedStrings.account].exists).to(beTrue())
                    expect(subject.tables.staticTexts[LocalizedStrings.yourFavoriteGames].exists).to(beTrue())
                    expect(subject.tables.staticTexts[LocalizedStrings.find].exists).to(beTrue())
                }
            }
            
            context("When data is loaded") {
                it("Has game list") {
                    expect(subject.tables.images["meta"].firstMatch.exists).to(beTrue())
                }
            }
        }
    }
}
