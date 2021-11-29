//
//  ContainerViewController.swift
//  FunctionList_Swift
//
//  Created by leeyeon2 on 2021/11/23.
//

import UIKit
import WebKit

class ContainerViewController: UIViewController, WKNavigationDelegate {
    
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    @IBOutlet weak var testLabel: UILabel!
    @IBOutlet weak var webView: WKWebView!
    var testStr: String?
    var valueFromParent: Int = 1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.testLabel.text = testStr
        //이거 해줘야지 상속받은 메소드들 적용 가능
        self.webView.navigationDelegate = self
        let url : URL! = URL(string: "https://www.google.com/")
        let request = URLRequest(url: url)
        self.webView.load(request)
    }
    
    func ChangeLabel(labelToChange : Int){
        self.testLabel.text = "Value from Parent : \(labelToChange)"
    }
    
    // parentVC에 값 전달
    @IBAction func sendDataToVc(_ sender: Any) {
        valueFromParent += 1
        let Avc = parent as! AViewController
        let myString = "\(valueFromParent)"
        Avc.dataFromContainer(containerData: myString)
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        indicatorView.isHidden = false
        indicatorView.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        indicatorView.stopAnimating()
        indicatorView.isHidden = true
    }

}
