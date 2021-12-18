//
//  FuncTableViewController.swift
//  FunctionList_Swift
//
//  Created by leeyeon2 on 2021/12/14.
//

import UIKit

class FuncTableViewController: UITableViewController, Storyboarded {
    
    let funcList: [String] = ["1. urlSchemeTest", "2. FirebaseCrashlytics", "3. StringTest"]
    let cellId: String = "cell"
    
    @IBOutlet var funcTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "FuncTableViewController"
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
        let _url = "FunctionList_Objc:"
        
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
        let testString: String = "  "
        print("test : \(testString.isEmpty)")
    }
    
    func changeView(viewID : String) {
        self.performSegue(withIdentifier: viewID, sender: nil)
    }
    
}
