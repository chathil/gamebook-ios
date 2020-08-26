//
//  SceneDelegate.swift
//  fundamental-sub-one
//
//  Created by Abdul Chathil on 7/2/20.
//  Copyright © 2020 Abdul Chathil. All rights reserved.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var coreDataStack = CoreDataStack(containerName: "LikedGame")

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        let gameStore = GameStore.shared
        let homeScreen = HomeScreen().environment(\.managedObjectContext, coreDataStack.viewContext).environmentObject(GameHomeData(gameService: gameStore, context: coreDataStack.viewContext))
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: homeScreen)
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}

