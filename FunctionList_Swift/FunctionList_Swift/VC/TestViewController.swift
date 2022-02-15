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
        test()
        //        schemeBtn.layer.cornerRadius = 15
        //        self.setupProviderLoginView()
    }
    
    func test(){
        let test: Int = 1
        let res = (test == 1) ? "true": "false"
        
        
        
        
//        // Int - Int8, Int16, Int32, Int64
//        // ex) Int8 - Int를 8bit크기로 사용하겠다.
//        // 일반적으로 Int는 실행되는 환경의 CPU에 맞추어 값의 범위가 변함
//        // ex) 64bit OS -> Int = Int64, 32bit OS -> Int = Int32
//        // i 가 대문자
//        var num : Int = 0;
//        var num8 : Int8 = 0;
//        var num16 : Int16 = 0;
//        var num32 : Int32 = 0;
//        var num64 : Int64 = 0;
//
//        // Int는 SignedInteger를 구현한 구조체의 일종
//        //  -> Int.init(), Int.max, Int.min 등의 변수 및 메소드들이 존재
//        var no0 : Int = Int.init(); // 0으로 초기화
//        var no1 : Int = Int.init(1); // 1로 초기화
//        print("Int   : " + String(Int.min) + " ~ " + String(Int.max));
//        print("Int8  : " + String(Int8.min) + " ~ " + String(Int8.max));
//        print("Int16 : " + String(Int16.min) + " ~ " + String(Int16.max));
//        print("Int32 : " + String(Int32.min) + " ~ " + String(Int32.max));
//        print("Int64 : " + String(Int64.min) + " ~ " + String(Int64.max));

        // UInt - UInt8, UInt16, UInt32, UInt64
        // UInt도 Int와 동일하게 실행되는 환경의 CPU에 맞추어 값의 범위가 변함
        var num : UInt = 0;
        var num8 : UInt8 = 0;
        var num16 : UInt16 = 0;
        var num32 : UInt32 = 0;
        var num64 : UInt64 = 0;

        // UInt는 UnSignedInteger를 구현한 구조체의 일종
        //  -> UInt.init(), UInt.max, UInt.min 등의 변수 및 메소드들이 존재
        var no0 : UInt = UInt.init(); // 0으로 초기화
        var no1 : UInt = UInt.init(1); // 1로 초기화
//        print("UInt   : " + String(UInt.min) + " ~ " + String(UInt.max));
//        print("UInt8  : " + String(UInt8.min) + " ~ " + String(UInt8.max));
//        print("UInt16 : " + String(UInt16.min) + " ~ " + String(UInt16.max));
//        print("UInt32 : " + String(UInt32.min) + " ~ " + String(UInt32.max));
//        print("UInt64 : " + String(UInt64.min) + " ~ " + String(UInt64.max));
        
        let float_pi : Float = 3.141592653589793238462643383279502884197169399375105820
        let double_pi : Double = 3.141592653589793238462643383279502884197169399375105820
        
        print("Float으로 표현 가능한 실수 : \(float_pi)")
        print("Double으로 표현 가능한 실수 : \(double_pi)")
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
    
    //    func setupProviderLoginView() {
    //        let appleButton = ASAuthorizationAppleIDButton(type: .signIn, style: .whiteOutline)
    //        appleButton.addTarget(self, action: #selector(handleAuthorizationAppleIDButtonPress), for: .touchUpInside)
    //        self.view.addSubview(appleButton)
    //        appleButton.translatesAutoresizingMaskIntoConstraints = false
    //        appleButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
    //        appleButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
    //        appleButton.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
    //        appleButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    //
    //    }
    //    @objc func handleAuthorizationAppleIDButtonPress() {
    //        let appleIDProvider = ASAuthorizationAppleIDProvider()
    //        let request = appleIDProvider.createRequest()
    //        request.requestedScopes = [.fullName, .email]
    //        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
    //        authorizationController.delegate = self
    //        authorizationController.presentationContextProvider = self
    //        authorizationController.performRequests()
    //    }
    
    
}
