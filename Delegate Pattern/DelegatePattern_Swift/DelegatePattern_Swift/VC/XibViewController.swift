//
//  XibViewController.swift
//  DelegatePattern_Swift
//
//  Created by leeyeon2 on 2021/07/25.
//

import UIKit

class XibViewController: UIViewController {
    
    //앱에서 사용하기 위해 public 설정
    public override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func dismissVC(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
