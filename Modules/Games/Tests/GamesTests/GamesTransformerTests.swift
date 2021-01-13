//
//  File.swift
//  
//
//  Created by Abdul Chathil on 12/8/20.
//

import Nimble
import XCTest
@testable import Game

final class GamesTranformerTests: XCTestCase {
    
    private let transformer = GamesTransformer(gameMapper: GameTransformer())
    
    func testTransformResponseToEntity() {
        expect(self.transformer.transformResponseToEntity(response: GamesResponse.fakeGames)).to(beAKindOf([GamesEntity].self))
    }
    func testTransformResponseToDomain() {
        expect(self.transformer.transformResponseToDomain(response: GamesResponse.fakeGames)).to(beAKindOf([GamesModel].self))
    }
    func testTransformEntityToDomain() {
        let entities = transformer.transformResponseToEntity(response: GamesResponse.fakeGames)
        expect(self.transformer.transformEntityToDomain(entity: entities)).to(beAKindOf([GamesModel].self))
    }
    func testTransformDomainToEntity() {
        let domains = transformer.transformResponseToDomain(response: GamesResponse.fakeGames)
        expect(self.transformer.transformDomainToEntity(domain: domains)).to(beAKindOf([GamesEntity].self))
    }
    
    static var allTests = [
        ("testTransformResponseToEntity", testTransformResponseToEntity),
        ("testTransformResponseToDomain", testTransformResponseToDomain),
        ("testTransformEntityToDomain", testTransformEntityToDomain),
        ("testTransformDomainToEntity", testTransformDomainToEntity)
    ]
}
