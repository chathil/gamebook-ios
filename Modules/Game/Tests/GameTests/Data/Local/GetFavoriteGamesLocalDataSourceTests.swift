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
import Core
@testable import Game

final class GetFavoriteGamesLocalDataSourceTests: XCTestCase {
    
    private var cancellables: Set<AnyCancellable> = []
    
    private var favoriteDataSource: GetFavoriteGamesLocalDataSource?
    private var gamesDataSource: GetGamesLocalDataSource?
    private var games: [GameEntity] = []
    
    override func setUp() {
        cancellables = []
        let propertyInjector = try? ComponentFactory.of(GetFavoriteGamesLocalDataSourceTests.Component.self).build(())
        propertyInjector?.injectProperties(into: self)
        precondition(favoriteDataSource != nil)
        precondition(gamesDataSource != nil)
        games = GamesTransformer(gameMapper: GameTransformer()).transformResponseToEntity(response: GameResponse.fakeGames)
    }
    
    func testLikeAndList() {

                self.favoriteDataSource?.update(id: 1, entity: self.games[0])
                    .sink(receiveCompletion: { _ in
                    }, receiveValue: {
                        expect($0[0].id) == self.games[0].id

                        self.favoriteDataSource?.list(request: nil).sink(receiveCompletion: { _ in
                        }, receiveValue: { games in
                            expect(games[0].id) == self.games[0].id

                            self.favoriteDataSource?.update(id: 1, entity: self.games[0])
                                .sink(receiveCompletion: { _ in
                                }, receiveValue: {
                                    expect($0.count) == 0                                })
                                .store(in: &self.cancellables)
                        })
                        .store(in: &self.cancellables)

                    })
                    .store(in: &self.cancellables)

    }
    
    func testAdd() {
        expect {
            self.favoriteDataSource?.add(entities: self.games)
        }.to(throwAssertion())
    }
    
    func testGet() {
        expect {
            self.favoriteDataSource?.get(id: 1)
        }.to(throwAssertion())
    }
    
    static var allTests = [
        ("testLikeAndList", testLikeAndList),
        ("testAdd", testAdd),
        ("testGet", testGet)
    ]
}

extension GetFavoriteGamesLocalDataSourceTests {
    func injectProperties(_ favoriteDataSource: GetFavoriteGamesLocalDataSource, _ gamesDataSource: GetGamesLocalDataSource) {
        self.favoriteDataSource = favoriteDataSource
        self.gamesDataSource = gamesDataSource
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
