//
//  BViewController.swift
//  DelegatePattern_Swift
//
//  Created by leeyeon2 on 2021/07/25.
//

import UIKit
//1. 델리게이트 프로토콜, 프로퍼티 생성
protocol BViewControllerDelegate {
    func sendMessage(message: String)
}

class BViewController: UIViewController {

    var delegate: BViewControllerDelegate?
    @IBOutlet weak var messageField: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func dismissBVC(_ sender: Any) {
        //3. 델리게이트 메소드 호출
        self.delegate?.sendMessage(message: messageField.text!)
        self.dismiss(animated: true, completion: nil)
    }
    
}
