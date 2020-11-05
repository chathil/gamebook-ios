//
//  SceneDelegate.swift
//  fundamental-sub-one
//
//  Created by Abdul Chathil on 7/2/20.
//  Copyright © 2020 Abdul Chathil. All rights reserved.
//

import UIKit
import Cleanse

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        let propertyInjector = try? ComponentFactory.of(AppComponent.self).build((scene))
        propertyInjector?.injectProperties(into: self)
        precondition(window != nil)
        window!.makeKeyAndVisible()
    }
}

extension SceneDelegate {
    func injectProperties(_ window: UIWindow) {
        self.window = window
    }
}
