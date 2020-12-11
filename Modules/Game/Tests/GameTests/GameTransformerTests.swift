//
//  File.swift
//  
//
//  Created by Abdul Chathil on 12/8/20.
//

import Nimble
import XCTest
@testable import Game

final class GameTransformerTests: XCTestCase {
    
    private let transformer = GameTransformer()
    
    func testTransformResponseToEntity() {
        expect(self.transformer.transformResponseToEntity(response: GameResponse.fakeGame)).to(beAKindOf(GameEntity.self))
    }
    func testTransformResponseToDomain() {
        expect(self.transformer.transformResponseToDomain(response: GameResponse.fakeGame)).to(beAKindOf(GameModel.self))
    }
    func testTransformEntityToDomain() {
        let entity = transformer.transformResponseToEntity(response: GameResponse.fakeGame)
        expect(self.transformer.transformEntityToDomain(entity: entity)).to(beAKindOf(GameModel.self))
    }
    func testTransformDomainToEntity() {
        let domain = transformer.transformResponseToDomain(response: GameResponse.fakeGame)
        expect(self.transformer.transformDomainToEntity(domain: domain)).to(beAKindOf(GameEntity.self))
    }
    
    static var allTests = [
        ("testTransformResponseToEntity", testTransformResponseToEntity),
        ("testTransformResponseToDomain", testTransformResponseToDomain),
        ("testTransformEntityToDomain", testTransformEntityToDomain),
        ("testTransformDomainToEntity", testTransformDomainToEntity)
    ]
}
