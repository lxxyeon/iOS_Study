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
    
    func ChangeLabel(labelToChange : Int){
        self.testLabel.text = "Value : \(labelToChange)"
    }
    
    // parentVC에 값 전달
    @IBAction func sendDataToVc(_ sender: Any) {
        let Avc = parent as! AViewController
        let myString = "Message From Container View"
        Avc.dataFromContainer(containerData: myString)
    }

}
