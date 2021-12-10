//
//  ViewController.swift
//  DelegatePattern_Swift
//
//  Created by leeyeon2 on 2021/07/25.
//

import UIKit
import FirebaseCrashlytics

//2. 델리게이트 채택
class AViewController: UIViewController, BViewControllerDelegate, Storyboarded{
    
    @IBOutlet weak var messageFromBVCLabel: UILabel!
    @IBOutlet weak var modelLabel: UILabel!
    
    weak var coordinator: MainCoordinator?
    var containerValue: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //objC ? 은 삼항 연자
        //        res = (questionMark) ? "Yes" : "No";
        var questionMark: Bool = true
        var res: String
        
        if(questionMark) {
            res = "Yes"
        } else {
            res = "No"
        }
        
        //현재 function 확인
        print("func : \(#function)")
        print("line : \(#line)")
        print("file : \(#file)")
        print("file Name : \(#fileID)")
        
        //현재 VC 확인
        print(String(describing: AViewController.self))
        print(String(describing: type(of: self)))
        
        //현재 device model 확인
        modelLabel.text = deviceModelName()
        
        //description
        let arr: [String] = ["Sam", "John", "Kevin", "William"]
        let arrValue = arr.map({$0.description})
        print("array 그냥 출력 : ", arr)
        print("array description 출력 : ", arrValue)
        
        
        // Set int_key to 100.
        Crashlytics.crashlytics().setCustomValue(100, forKey: "int_key")

        // Set str_key to "hello".
        Crashlytics.crashlytics().setCustomValue("hello", forKey: "str_key")
        
        let keysAndValues = [
                         "string key" : "string value",
                         "string key 2" : "string value 2",
                         "boolean key" : true,
                         "boolean key 2" : false,
                         "float key" : 1.01,
                         "float key 2" : 2.02
                        ] as [String : Any]

        Crashlytics.crashlytics().setCustomKeysAndValues(keysAndValues)
        Crashlytics.crashlytics().setUserID("123456789")
    }
    
    
    
    @IBAction func crashButtonTapped(_ sender: Any) {
        fatalError()
    }
    
    //ContainerView 의 ViewDidLoad보다 먼저 실행
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "embedContainer" {
            let containerVC = segue.destination as! ContainerViewController
            containerVC.testStr = "Value from Prepare: \(containerValue)"
        }
    }
    
    
    // childView로 값 보냄
    @IBAction func changeContainerValue(_ sender: Any) {
        containerValue += 1
        let CVC = children.last as! ContainerViewController
        CVC.ChangeLabel(labelToChange: containerValue)
    }
    
    // childView에서 값 받아옴
    func dataFromContainer(containerData : String){
        messageFromBVCLabel.text = "Value From Children : \(containerData)"
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
    func sendMessage(message: String){
        messageFromBVCLabel.text = message
    }
    
    // Coordicate Pattern Test
    @IBAction func coordinateTest(_ sender: Any) {
        self.coordinator?.pushSecondVC()
    }
    
    
    @IBAction func showXibVC(_ sender: Any) {
        let xibVC = XibViewController(nibName: "XibViewController", bundle: Bundle(for: XibViewController.self))
        self.present(xibVC, animated: true, completion: nil)
    }
    
}

func deviceModelName() -> String? {
    var modelName = ProcessInfo.processInfo.environment["SIMULATOR_DEVICE_NAME"]
    //    if modelName!.count > 0 {
    //        return modelName
    //    }
    let device = UIDevice.current
    let selName = "_\("deviceInfo")ForKey:"
    let selector = NSSelectorFromString(selName)
    
    if device.responds(to: selector) {
        modelName = String(describing: device.perform(selector, with: "marketing-name"))
    }
    return modelName
}
