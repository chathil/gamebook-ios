//
//  File.swift
//  
//
//  Created by Abdul Chathil on 12/9/20.
//

import XCTest
import Nimble
import Cleanse
import Combine
@testable import Game

final class UpdateFavoriteGamesRepositoryTests: XCTestCase {
    private var cancellables: Set<AnyCancellable> = []
    private var repository: UpdateFavoriteGamesRepository<FakeGetFavoriteGamesLocalDataSource, GamesTransformer<GameTransformer>>?
    
    override func setUp() {
        cancellables = []
        let propertyInjector = try? ComponentFactory.of(UpdateFavoriteGamesRepositoryTests.Component.self).build(())
        propertyInjector?.injectProperties(into: self)
        precondition(repository != nil)
    }
    
    func testExecuteWithoutIdError() {
        expect {
            self.repository?.execute(request: nil).sink(receiveCompletion: { _ in }, receiveValue: { expect($0[0].id) == GamesResponse.fakeGame.id }).store(in: &self.cancellables)
        }.toEventually(throwAssertion())
    }
    
    func testExecute() {
        repository?.execute(request: GameTransformer().transformResponseToDomain(response: GamesResponse.fakeGame)).sink(receiveCompletion: { _ in }, receiveValue: { expect($0[0].id) == GamesResponse.fakeGame.id }).store(in: &cancellables)
    }
    
    static var allTests = [
        ("testExecute", testExecute),
        ("testExecuteWithoutIdError", testExecuteWithoutIdError)
    ]
    
}

extension UpdateFavoriteGamesRepositoryTests {
    func injectProperties(_ localDataSource: FakeGetFavoriteGamesLocalDataSource, _ mapper: GamesTransformer<GameTransformer>) {
        self.repository = UpdateFavoriteGamesRepository(localDataSource: localDataSource, mapper: mapper)
    }
    
    struct Component: Cleanse.RootComponent {
        typealias Root = PropertyInjector<UpdateFavoriteGamesRepositoryTests>
        static func configure(binder: Binder<Singleton>) {
            binder.include(module: FakeGetFavoriteGamesLocalDataSource.Module.self)
            binder.include(module: GamesTransformer<GameTransformer>.Module.self)
        }
        static func configureRoot(binder bind: ReceiptBinder<PropertyInjector<UpdateFavoriteGamesRepositoryTests>>) -> BindingReceipt<PropertyInjector<UpdateFavoriteGamesRepositoryTests>> {
            return bind.propertyInjector { (bind) ->
                BindingReceipt<PropertyInjector<UpdateFavoriteGamesRepositoryTests>> in
                return bind.to(injector: UpdateFavoriteGamesRepositoryTests.injectProperties)
            }
        }
    }
}
