//
//  ViewController.swift
//  DelegatePattern_Swift
//
//  Created by leeyeon2 on 2021/07/25.
//

import UIKit
//2. 델리게이트 채택
class AViewController: UIViewController, BViewControllerDelegate{

    @IBOutlet weak var messageFromBVCLabel: UILabel!
    @IBOutlet weak var modelLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(String(describing: AViewController.self))
        print(String(describing: type(of: self)))
        modelLabel.text = deviceModelName()
    }
    
    @IBAction func showBVC(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let bVC: BViewController = storyboard.instantiateViewController(withIdentifier: "BViewController") as! BViewController
        bVC.modalPresentationStyle = .fullScreen
        self.present(bVC, animated: true, completion: nil)
        //3. 위임자 설정!!
        bVC.delegate = self
    }
    
    // 델리게이트 메소드
//    func sendMessage(message: String){
//        messageFromBVCLabel.text = message
//    }

    
    @IBAction func showXibVC(_ sender: Any) {
        let xibVC = XibViewController(nibName: "XibViewController", bundle: Bundle(for: XibViewController.self))
        self.present(xibVC, animated: true, completion: nil)
    }
    
}

func deviceModelName() -> String? {
    var modelName = ProcessInfo.processInfo.environment["SIMULATOR_DEVICE_NAME"]
    if modelName!.count > 0 {
        return modelName
    }
    let device = UIDevice.current
    let selName = "_\("deviceInfo")ForKey:"
    let selector = NSSelectorFromString(selName)
    
    if device.responds(to: selector) {
        modelName = String(describing: device.perform(selector, with: "marketing-name"))
    }
    return modelName
}
