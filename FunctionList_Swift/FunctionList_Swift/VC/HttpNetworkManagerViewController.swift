//
//  httpNetworkManagerViewController.swift
//  FunctionList_Swift
//
//  Created by leeyeon2 on 2022/01/10.
//

import UIKit
import Alamofire

// Alamofire 사용해서 Network 통신하기
class HttpNetworkManagerViewController: UIViewController {
    
    private var handler: ((Result<[UserData], Error>) -> Void)!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        handler = { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let userDatas):
                guard let userData = userDatas.first else { return }
                self.setInfo(by: userData)
            case .failure(let error):
                print("Error", error.localizedDescription)
                self.setError()
            }
        }
    }
    
    private func setInfo(by data: UserData) {
        resultLabel.text = """
                               ID: \(data.id)\n
                               Title: \(data.title)\n
                               UserId: \(data.userId)\n
                               Body: \(data.body)\n
                              """
    }
    
    private func setError() {
        resultLabel.text = """
                               ID: Error\n
                               Title: Error\n
                               UserId: Error\n
                               Body: Error\n
                              """
        
    }
}

extension HttpNetworkManagerViewController {
    @IBAction private func created(_ sender: UIButton) {
        guard let url = URL(string: "https://3.38.165.81:80") else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    @IBAction private func GET1(_ sender: UIButton) {
        
        print("test")
        API.shared.requestAPI("Swift", 1)
//        API.shared.get1(completionHandler: handler)
    }
    
//    @IBAction private func GET2(_ sender: UIButton) {
//        API.shared.get2(completionHandler: handler)
//    }
//    
//    @IBAction private func POST(_ sender: UIButton) {
//        API.shared.post(completionHandler: handler)
//    }
//    
//    @IBAction private func PUT(_ sender: UIButton) {
//        API.shared.put(completionHandler: handler)
//    }
//    
//    @IBAction private func PATCH(_ sender: UIButton) {
//        API.shared.patch(completionHandler: handler)
//    }
//    
//    @IBAction private func DELETE(_ sender: UIButton) {
//        API.shared.delete(completionHandler: handler)
//    }
}
