//
//  AddInfoViewController.swift
//  FunctionList_Swift
//
//  Created by leeyeon2 on 2021/08/10.
//


import UIKit

class AddInfoViewController: UIViewController {
    let SignVC: SignUpViewController = SignUpViewController()
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func datePickerAction(_ sender: UIDatePicker) {
        //DateFormatter 클래스 상수 선언
        let formatter = DateFormatter()
        //출력되는 데이터 style
        formatter.dateStyle = .long
        //UIDatePicker에서 선택한 날짜를 format에서 설정한 포맷대로 string 메서드를 사용하여 문자열로 변환
        dateLabel.text = formatter.string(from: datePicker.date)
        datePicker.addTarget(self, action: #selector(changed), for: .valueChanged)
    }
    //취소 버튼
    @IBAction func cancleAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    //이전 버튼
    @IBAction func beforeBtnAction(_ sender: Any) {
        
    }
    
    //가입 버튼
    @IBAction func registBtn(_ sender: Any) {
        UserInfo.shared.id = SignVC.userId.text
    }

    
    @objc func changed() {
        // Datefommater 설정
        let dateformatter = DateFormatter()
        dateformatter.dateStyle = .medium
        dateformatter.timeStyle = .none
        // pickerView를 통해 선택한 날짜 String으로 포매팅
        let date = dateformatter.string(from: datePicker.date)
        dateLabel.text = date
    }

}
