//
//  FirebaseViewController.swift
//  FunctionList_Swift
//
//  Created by leeyeon2 on 2021/12/10.
//

import UIKit
import Firebase
import FirebaseCrashlytics
import Reachability

class FirebaseViewController: UIViewController, Storyboarded {
    lazy var crashlytics = Crashlytics.crashlytics()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let list = [1, 2, 3]
        print("ddddddddddd\(list[10])") // nil
    }
    
    @IBAction func initiateCrash(_ sender: AnyObject) {
        Crashlytics.crashlytics().log("Cause Crash button clicked")
        
        //강제종료 crash 발생시키기
//        fatalError()
        
        //outofrange crash 발생시키기
        let list = [1, 2, 3]
        print("ddddddddddd\(list[10])") // nil
    }
    
    
    
    @IBAction func customError(_ sender: Any) {
        let userInfo = [
            NSLocalizedDescriptionKey: NSLocalizedString("The request failed.", comment: ""),
            NSLocalizedFailureReasonErrorKey: NSLocalizedString("The response returned a 404.", comment: ""),
            NSLocalizedRecoverySuggestionErrorKey: NSLocalizedString("Does this page exist?", comment:""),
            "ProductID": "123456",
            "UserID": "Leeyeon"
        ]
        //record 메서드로 NSError 객체를 기록하여 심각하지 않은 예외 기록
        let error = NSError(domain: NSCocoaErrorDomain, code: -1002, userInfo: userInfo)
        Crashlytics.crashlytics().record(error: error)
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
    
    /**
     * Add a hook to update network status going forward.
     */
    func updateAndTrackNetworkStatus() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(reachabilityChanged(note:)),
                                               name: .reachabilityChanged,
                                               object: nil)
        do {
            let reachability = try Reachability()
            try reachability.startNotifier()
        } catch {
            print("Could not start reachability notifier: \(error)")
        }
    }
    
    @objc func reachabilityChanged(note: Notification) {
        Crashlytics.crashlytics().setCustomValue(getNetworkStatus(), forKey: "network_connection")
    }
}
