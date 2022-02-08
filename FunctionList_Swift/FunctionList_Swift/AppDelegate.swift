//
//  AppDelegate.swift
//  FunctionList_Swift
//
//  Created by leeyeon2 on 2021/08/10.
//

import UIKit
import Firebase
import FirebaseCrashlytics
import AuthenticationServices
import GoogleSignIn

let navController = UINavigationController()

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var mainCoodinator: MainCoordinator?
    
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        
        guard userActivity.activityType == NSUserActivityTypeBrowsingWeb,
              let incomingURL = userActivity.webpageURL,
              let components = NSURLComponents(url: incomingURL, resolvingAgainstBaseURL: true),
              let path = components.path else {
                  return false
              }
        let params = components.queryItems ?? [URLQueryItem]()
        
        // 3. 쿼리확인
        if let value = params.first(where: { $0.name == "scene" })?.value {
            processDeeplink(with: value)
            return true
        } else {
            print("index missing")
            return false
        }
        print("path = \(incomingURL)")
        print("params = \(params)")
        
        return true
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // MainCoordinator로 첫 화면 시작
//        mainCoodinator = MainCoordinator(navigationController: navController)
//        mainCoodinator?.start()
//        window = UIWindow(frame: UIScreen.main.bounds)
//        window?.rootViewController = navController
        //        window?.makeKeyAndVisible()
//        FirebaseApp 객체를 초기화
        FirebaseApp.configure()
        
        //applelogin 확인
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        //forUserID = userIdentifier
        appleIDProvider.getCredentialState(forUserID: "001281.9301aaa1f617423c9c7a64b671b6eb84.0758") { (credentialState, error) in
            switch credentialState {
            case .authorized:
                // The Apple ID credential is valid.
                print("해당 ID는 연동되어있습니다.")
            case .revoked:
                // The Apple ID credential is either revoked or was not found, so show the sign-in UI.
                print("해당 ID는 연동되어있지않습니다.")
            case .notFound:
                // The Apple ID credential is either was not found, so show the sign-in UI.
                print("해당 ID를 찾을 수 없습니다.")
            default:
                break
            }
        }
        
        //앱 실행 중 강제로 연결 취소 시
        NotificationCenter.default.addObserver(forName: ASAuthorizationAppleIDProvider.credentialRevokedNotification, object: nil, queue: nil) { (Notification) in
            print("Revoked Notification")
            // 로그인 페이지로 이동
        }
        
        // Google SignIn
        // OAuth 2.0 클라이언트 ID
//        GIDSignIn.sharedInstance.clientID = "[클라이언트 ID].apps.googleusercontent.com"
        return true
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        AppInfo.shared.logAppseeUserId()
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        AppInfo.shared.logAppseeUserId()
    }
    
    //SceneDelegate 삭제하면서 제거
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
    
}

// 4. 딥링크 처리 로직: 로그인이 되어있다면 홈화면을 베이스로 하며, 특정 화면으로 이동하게끔 설정
private func processDeeplink(with scene: String) {
    // TODO - token정보 가지고 로그인 판단
    //    let isLoggedIn = true
    //    if !isLoggedIn {
    //        _ = SplashCoordinator(rootViewController: navigationController, postTaskManager: postTaskManager, initialRoute: .splash)
    //        return
    //    }
    //
    //    // Home화면이 베이스가 되게끔 설정
    //    if navigationController.viewControllers.first as? HomeVC == nil {
    //        _ = HomeCoordinator(rootViewController: navigationController, postTaskManager: postTaskManager, initialRoute: .home)
    //    }
    
    switch scene {
    case "scene":
        _ = SecondViewCoordinator(navigationController: navController)
    case "card":
        break
    default:
        break
    }
}
