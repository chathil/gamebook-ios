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

final class GetGamesRepositoryTests: XCTestCase {
    private var cancellables: Set<AnyCancellable> = []
    
    private var repository: GetGamesRepository<FakeGetGamesLocalDataSource, FakeGetGamesRemoteDataSource, GamesTransformer<GameTransformer>>?
    
    override func setUp() {
        cancellables = []
        let propertyInjector = try?
            ComponentFactory.of(GetGamesRepositoryTests.Component.self).build(())
        propertyInjector?.injectProperties(into: self)
        precondition(repository != nil)
    }
    
    func testExecute() {
        repository?.execute(request: nil)
            .sink(receiveCompletion: { _ in }, receiveValue: {
                expect($0[0].id) == GameResponse.fakeGame.id
            }).store(in: &cancellables)
    }
    
    func testExecuteWithRequest() {
        repository?.execute(request: "whatever")
            .sink(receiveCompletion: { _ in }, receiveValue: {
                expect($0[0].id) == GameResponse.fakeGame.id
            }).store(in: &cancellables)
    }
}

extension GetGamesRepositoryTests {
    func injectProperties(_ fakeLocal: FakeGetGamesLocalDataSource, fakeRemote: FakeGetGamesRemoteDataSource, mapper: GamesTransformer<GameTransformer>) {
        self.repository = GetGamesRepository(localDataSource: fakeLocal, remoteDataSource: fakeRemote, mapper: mapper)
    }
    
    struct Component: Cleanse.RootComponent {
        typealias Root = PropertyInjector<GetGamesRepositoryTests>
        static func configure(binder: Binder<Singleton>) {
            binder.include(module: FakeGetGamesLocalDataSource.Module.self)
            binder.include(module: FakeGetGamesRemoteDataSource.Module.self)
            binder.include(module: GamesTransformer<GameTransformer>.Module.self)
        }
        
        static func configureRoot(binder bind: ReceiptBinder<PropertyInjector<GetGamesRepositoryTests>>) -> BindingReceipt<PropertyInjector<GetGamesRepositoryTests>> {
            return bind.propertyInjector { (bind) ->
                BindingReceipt<PropertyInjector<GetGamesRepositoryTests>> in
                return bind.to(injector: GetGamesRepositoryTests.injectProperties)
            }
        }
        
    }
}
