//
//  AppComponent.swift
//  gamebook
//
//  Created by Abdul Chathil on 11/3/20.
//  Copyright © 2020 Abdul Chathil. All rights reserved.
//

import Cleanse
import UIKit
import Games

struct AppComponent: Cleanse.RootComponent {
    typealias Root = PropertyInjector<SceneDelegate>
    typealias Seed = UIScene
    
    static func configure(binder: Binder<Singleton>) {
        binder.include(module: CoreAppModule.self)
        binder.include(module: RootWindowModule.self)
        binder.include(module: GamesPresenter.Module.self)
//        binder.include(module: FavoriteGamesPresenter.Module.self)
    }

    static func configureRoot(
        binder bind: ReceiptBinder<PropertyInjector<SceneDelegate>>
    ) -> BindingReceipt<PropertyInjector<SceneDelegate>> {
        print("Root Configuration")
        return bind.propertyInjector { (bind) -> BindingReceipt<PropertyInjector<SceneDelegate>> in
            print("Root Configuration Inject")
            return bind.to(injector: SceneDelegate.injectProperties)
        }
    }
}

struct CoreAppModule: Cleanse.Module {
    static func configure(binder: Binder<Singleton>) {
        binder.include(module: FoundationCommonModule.self)
    }
}
