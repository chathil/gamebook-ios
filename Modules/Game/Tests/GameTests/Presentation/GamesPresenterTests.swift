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

final class GamesPresenterTests: XCTestCase {
    private var cancellables: Set<AnyCancellable> = []
    
    private var presenter: GetListPresenter<String, GameModel, FakeGamesInteractor>?
    
    override func setUp() {
        cancellables = []
        let propertyInjector = try?
            ComponentFactory.of(GamesPresenterTests.Component.self).build(())
        propertyInjector?.injectProperties(into: self)
        precondition(presenter != nil)
    }
    
    func testGetList() {
        presenter?.getList(request: nil)
        expect(self.presenter?.list.count).toEventually(equal(1))
        expect(self.presenter?.isError).toEventually(equal(false))
        expect(self.presenter?.errorMessage).toEventually(equal(""))
    }
    
    static var allTests = [
        ("testGetList", testGetList)
    ]
    
}

extension GamesPresenterTests {
    func injectProperties(_ fakeLocal: FakeGetGamesLocalDataSource, fakeRemote: FakeGetGamesRemoteDataSource, mapper: GamesTransformer<GameTransformer>) {
        let repository = GetGamesRepository(localDataSource: fakeLocal, remoteDataSource: fakeRemote, mapper: mapper)
        self.presenter = GetListPresenter(useCase: FakeGamesInteractor(repository: repository))
    }
    
    struct Component: Cleanse.RootComponent {
        typealias Root = PropertyInjector<GamesPresenterTests>
        static func configure(binder: Binder<Singleton>) {
            binder.include(module: FakeGetGamesLocalDataSource.Module.self)
            binder.include(module: FakeGetGamesRemoteDataSource.Module.self)
            binder.include(module: GamesTransformer<GameTransformer>.Module.self)
        }
        
        static func configureRoot(binder bind: ReceiptBinder<PropertyInjector<GamesPresenterTests>>) -> BindingReceipt<PropertyInjector<GamesPresenterTests>> {
            return bind.propertyInjector { (bind) ->
                BindingReceipt<PropertyInjector<GamesPresenterTests>> in
                return bind.to(injector: GamesPresenterTests.injectProperties)
            }
        }
        
    }
}
