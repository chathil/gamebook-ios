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
        expect(self.transformer.transformResponseToEntity(response: GamesResponse.fakeGame)).to(beAKindOf(GamesEntity.self))
    }
    func testTransformResponseToDomain() {
        expect(self.transformer.transformResponseToDomain(response: GamesResponse.fakeGame)).to(beAKindOf(GamesModel.self))
    }
    func testTransformEntityToDomain() {
        let entity = transformer.transformResponseToEntity(response: GamesResponse.fakeGame)
        expect(self.transformer.transformEntityToDomain(entity: entity)).to(beAKindOf(GamesModel.self))
    }
    func testTransformDomainToEntity() {
        let domain = transformer.transformResponseToDomain(response: GamesResponse.fakeGame)
        expect(self.transformer.transformDomainToEntity(domain: domain)).to(beAKindOf(GamesEntity.self))
    }
    
    static var allTests = [
        ("testTransformResponseToEntity", testTransformResponseToEntity),
        ("testTransformResponseToDomain", testTransformResponseToDomain),
        ("testTransformEntityToDomain", testTransformEntityToDomain),
        ("testTransformDomainToEntity", testTransformDomainToEntity)
    ]
}
