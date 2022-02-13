//
//  TestViewController.swift
//  FunctionList_Swift
//
//  Created by leeyeon2 on 2022/02/08.
//

import UIKit
import AuthenticationServices

class TestViewController: UIViewController {
    
    @IBOutlet weak var schemeBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        schemeBtn.layer.cornerRadius = 15
        self.setupProviderLoginView()
    }
    
    @IBAction func appleSignin(_ sender: Any) {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    
    
    @IBAction func schemeTest(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected == true{
            schemeBtn.setBackgroundColor(.systemYellow, for: .normal)
            schemeBtn.layer.cornerRadius = 15
        }else{
            schemeBtn.setBackgroundColor(.lightGray, for: .normal)
            
            schemeBtn.layer.cornerRadius = 15
        }
        //스키마명을 사용해 외부앱 실행 실시 [사용가능한 url 확인]
        //        let _url = "sms://01090253394"
        //        let _url = "kakaotalk:"
        let _url = "kakaotalk:"
        
        if let openApp = URL(string: _url), UIApplication.shared.canOpenURL(openApp) {
            // 버전별 처리 실시
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(openApp, options: [:], completionHandler: nil)
            }
            else {
                UIApplication.shared.openURL(openApp)
            }
        }
        //스키마명을 사용해 외부앱 실행이 불가능한 경우
        else {
            print("[goDeviceApp : 디바이스 외부 앱 열기 실패]")
            print("링크 주소 : \(_url)")
        }
    }
    
}

extension TestViewController: ASAuthorizationControllerPresentationContextProviding, ASAuthorizationControllerDelegate{
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    
    // Apple ID 연동 성공 시
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
            // Apple ID
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            
            // 계정 정보 가져오기
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email
            let idToken = appleIDCredential.identityToken!
            let tokeStr = String(data: idToken, encoding: .utf8)
            
            print("User ID : \(userIdentifier)")
            print("User Email : \(email ?? "")")
            print("User Name : \((fullName?.givenName ?? "") + (fullName?.familyName ?? ""))")
            print("token : \(String(describing: tokeStr))")
            
            
            //userInfo 저장하기
            //토큰 확인 > 원래 서버 쪽에서
            if (String(describing: tokeStr) == "eyJraWQiOiJlWGF1bm1MIiwiYWxnIjoiUlMyNTYifQ.eyJpc3MiOiJodHRwczovL2FwcGxlaWQuYXBwbGUuY29tIiwiYXVkIjoibGVleWVvbjIuRnVuY3Rpb25MaXN0LVN3aWZ0IiwiZXhwIjoxNjQ0ODM3OTE3LCJpYXQiOjE2NDQ3NTE1MTcsInN1YiI6IjAwMTI4MS45MzAxYWFhMWY2MTc0MjNjOWM3YTY0YjY3MWI2ZWI4NC4wNzU4IiwiY19oYXNoIjoiQkR3ckxXTTFfQ3hQek10alMyQVA3QSIsImVtYWlsIjoiNXBuZzVyY3R3NEBwcml2YXRlcmVsYXkuYXBwbGVpZC5jb20iLCJlbWFpbF92ZXJpZmllZCI6InRydWUiLCJpc19wcml2YXRlX2VtYWlsIjoidHJ1ZSIsImF1dGhfdGltZSI6MTY0NDc1MTUxNywibm9uY2Vfc3VwcG9ydGVkIjp0cnVlfQ.WnfKQ2QlnxUUkB2_ighqCcEChADdBFXnsHEknLR9lqUa2uMk3ybym378uIcV-c8Vm-_e7lQgG_oUyfWV8M2ialgJtWcvPJcy0FqrtaaE0vqG44IZMXkDT-O7REYV8fadkGtaoZGQyb2NkmZ40V4aFs0sJxbg5GO4LHgXMDU4PTfgjsk9k2IXQA6kyt5tYpWfbu8D_m58i9emFF6SfmHfFYnxRMPm-K6qCgmingY3nNMYlt2BkB5EfPwOn7qTVEmz-FwDr-CErE1Ijp3DuQlM403NAGsy5ySLXrEiymh0KTb3wqduqKhPXuV7nHZyyLUaD7kvTCGbBTjQzXTJvglPTw"){
                
                UserDefaults.standard.set("이연", forKey: "name")
                UserDefaults.standard.set("leeyeon", forKey: "id")
                UserDefaults.standard.set("PASSWORD", forKey: "pw")
                
                
                let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
                let popupVC = storyBoard.instantiateViewController(withIdentifier: "PopupVC")
                popupVC.modalPresentationStyle = .overFullScreen
                present(popupVC, animated: false, completion: nil)
            }
            
        default:
            break
        }
    }
    
    // Apple ID 연동 실패 시
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle error.
    }
    
    func setupProviderLoginView() {
        let appleButton = ASAuthorizationAppleIDButton(type: .signIn, style: .whiteOutline)
        appleButton.addTarget(self, action: #selector(handleAuthorizationAppleIDButtonPress), for: .touchUpInside)
        self.view.addSubview(appleButton)
        appleButton.translatesAutoresizingMaskIntoConstraints = false
        appleButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        appleButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        appleButton.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        appleButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
    }
    @objc func handleAuthorizationAppleIDButtonPress() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    
}
