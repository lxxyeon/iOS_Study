//
//  FuncTableViewController.swift
//  FunctionList_Swift
//
//  Created by leeyeon2 on 2021/12/14.
//

import UIKit
import AVFoundation
import CommonCrypto

class FuncTableViewController: UITableViewController, Storyboarded {
    var sha256Test = "sha256Test"
    
    var funcList: [String] = ["1. urlSchemeTest - kakao", "2. FirebaseCrashlytics", "3. StringTest", "4. screenBrightness", "5. SignInApple", "6. Vibrate", "sha256Test", "8. Alamofire"]
    let cellId: String = "cell"
    
    @IBOutlet var funcTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "FuncTableViewController"
    }
    
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return funcList.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FuncTableViewCell
        let text: String = self.funcList[indexPath.row]
        
        cell.cellTitle.text = text
        
        return cell
    }
    
    //셀선택시 실행되는 부분
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row{
            //url Scheme test
        case 0:
            self.urlSchemeTest()
            //Firebase Crashlytics
        case 1:
            self.changeView(viewID: "FirebaseCrashlytics")
            //StringTest
        case 2:
            self.StringTest()
            //screenBrightness
        case 3:
            self.changeView(viewID: "TestView")
            //Apple SignIn
        case 4:
            self.changeView(viewID: "SignInAppleVC")
            //vibrate
        case 5:
            UIDevice.vibrate()
            //SHA256
        case 6:
            print("SHA256 해싱 이전 값 : \(sha256Test)")
            sha256Test = sha256Test.sha256()
            funcTableView.reloadData()
            print("SHA256 해싱 이후 값 : \(sha256Test)")
            //Alamofire
        case 7:
            self.changeView(viewID: "httpNetworkVC")
            
        default:
            break
        }
    }
    
    // [외부 앱 실행 실시]
    /*
     1. tel , mailto , sms , link 등을 사용해 디바이스 외부 앱을 수행할 수 있습니다
     2. 전화 걸기 : tel:010-1234-5678
     3. 메일 보내기 : mailto:honggildung@test.com
     4. 문자 보내기 : sms:010-5678-1234
     5. 링크 이동 : https://naver.com
     */
    func urlSchemeTest() {
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
    
    func StringTest() {
//        let testString: String = "  "
//        print("test : \(testString.isEmpty)")
        
        //문자열 표현
        let charachers: [Character] = ["T","E","S","T","!"]
        let charString = String(charachers)
        print(charString) //TEST!
        
        //문자열 찾기
        //G
        print(charString[charString.startIndex])
        //!
        print(charString[charString.index(before: charString.endIndex)])
        //E
        print(charString[charString.index(after: charString.startIndex)])
        
        let index = charString.index(charString.startIndex, offsetBy: 4)
        //!
        print(charString[index])
        
        //스위피트 문자열 비교는 == 사용
    }
    
    func changeView(viewID : String) {
        self.performSegue(withIdentifier: viewID, sender: nil)
    }

}

// MARK: - [extension 정의 실시 : UIDevice, Data, String]
extension UIDevice {
    // [설명 : 디바이스 진동 기능 수행 메소드]
    // [필요 import : import AVFoundation]
    // [사용 방법 : UIDevice.vibrate()]
    //단발성
    static func vibrate() {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
    }
}

extension Data{
    public func sha256() -> String{
        return hexStringFromData(input: digest(input: self as NSData))
    }
    
    private func digest(input : NSData) -> NSData {
        let digestLength = Int(CC_SHA256_DIGEST_LENGTH)
        var hash = [UInt8](repeating: 0, count: digestLength)
        CC_SHA256(input.bytes, UInt32(input.length), &hash)
        return NSData(bytes: hash, length: digestLength)
    }
    
    private  func hexStringFromData(input: NSData) -> String {
        var bytes = [UInt8](repeating: 0, count: input.length)
        input.getBytes(&bytes, length: input.length)
        
        var hexString = ""
        for byte in bytes {
            hexString += String(format:"%02x", UInt8(byte))
        }
        
        return hexString
    }
}

public extension String {
    func sha256() -> String{
        if let stringData = self.data(using: String.Encoding.utf8) {
            return stringData.sha256()
        }
        return ""
    }
}
