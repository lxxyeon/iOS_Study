//
//  PopUpVC.swift
//  FunctionList_Swift
//
//  Created by leeyeon2 on 2022/02/13.
//

import UIKit

class PopUpVC: UIViewController {
    
    
    @IBOutlet weak var infoView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // shadow 적용하기 위한 containerView
        let containerView = UIView()
        containerView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        containerView.layer.shadowOffset = CGSize(width: 1, height: 4)
        containerView.layer.shadowRadius = 10
        containerView.layer.shadowOpacity = 1
        containerView.addSubview(infoView)
        
        // infoView 모서리 둥글게 만들기
        infoView.layer.cornerRadius = 25
        infoView.clipsToBounds = true
        view.addSubview(containerView)
        
        // containerView 에 대해 Auto Layout 설정
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -10).isActive = true
        containerView.widthAnchor.constraint(equalToConstant: 315).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 367).isActive = true
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
}
