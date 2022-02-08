//
//  TestViewController.swift
//  FunctionList_Swift
//
//  Created by leeyeon2 on 2022/02/08.
//

import UIKit

class TestViewController: UIViewController {

    @IBOutlet weak var schemeBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        schemeBtn.layer.cornerRadius = 15
    }


    @IBAction func schemeTest(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected == true{
            schemeBtn.setBackgroundColor(.systemYellow, for: .normal)
            schemeBtn.layer.cornerRadius = 15
        }else{
            schemeBtn.setBackgroundColor(.lightGray, for: .normal)
            
            schemeBtn.layer.cornerRadius = 15
        }
        //스키마명을 사용해 외부앱 실행 실시 [사용가능한 url 확인]
        //        let _url = "sms://01090253394"
        //        let _url = "kakaotalk:"
        let _url = "kakaotalk:"
        
        if let openApp = URL(string: _url), UIApplication.shared.canOpenURL(openApp) {
            // 버전별 처리 실시
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(openApp, options: [:], completionHandler: nil)
            }
            else {
                UIApplication.shared.openURL(openApp)
            }
        }
        //스키마명을 사용해 외부앱 실행이 불가능한 경우
        else {
            print("[goDeviceApp : 디바이스 외부 앱 열기 실패]")
            print("링크 주소 : \(_url)")
        }
    }
    
}

