//
//  TestingScnenDelegate.swift
//  DelegatePattern_SwiftTests
//
//  Created by leeyeon2 on 2021/08/04.
//

import UIKit

class TestingSceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = UIViewController()
        window?.makeKeyAndVisible()
    }
}
