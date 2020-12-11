//
//  File.swift
//  
//
//  Created by Abdul Chathil on 12/8/20.
//

import XCTest
import Nimble
import Cleanse
import Combine
@testable import Game

final class GetFavoriteGamesRepositoryTests: XCTestCase {
    private var cancellables: Set<AnyCancellable> = []
    private var repository: GetFavoriteGamesRepository<FakeGetFavoriteGamesLocalDataSource, GamesTransformer<GameTransformer>>?
    
    override func setUp() {
        cancellables = []
        let propertyInjector = try? ComponentFactory.of(GetFavoriteGamesRepositoryTests.Component.self).build(())
        propertyInjector?.injectProperties(into: self)
        precondition(repository != nil)
    }
    
    func testExecute() {
        repository?.execute(request: nil).sink(receiveCompletion: { _ in }, receiveValue: { expect($0[0].id) == GameResponse.fakeGame.id }).store(in: &cancellables)
    }
    
    static var allTests = [
        ("testExecute", testExecute)
    ]
    
}

extension GetFavoriteGamesRepositoryTests {
    func injectProperties(_ localDataSource: FakeGetFavoriteGamesLocalDataSource, _ mapper: GamesTransformer<GameTransformer>) {
        self.repository = GetFavoriteGamesRepository(localDataSource: localDataSource, mapper: mapper)
    }
    
    struct Component: Cleanse.RootComponent {
        typealias Root = PropertyInjector<GetFavoriteGamesRepositoryTests>
        static func configure(binder: Binder<Singleton>) {
            binder.include(module: FakeGetFavoriteGamesLocalDataSource.Module.self)
            binder.include(module: GamesTransformer<GameTransformer>.Module.self)
        }
        static func configureRoot(binder bind: ReceiptBinder<PropertyInjector<GetFavoriteGamesRepositoryTests>>) -> BindingReceipt<PropertyInjector<GetFavoriteGamesRepositoryTests>> {
            return bind.propertyInjector { (bind) ->
                BindingReceipt<PropertyInjector<GetFavoriteGamesRepositoryTests>> in
                return bind.to(injector: GetFavoriteGamesRepositoryTests.injectProperties)
            }
        }
    }
    
}
