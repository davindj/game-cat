//
//  SceneDelegate.swift
//  Game Cat
//
//  Created by Davin Djayadi on 18/09/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        let tabvc = MainTabBarController()
        window?.rootViewController = tabvc
        window?.makeKeyAndVisible()
    }
}
