//
//  File.swift
//
//
//  Created by Abdul Chathil on 12/4/20.
//

import XCTest
import Nimble
@testable import Common

final class LocalizedStringTests: XCTestCase {
    
    func testLocalization() {
        expect("your_favorite_games".localized(forLanguage: "en")).to(equal("Your Favorite Games"))
        expect("your_favorite_games".localized(forLanguage: "id")).to(equal("Game Favorit Kamu"))
    }

    static var allTests = [
        ("testLocalization", testLocalization)
    ]
}
