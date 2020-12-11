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

final class GamePresenterTests: XCTestCase {
    
    private var cancellables: Set<AnyCancellable> = []
    
    private var presenter: GetPresenter<Int32, GameModel, FakeGameInteractor>?
    
    override func setUp() {
        cancellables = []
        let propertyInjector = try? ComponentFactory.of(GamePresenterTests.Component.self).build(())
        propertyInjector?.injectProperties(into: self)
        precondition(presenter != nil)
    }
    
    func testGet() {
        presenter?.get()
        expect(self.presenter?.response?.id).toEventually(equal(GameResponse.fakeGame.id))
        expect(self.presenter?.errorMessage).toEventually(equal(""))
        expect(self.presenter?.isError).toEventually(equal(false))
    }
    
    static var allTests = [
        ("testGet", testGet)
    ]
    
}

extension GamePresenterTests {
    func injectProperties(_ localDataSource: FakeGetGameLocalDataSource, _ remoteDataSource: FakeGetGameRemoteDataSource, _ mapper: GameTransformer) {
        
        let repository = GetGameRepository(localDataSource: localDataSource, remoteDataSource: remoteDataSource, mapper: mapper)
        self.presenter = GetPresenter(useCase: FakeGameInteractor(repository: repository), request: GameResponse.fakeGame.id, response: mapper.transformResponseToDomain(response: GameResponse.fakeGame))
    }
    
    struct Component: Cleanse.RootComponent {
        typealias Root = PropertyInjector<GamePresenterTests>
        static func configure(binder: Binder<Singleton>) {
            binder.include(module: FakeGetGameLocalDataSource.Module.self)
            binder.include(module: FakeGetGameRemoteDataSource.Module.self)
            binder.include(module: GameTransformer.Module.self)
        }
        static func configureRoot(binder bind: ReceiptBinder<PropertyInjector<GamePresenterTests>>) -> BindingReceipt<PropertyInjector<GamePresenterTests>> {
            return bind.propertyInjector { (bind) ->
                BindingReceipt<PropertyInjector<GamePresenterTests>> in
                return bind.to(injector: GamePresenterTests.injectProperties)
            }
        }
    }
    
}
