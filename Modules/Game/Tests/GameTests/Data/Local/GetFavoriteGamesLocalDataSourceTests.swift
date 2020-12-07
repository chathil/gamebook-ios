//
//  File.swift
//
//
//  Created by Abdul Chathil on 12/5/20.
//

import XCTest
import Nimble
import Cleanse
import RealmSwift
import Combine
@testable import Game

final class GetFavoriteGamesLocalDataSourceTests: XCTestCase {
    
    var favoriteDataSource: GetFavoriteGamesLocalDataSource?
    var gamesDataSource: GetGamesLocalDataSource?
    var games: [GameEntity] = []
    
    override func setUp() {
        let propertyInjector = try? ComponentFactory.of(GetFavoriteGamesLocalDataSourceTests.Component.self).build(())
        propertyInjector?.injectProperties(into: self)
        precondition(favoriteDataSource != nil)
        games = GamesTransformer(gameMapper: GameTransformer()).transformResponseToEntity(response: GameResponse.fakeGames)
    }
    
    func testList() {
        gamesDataSource?.add(entities: games)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { _ in },
                  receiveValue: { expect($0) == true })
        
        //        expect(result).toEventually(equal(true))
        //        let results = favoriteDataSource?.list(request: nil).collect()
        //        expect(results).toEventually(equal(results))
    }
    
    func testAdd() {
        
    }
    
    func testGet() {
        
    }
    
    func testUpdate() {
        
    }
    
    static var allTests = [
        ("testList", testList)
    ]
    
}

extension GetFavoriteGamesLocalDataSourceTests {
    func injectProperties(_ localDataSource: GetFavoriteGamesLocalDataSource) {
        self.favoriteDataSource = localDataSource
    }
    struct Component: Cleanse.RootComponent {
        typealias Root = PropertyInjector<GetFavoriteGamesLocalDataSourceTests>
        static func configure(binder: Binder<Singleton>) {
            binder.include(module: GetGamesLocalDataSource.Module.self)
            binder.include(module: GetFavoriteGamesLocalDataSource.Module.self)
        }
        static func configureRoot(
            binder bind: ReceiptBinder<PropertyInjector<GetFavoriteGamesLocalDataSourceTests>>
        ) -> BindingReceipt<PropertyInjector<GetFavoriteGamesLocalDataSourceTests>> {
            return bind.propertyInjector { (bind) -> BindingReceipt<PropertyInjector<GetFavoriteGamesLocalDataSourceTests>> in
                return bind.to(injector: GetFavoriteGamesLocalDataSourceTests.injectProperties)
            }
        }
    }
}
