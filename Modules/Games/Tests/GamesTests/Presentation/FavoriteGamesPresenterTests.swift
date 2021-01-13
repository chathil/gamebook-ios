//
//  File.swift
//  
//
//  Created by Abdul Chathil on 12/8/20.
//

import XCTest
import Nimble
import Cleanse
import Core
import Combine
@testable import Game

final class FavoriteGamesPresenterTests: XCTestCase {
    
    private var cancellables: Set<AnyCancellable> = []
    
    private var presenter: GetListPresenter<Int32, GamesModel, FakeFavoriteGamesInteractor>?
    
    override func setUp() {
        cancellables = []
        let propertyInjector = try? ComponentFactory.of(FavoriteGamesPresenterTests.Component.self).build(())
        propertyInjector?.injectProperties(into: self)
        precondition(presenter != nil)
    }
    
    func testGetList() {
        presenter!.getList(request: nil)
        expect(self.presenter?.list.count).toEventually(equal(1))
        expect(self.presenter?.isError).toEventually(equal(false))
        expect(self.presenter?.errorMessage).toEventually(equal(""))
    }
    
    static var allTests = [
        ("testGetList", testGetList)
    ]
    
}

extension FavoriteGamesPresenterTests {
    func injectProperties(_ localDataSource: FakeGetFavoriteGamesLocalDataSource, _ mapper: GamesTransformer<GameTransformer>) {
        let repository = GetFavoriteGamesRepository(localDataSource: localDataSource, mapper: mapper)
        self.presenter = GetListPresenter(useCase: FakeFavoriteGamesInteractor(repository: repository))
    }
    
    struct Component: Cleanse.RootComponent {
        typealias Root = PropertyInjector<FavoriteGamesPresenterTests>
        static func configure(binder: Binder<Singleton>) {
            binder.include(module: FakeGetFavoriteGamesLocalDataSource.Module.self)
            binder.include(module: GamesTransformer<GameTransformer>.Module.self)
        }
        static func configureRoot(binder bind: ReceiptBinder<PropertyInjector<FavoriteGamesPresenterTests>>) -> BindingReceipt<PropertyInjector<FavoriteGamesPresenterTests>> {
            return bind.propertyInjector { (bind) ->
                BindingReceipt<PropertyInjector<FavoriteGamesPresenterTests>> in
                return bind.to(injector: FavoriteGamesPresenterTests.injectProperties)
            }
        }
    }
}
