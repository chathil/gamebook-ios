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

final class GetGamesLocalDataSourceTests: XCTestCase {
    private var cancellables: Set<AnyCancellable> = []
    
    private var gamesDataSource: GetGamesLocalDataSource?
    private var games: [GameEntity] = []
    
    override func setUp() {
        cancellables = []
        let propertyInjector = try? ComponentFactory.of(GetGamesLocalDataSourceTests.Component.self).build(())
        propertyInjector?.injectProperties(into: self)
        precondition(gamesDataSource != nil)
        games = GamesTransformer(gameMapper: GameTransformer()).transformResponseToEntity(response: GameResponse.fakeGames)
    }
    
    func testList() {
        gamesDataSource?.add(entities: games)
            .sink(receiveCompletion: { _ in
            }, receiveValue: {
                expect($0) == true
                self.gamesDataSource?.list(request: nil).sink(receiveCompletion: { _ in }, receiveValue: { games in
                    expect(games) == self.games
                }).store(in: &self.cancellables)
            }).store(in: &cancellables)
        
    }
    
    func testGet() {
        expect { self.gamesDataSource?.get(id: 0) }.to(throwAssertion())
    }
    func testUpdate() {
        expect { self.gamesDataSource?.update(id: 1, entity: self.games[0]) }.to(throwAssertion())
    }
    
}

extension GetGamesLocalDataSourceTests {
    func injectProperties(_ gamesDataSource: GetGamesLocalDataSource) {
        self.gamesDataSource = gamesDataSource
    }
    struct Component: Cleanse.RootComponent {
        typealias Root = PropertyInjector<GetGamesLocalDataSourceTests>
        static func configure(binder: Binder<Singleton>) {
            binder.include(module: GetGamesLocalDataSource.Module.self)
        }
        static func configureRoot(binder bind: ReceiptBinder<PropertyInjector<GetGamesLocalDataSourceTests>>) -> BindingReceipt<PropertyInjector<GetGamesLocalDataSourceTests>> {
            return bind.propertyInjector { (bind) ->
                BindingReceipt<PropertyInjector<GetGamesLocalDataSourceTests>> in
                return bind.to(injector: GetGamesLocalDataSourceTests.injectProperties)
            }
        }
    }
}
