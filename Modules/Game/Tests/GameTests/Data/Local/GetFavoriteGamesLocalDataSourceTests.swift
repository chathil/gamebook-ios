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
    
    var favoriteDataSource: GetFavoriteGamesLocalDataSource?
    var gamesDataSource: GetGamesLocalDataSource?
    var games: [GameEntity] = []
    
    override func setUp() {
        cancellables = []
        let propertyInjector = try? ComponentFactory.of(GetFavoriteGamesLocalDataSourceTests.Component.self).build(())
        propertyInjector?.injectProperties(into: self)
        precondition(favoriteDataSource != nil)
        precondition(gamesDataSource != nil)
        games = GamesTransformer(gameMapper: GameTransformer()).transformResponseToEntity(response: GameResponse.fakeGames)
    }
    
    func testList() {
        gamesDataSource?.add(entities: games)
            .sink(receiveCompletion: { _ in
            }, receiveValue: {
                expect($0) == true
                
                self.favoriteDataSource?.update(id: 1, entity: self.games[0])
                    .sink(receiveCompletion: { _ in
                    }, receiveValue: { [self] in
                        expect($0) == games
                        
                        self.favoriteDataSource?.list(request: nil).sink(receiveCompletion: { _ in
                        }, receiveValue: { [self] in
                            expect($0) == games
                        })
                        .store(in: &self.cancellables)
                        
                    })
                    .store(in: &self.cancellables)
                
            })
            .store(in: &cancellables)
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
        ("testList", testList),
        ("testAdd", testAdd),
        ("testGet", testGet)
    ]
}

extension GetFavoriteGamesLocalDataSourceTests {
    func injectProperties(_ localDataSource: GetFavoriteGamesLocalDataSource, _ gamesDataSource: GetGamesLocalDataSource) {
        self.favoriteDataSource = localDataSource
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
