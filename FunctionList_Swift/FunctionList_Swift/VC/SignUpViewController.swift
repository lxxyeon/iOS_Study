//
//  SignUpViewController.swift
//  FunctionList_Swift
//
//  Created by leeyeon2 on 2021/08/10.
//

import UIKit

class SignUpViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var userId: UITextField!
    @IBOutlet weak var userPw: UITextField!
    @IBOutlet weak var userPwCheck: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var introduceTxt: UITextView!
    @IBOutlet weak var nextBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 다음 버튼 비활성화
        nextBtn.isEnabled = false
        
        let tapGestureView: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.tapView(_:)))
        
        self.view.addGestureRecognizer(tapGestureView)
    }
    
    // Done 버튼 활성화
    @objc func tapView(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
        if imageView.isOpaque==false&&userId.text! != ""&&userPw.text! != ""&&userPwCheck.text! != ""&&introduceTxt.text! != ""&&userPw.text!==userPwCheck.text! {
            nextBtn.isEnabled = true
        }
        else { nextBtn.isEnabled = false }
    }
    
    
    @IBAction func nextBtnAction(_ sender: Any) {
        UserInfo.shared.id = userId.text
        UserInfo.shared.password = userPw.text
        
        
    }
    
    //취소 버튼
    @IBAction func cancleBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    //MARK:- imagePicker
    @IBAction func tapImageView(_ sender: Any) {
        self.present(self.imagePicker, animated: true, completion: nil)
    }
    
    lazy var imagePicker: UIImagePickerController = {
        let picker:UIImagePickerController = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self      //delegate 위임
        picker.allowsEditing = true
        return picker
    }()
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let originalImage : UIImage = (info[UIImagePickerController.InfoKey.editedImage]) as! UIImage
        self.imageView.image = originalImage
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    //MARK:-
    
    
    
}
