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

final class GetGameRepositoryTests: XCTestCase {
    private var cancellables: Set<AnyCancellable> = []
    
    private var repository: GetGameRepository<FakeGetGameLocalDataSource, FakeGetGameRemoteDataSource, GameTransformer>?
    
    override func setUp() {
        cancellables = []
        let propertyInjector = try? ComponentFactory.of(GetGameRepositoryTests.Component.self).build(())
        propertyInjector?.injectProperties(into: self)
        precondition(repository != nil)
    }
    
    func testExecute() {
        repository?.execute(request: GameResponse.fakeGame.id).sink(receiveCompletion: { _ in }, receiveValue: {
            expect($0.id) == GameResponse.fakeGame.id
        }).store(in: &cancellables)
    }
    func testExecuteWithoutIdError() {
        expect {
            self.repository?.execute(request: nil).sink(receiveCompletion: { _ in }, receiveValue: {
                expect($0.id) == GameResponse.fakeGame.id
            }).store(in: &self.cancellables)
        }.toEventually(throwAssertion())
    }
    
}

extension GetGameRepositoryTests {
    func injectProperties(_ localDataSource: FakeGetGameLocalDataSource, _ remoteDataSource: FakeGetGameRemoteDataSource, _ mapper: GameTransformer) {
        self.repository = GetGameRepository(localDataSource: localDataSource, remoteDataSource: remoteDataSource, mapper: mapper)
    }
    struct Component: Cleanse.RootComponent {
        typealias Root = PropertyInjector<GetGameRepositoryTests>
        static func configure(binder: Binder<Singleton>) {
            binder.include(module: FakeGetGameLocalDataSource.Module.self)
            binder.include(module: FakeGetGameRemoteDataSource.Module.self)
            binder.include(module: GameTransformer.Module.self)
        }
        static func configureRoot(binder bind: ReceiptBinder<PropertyInjector<GetGameRepositoryTests>>) -> BindingReceipt<PropertyInjector<GetGameRepositoryTests>> {
            return bind.propertyInjector { (bind) ->
                BindingReceipt<PropertyInjector<GetGameRepositoryTests>> in
                return bind.to(injector: GetGameRepositoryTests.injectProperties)
            }
        }
    }
}
