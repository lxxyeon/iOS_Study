//
//  SceneDelegate.swift
//  FunctionList_Swift
//
//  Created by leeyeon2 on 2021/08/10.
//

import UIKit
import GoogleSignIn

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    var appCoordinator: MainCoordinator?
    func scene(_ scene: UIScene, continue userActivity: NSUserActivity) {
        guard userActivity.activityType == NSUserActivityTypeBrowsingWeb,
            let incomingURL = userActivity.webpageURL,
            let components = NSURLComponents(url: incomingURL, resolvingAgainstBaseURL: true),
            let path = components.path else {
                return
        }
        let params = components.queryItems ?? [URLQueryItem]()

        print("path = \(incomingURL)")
        print("params = \(params)")
        // ...
    }

    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        //google SignIn
        guard let scheme = URLContexts.first?.url.scheme else { return }
        if scheme.contains("com.googleusercontent.apps") {
            GIDSignIn.sharedInstance.handle(URLContexts.first!.url)
        }
    }
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
//        // 1
//        guard let windowScene = (scene as? UIWindowScene) else { return }
//
//
//        // 2
//        let appWindow = UIWindow(frame: windowScene.coordinateSpace.bounds)
//        appWindow.windowScene = windowScene
//
//        // 3
//        let navController = UINavigationController()
//        appCoordinator = MainCoordinator(navigationController: navController)
//        appCoordinator.start()
        
//        guard let windowScene = (scene as? UIWindowScene) else { return }
//
//        let navController = UINavigationController()
//        appCoordinator = MainCoordinator(navigationController: navController)
//        appCoordinator?.start()
        
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
//            window.rootViewController = AViewController()
//            window.rootViewController = FirebaseViewController()
            window.rootViewController = FuncTableViewController()
            self.window = window
            window.makeKeyAndVisible()
        }
        
        guard let _ = (scene as? UIWindowScene) else { return }

//
//        window = UIWindow(frame: UIScreen.main.bounds)
//
//        let rootNavController = UINavigationController()
//        appCoordinator = MainCoordinator(navigationController: rootNavController)
//        appCoordinator?.start()
//
//        window?.rootViewController = rootNavController
//        window?.makeKeyAndVisible()
        
//        guard let windowScene = (scene as? UIWindowScene) else { return }
        
//        let appWindow = UIWindow(frame: windowScene.coordinateSpace.bounds)
//        appWindow.windowScene = windowScene
//        appWindow.rootViewController = navController
//        appWindow.makeKeyAndVisible()
//
//        self.window = appWindow
//
        
        
        
//        // 4
//        appWindow.rootViewController = navController
//        appWindow.makeKeyAndVisible()
//
//        // 5
//        window = appWindow
        
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
    
}

