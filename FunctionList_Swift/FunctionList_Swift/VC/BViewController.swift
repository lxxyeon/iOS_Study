//
//  BViewController.swift
//  DelegatePattern_Swift
//
//  Created by leeyeon2 on 2021/07/25.
//

import UIKit
import Foundation
//1. 델리게이트 프로토콜, 프로퍼티 생성
@objc protocol BViewControllerDelegate {
    @objc optional func sendMessage(message: String)
}

@objc class BViewController: UIViewController, Storyboarded {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageField: UILabel!

    var delegate: BViewControllerDelegate?
    weak var coordinator: SecondViewCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func dismissBVC(_ sender: Any) {
        //3. 델리게이트 메소드 호출

        if((self.delegate) != nil){
            if let method = self.delegate?.sendMessage?(message: messageField.text!){
                method
            }
//            else{
//                return
//            }
//            method
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func setNavigationTitle(title: String) {
        titleLabel.text = title
    }
}
