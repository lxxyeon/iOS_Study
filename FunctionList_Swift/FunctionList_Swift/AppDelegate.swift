//
//  AppDelegate.swift
//  FunctionList_Swift
//
//  Created by leeyeon2 on 2021/08/10.
//

import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var mainCoodinator: MainCoordinator?
    
    
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        print("called")
        
        guard userActivity.activityType == NSUserActivityTypeBrowsingWeb,
            let incomingURL = userActivity.webpageURL,
            let components = NSURLComponents(url: incomingURL, resolvingAgainstBaseURL: true),
            let path = components.path else {
                return false
        }
        let params = components.queryItems ?? [URLQueryItem]()

        print("path = \(incomingURL)")
        print("params = \(params)")
        
        return true
    }
    
//    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
//        guard let components = NSURLComponents(url: url, resolvingAgainstBaseURL: true),
//              let path = components.path,
//              let params = components.queryItems else {
//                  return false
//              }
//        guard path == nil else {
//            return false
//        }
//
//        if let value = params.first(where: { $0.name == "scene" })?.value {
//            return true
//        } else {
//            print("index missing")
//            return false
//        }
//    }
//
//
//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        // Override point for customization after application launch.
//        FirebaseApp.configure()
//
//        if #available(iOS 13, *) {
//            print("set in SceneDelegate")
//        } else {
//
//            let window = UIWindow(frame: UIScreen.main.bounds)
//
//            mainCoodinator = MainCoordinator(window: window)
//            mainCoodinator?.start()
//
////            window.rootViewController = AViewController()
////            self.window = window
////            window.makeKeyAndVisible()
//
//        }

//        let navigationController = UINavigationController()
//
//        // coodinator 인스턴스 생성
//        mainCoodinator = MainCoordinator(navigationController: navigationController)
//        // coodinator로 첫 화면 열기
//        mainCoodinator?.start()
//
//        window = UIWindow(frame: UIScreen.main.bounds)
//        window?.rootViewController = navigationController
//        window?.makeKeyAndVisible()
//        return true
//    }
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // MainCoordinator로 첫 화면 시작
        let navController = UINavigationController()

        mainCoodinator = MainCoordinator(navigationController: navController)
        mainCoodinator?.start()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navController
        window?.makeKeyAndVisible()

        return true
    }
    
    
    // MARK: UISceneSession Lifecycle
//
//    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
//        // Called when a new scene session is being created.
//        // Use this method to select a configuration to create the new scene with.
//        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
//    }
//
//    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
//        // Called when the user discards a scene session.
//        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
//        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
//    }
//
//
}

