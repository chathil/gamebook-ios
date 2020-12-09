//
//  File.swift
//  
//
//  Created by Abdul Chathil on 12/8/20.
//

import XCTest
import Nimble
import Cleanse
import RealmSwift
import Combine
import Core
@testable import Game

final class GetGameLocalDataSourceTests: XCTestCase {
    private var cancellables: Set<AnyCancellable> = []
    
    private var gameDataSource: GetGameLocalDataSource?
    private var gamesDataSource: GetGamesLocalDataSource?
    private var games: [GameEntity] = []
    
    override func setUp() {
        cancellables = []
        let propertyInjector = try? ComponentFactory.of(GetGameLocalDataSourceTests.Component.self).build(())
        propertyInjector?.injectProperties(into: self)
        precondition(gameDataSource != nil)
        precondition(gamesDataSource != nil)
        games = GamesTransformer(gameMapper: GameTransformer()).transformResponseToEntity(response: GameResponse.fakeGames)
        gamesDataSource?.add(entities: games)
            .sink(receiveCompletion: { _ in
            }, receiveValue: {
                expect($0) == true
            }).store(in: &cancellables)
    }
    
    func testList() {
        expect {
            self.gameDataSource?.list(request: nil)
        }.to(throwAssertion())
    }
    
    func testAdd() {
        expect {
            self.gameDataSource?.add(entities: self.games)
        }.to(throwAssertion())
    }
    
    func testGet() {
        self.gameDataSource?.get(id: games[0].id)
            .sink(receiveCompletion: { _ in},
                  receiveValue: {
                    expect($0) == self.games[0]
                  }).store(in: &cancellables)
    }
    func testUpdate() {
        self.gameDataSource?.update(id: games[0].id, entity: games[0]).sink(receiveCompletion: { _ in }, receiveValue: {
            expect($0) == true
        }).store(in: &cancellables)
    }
    
    func testUpdateWithoutIdError() {
        expect {
            self.gameDataSource?.update(id: self.games[0].id, entity: nil)
            .sink(receiveCompletion: { _ in }, receiveValue: { _ in })
                .store(in: &self.cancellables)
        }.toEventually(throwAssertion())
    }
    
    static var allTests = [
        ("testList", testList),
        ("testAdd", testAdd),
        ("testGet", testGet),
        ("testUpdate", testUpdate)
    ]
    
}

extension GetGameLocalDataSourceTests {
    func injectProperties(_ gameDataSource: GetGameLocalDataSource, _ gamesDataSource: GetGamesLocalDataSource) {
        self.gameDataSource = gameDataSource
        self.gamesDataSource = gamesDataSource
    }
    
    struct Component: Cleanse.RootComponent {
        typealias Root = PropertyInjector<GetGameLocalDataSourceTests>
        static func configure(binder: Binder<Singleton>) {
            binder.include(module: GetGameLocalDataSource.Module.self)
            binder.include(module: GetGamesLocalDataSource.Module.self)
        }
        static func configureRoot(binder bind: ReceiptBinder<PropertyInjector<GetGameLocalDataSourceTests>>) -> BindingReceipt<PropertyInjector<GetGameLocalDataSourceTests>> {
            return bind.propertyInjector { (bind) ->
                BindingReceipt<PropertyInjector<GetGameLocalDataSourceTests>> in
                return bind.to(injector: GetGameLocalDataSourceTests.injectProperties)
            }
        }
    }
    
}
