//
//  CommonModules.swift
//  gamebook
//
//  Created by Abdul Chathil on 11/3/20.
//  Copyright © 2020 Abdul Chathil. All rights reserved.
//

import Foundation
import Cleanse
import SwiftUI

struct FoundationCommonModule: Module {
    static func configure(binder: Binder<Singleton>) {
        binder
            .bind(ProcessInfo.self)
            .to { ProcessInfo.processInfo }
    }
}

struct RootWindowModule: Cleanse.Module {
    static func configure(binder: Binder<Singleton>) {
        binder.include(module: HomeInteractor.Module.self)
        binder
            .bind(UIWindow.self)
            .to { (rootViewController: TaggedProvider<UIViewController.Root>, scene: UIScene) -> UIWindow in
                guard let windowScene = scene as? UIWindowScene else {
                    fatalError()
                }
                let window = UIWindow(windowScene: windowScene)
                window.rootViewController = rootViewController.get()
                return window
            }
        
        binder
            .bind()
            .tagged(with: UIViewController.Root.self)
            .to { (homeInteractor: Provider<HomeInteractor>, homeRouter: Provider<HomeRouter>) -> UIViewController in
                let contentView = ContentView(homePresenter: HomePresenter(
                    homeUseCase: homeInteractor.get(),
                    homeRouter: homeRouter.get()
                ))
                    .environmentObject(User.fakeUser)
                return UIHostingController(rootView: contentView)
            }
    }
}

extension UIViewController {
    public struct Root: Tag {
        public typealias Element = UIViewController
    }
}
