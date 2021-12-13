//
//  AppInfo.swift
//  FunctionList_Swift
//
//  Created by leeyeon2 on 2021/12/13.
//
import UIKit
//import Appsee
import Firebase
import FirebaseCrashlytics
import Reachability


class AppInfo{
    //shared: 타입 프로퍼티
    static let shared: AppInfo = AppInfo()
    
    
    func logAppseeUserId() {
//        Crashlytics.crashlytics().setUserID("appdelegateID22")
//        let customKeysObject = [
//            "locale" : getLocale(),
//            "network_connection": getNetworkStatus(),
//        ] as [String: Any]
//        Crashlytics.crashlytics().setCustomKeysAndValues(customKeysObject)
    }
    
    /**
     * Retrieve the locale information for the app.
     */
    func getLocale() -> String {
        return Locale.preferredLanguages[0]
    }
    
    /**
     * Retrieve the network status for the app.
     */
    func getNetworkStatus() -> String {
        guard let reachability = try? Reachability() else {
            return "unknown"
        }
        switch reachability.connection {
        case .wifi:
            return "wifi"
        case .cellular:
            return "cellular"
        case .unavailable:
            return "unavailable"
        case .none:
            // Duplicate of unavailable.
            return "unavailable"
        }
    }

}
