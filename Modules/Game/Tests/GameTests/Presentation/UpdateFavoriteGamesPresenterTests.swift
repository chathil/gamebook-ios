//
//  File.swift
//  
//
//  Created by Abdul Chathil on 12/11/20.
//

import XCTest
import Nimble
import Cleanse
import Core
import Combine
@testable import Game

final class UpdateFavoriteGamesPresenterTests: XCTestCase {
    private var cancellables: Set<AnyCancellable> = []
    
    private var presenter: GetListPresenter<GameModel, GameModel, FakeUpdateFavoriteGamesInteractor>?
    
    override func setUp() {
        cancellables = []
        let propertyInjector = try? ComponentFactory.of(UpdateFavoriteGamesPresenterTests.Component.self).build(())
        propertyInjector?.injectProperties(into: self)
        precondition(presenter != nil)
    }
    
    func testGetList() {
        presenter?.getList(request: GameTransformer().transformResponseToDomain(response: GameResponse.fakeGame))
        expect(self.presenter?.list.count).toEventually(equal(1))
        expect(self.presenter?.isError).toEventually(equal(false))
        expect(self.presenter?.errorMessage).toEventually(equal(""))
    }
    
    static var allTests = [
        ("testGetList", testGetList)
    ]
    
}

extension UpdateFavoriteGamesPresenterTests {
    func injectProperties(_ localDataSource: FakeGetFavoriteGamesLocalDataSource, _ mapper: GamesTransformer<GameTransformer>) {
        let repository = UpdateFavoriteGamesRepository(localDataSource: localDataSource, mapper: mapper)
        self.presenter = GetListPresenter(useCase: FakeUpdateFavoriteGamesInteractor(repository: repository))
    }
    struct Component: Cleanse.RootComponent {
        typealias Root = PropertyInjector<UpdateFavoriteGamesPresenterTests>
        static func configure(binder: Binder<Singleton>) {
            binder.include(module: FakeGetFavoriteGamesLocalDataSource.Module.self)
            binder.include(module: GamesTransformer<GameTransformer>.Module.self)
        }
        static func configureRoot(binder bind: ReceiptBinder<PropertyInjector<UpdateFavoriteGamesPresenterTests>>) -> BindingReceipt<PropertyInjector<UpdateFavoriteGamesPresenterTests>> {
            return bind.propertyInjector { (bind) ->
                BindingReceipt<PropertyInjector<UpdateFavoriteGamesPresenterTests>> in
                return bind.to(injector: UpdateFavoriteGamesPresenterTests.injectProperties)
            }
        }
    }
}
