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

      // Log that the view did load, CLSNSLogv is used here so the log message will be
      // shown in the console output. If CLSLogv is used the message is not shown in
      // the console output.
      Crashlytics.crashlytics().log("View loaded")

      Crashlytics.crashlytics().setCustomValue(42, forKey: "MeaningOfLife")
      Crashlytics.crashlytics().setCustomValue("Test value", forKey: "last_UI_action")
      
      let customKeysObject = [
        "locale" : getLocale(),
        "network_connection": getNetworkStatus(),
      ] as [String: Any]
      Crashlytics.crashlytics().setCustomKeysAndValues(customKeysObject)
      
      updateAndTrackNetworkStatus()
      
      Crashlytics.crashlytics().setUserID("1004")

      let userInfo = [
        NSLocalizedDescriptionKey: NSLocalizedString("The request failed.", comment: ""),
        NSLocalizedFailureReasonErrorKey: NSLocalizedString("The response returned a 404.", comment: ""),
        NSLocalizedRecoverySuggestionErrorKey: NSLocalizedString("Does this page exist?", comment:""),
        "ProductID": "123456",
        "UserID": "Leeyeon"
      ]
      let error = NSError(domain: NSURLErrorDomain, code: -1001, userInfo: userInfo)
      Crashlytics.crashlytics().record(error: error)
    }

    @IBAction func initiateCrash(_ sender: AnyObject) {
      // [START log_and_crash_swift]
      Crashlytics.crashlytics().log("Cause Crash button clicked")
      fatalError()
      // [END log_and_crash_swift]
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
