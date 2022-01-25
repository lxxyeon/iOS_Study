//
//  httpNetworkManagerViewController.swift
//  FunctionList_Swift
//
//  Created by leeyeon2 on 2022/01/10.
//

import UIKit
import Alamofire
import GoogleSignIn

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
                //                self.setInfo(by: userData)
            case .failure(let error):
                print("Error", error.localizedDescription)
                self.setError()
            }
        }
    }
    
    //    private func setInfo(by data: UserData) {
    //        resultLabel.text = """
    //                               ID: \(data.id)\n
    //                               Title: \(data.title)\n
    //                               UserId: \(data.userId)\n
    //                               Body: \(data.body)\n
    //                              """
    //    }
    //
    private func setError() {
        resultLabel.text = """
                               ID: Error\n
                               Title: Error\n
                               UserId: Error\n
                               Body: Error\n
                              """
        
    }
    
    
    @IBAction func signInApple(_ sender: Any) {
    }
    
    
    @IBAction func signInGoogle(_ sender: Any) {
        // OAuth 2.0 클라이언트 ID
        let signInConfig = GIDConfiguration.init(clientID: "895762202310-eerandoqatibn3hmlr62lmi7jejo7jqn.apps.googleusercontent.com")
        GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: self) { user, error in
          guard error == nil else { return }
            guard let user = user else { return }
            
            // 사용자 정보
            let userId = user.userID
            let idToken = user.authentication.idToken
//            let fullName = user.profile.name
//            let givenName = user.profile.givenName
//            let familyName = user.profile.familyName
//            let email = user.profile.email

            guard let accessToken = user.authentication.idToken, let _ = user.profile?.name else {
                        print("Error : User Data Not Found"); return }
            
            
            // google login post
            print("Google accessToken : \(accessToken)")

        }
    }
    
    //구글 버튼 설정
    func setGoogleSignInButton(){
//        GIDSignIn.sharedInstance()?.presentingViewController = self
//        GIDSignIn.sharedInstance().delegate = self
//        googleSignInButton.style = .standard // .wide .iconOnly
    }
    
}

extension HttpNetworkManagerViewController {
    @IBAction private func created(_ sender: UIButton) {
        guard let url = URL(string: "https://3.38.165.81:80") else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    //CREAT TEST
    @IBAction private func CREATE(_ sender: UIButton) {
        
    }
    
    //GET TEST
    @IBAction private func GET1(_ sender: UIButton) {
        API.shared.getAPI()
    }
    
    //POST TEST
    @IBAction private func POST(_ sender: UIButton) {
        API.shared.postAPI()
    }
    
    //PUT TEST
    @IBAction private func PUT(_ sender: UIButton) {
        API.shared.put(completionHandler: handler)
    }
    
    //DELETE TEST
    @IBAction private func DELETE(_ sender: UIButton) {
        
    }
}
