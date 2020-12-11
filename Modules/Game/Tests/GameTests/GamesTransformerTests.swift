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
        expect(self.transformer.transformResponseToEntity(response: GameResponse.fakeGames)).to(beAKindOf([GameEntity].self))
    }
    func testTransformResponseToDomain() {
        expect(self.transformer.transformResponseToDomain(response: GameResponse.fakeGames)).to(beAKindOf([GameModel].self))
    }
    func testTransformEntityToDomain() {
        let entities = transformer.transformResponseToEntity(response: GameResponse.fakeGames)
        expect(self.transformer.transformEntityToDomain(entity: entities)).to(beAKindOf([GameModel].self))
    }
    func testTransformDomainToEntity() {
        let domains = transformer.transformResponseToDomain(response: GameResponse.fakeGames)
        expect(self.transformer.transformDomainToEntity(domain: domains)).to(beAKindOf([GameEntity].self))
    }
    
    static var allTests = [
        ("testTransformResponseToEntity", testTransformResponseToEntity),
        ("testTransformResponseToDomain", testTransformResponseToDomain),
        ("testTransformEntityToDomain", testTransformEntityToDomain),
        ("testTransformDomainToEntity", testTransformDomainToEntity)
    ]
}
