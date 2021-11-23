//
//  ContainerViewController.swift
//  FunctionList_Swift
//
//  Created by leeyeon2 on 2021/11/23.
//

import UIKit

class ContainerViewController: UIViewController {

    @IBOutlet weak var testLabel: UILabel!
    
    var testStr: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.testLabel.text = testStr
    }
    

}
