//
//  AutoDebuggingTestViewController.swift
//  DelegatePattern_Swift
//
//  Created by leeyeon2 on 2021/07/25.
//

import UIKit
import AVFoundation

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
    
    //카메라 플래시 제어
    func toggleFlash() {
        //디바이스 정보 가져오기
        guard let device = AVCaptureDevice.default(for: AVMediaType.video) else { return }
        //플래시를 지원한다면
        guard device.hasTorch else { return }

        do {
            try device.lockForConfiguration()

            if (device.torchMode == AVCaptureDevice.TorchMode.on) {
                device.torchMode = AVCaptureDevice.TorchMode.off
            } else {
                do {
                    try device.setTorchModeOn(level: 1.0)
                } catch {
                    print(error)
                }
            }

            device.unlockForConfiguration()
        } catch {
            print(error)
        }
    }
}
