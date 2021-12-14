//
//  FuncTableViewController.swift
//  FunctionList_Swift
//
//  Created by leeyeon2 on 2021/12/14.
//

import UIKit

class FuncTableViewController: UITableViewController, Storyboarded {
    
    let funcList: [String] = ["urlScheme", "CrashTest"]
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
            //
        case 0:
            self.goDeviceApp(_url: "mailto")
            
        case 1:
            break
            
        default:
            break
        }
    }
    // [외부 앱 실행 실시]
    /*
     1. tel , mailto , sms , l 등을 사용해 디바이스 외부 앱을 수행할 수 있습니다
     2. 전화 걸기 : tel:010-1234-5678
     3. 메일 보내기 : mailto:honggildung@test.com
     4. 문자 보내기 : sms:010-5678-1234
     5. 링크 이동 : https://naver.com
     6. 호출 예시 : goDeviceApp(_url: "tel:010-1234-5678")
     */
    func goDeviceApp(_url : String) {
        
        //스키마명을 사용해 외부앱 실행 실시 [사용가능한 url 확인]
        if let openApp = URL(string: _url), UIApplication.shared.canOpenURL(openApp) {
            print("")
            print("====================================")
            print("[goDeviceApp : 디바이스 외부 앱 열기 수행]")
            print("링크 주소 : \(_url)")
            print("====================================")
            print("")
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
            print("")
            print("====================================")
            print("[goDeviceApp : 디바이스 외부 앱 열기 실패]")
            print("링크 주소 : \(_url)")
            print("====================================")
            print("")
        }
    }
    
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
