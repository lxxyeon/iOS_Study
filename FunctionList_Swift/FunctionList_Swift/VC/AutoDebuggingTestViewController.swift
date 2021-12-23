//
//  AutoDebuggingTestViewController.swift
//  DelegatePattern_Swift
//
//  Created by leeyeon2 on 2021/07/25.
//

import UIKit

class AutoDebuggingTestViewController: UIViewController {

    @IBOutlet weak var label1: UILabel!

    @IBOutlet weak var brightnessValue: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        label1.text = "라벨"
        // Do any additional setup after loading the view.
    }
    
    //화면 밝기 조절
    @IBAction func brightnessChange(_ sender: UISlider) {
        let brightness = sender.value
      
        let screen = UIScreen.main
        screen.brightness = CGFloat(brightness)
        //현재 밝기 출력
        brightnessValue.text = "brightnessValue : \(Int(screen.brightness*100))%"
    }

    //화면 꺼짐 방지
    @IBAction func keepScreenOn(_ sender: UISwitch) {
        let keepScreenOn = sender.isOn
        UIApplication.shared.isIdleTimerDisabled = keepScreenOn
    }
    
}
