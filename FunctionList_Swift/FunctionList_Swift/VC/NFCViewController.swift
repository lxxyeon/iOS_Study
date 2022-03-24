//
//  NFCViewController.swift
//  FunctionList_Swift
//
//  Created by leeyeon2 on 2022/03/17.
//

import UIKit
import CoreNFC

class NFCViewController: UIViewController {
    
    var session: NFCNDEFReaderSession?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func beginScanning(_ sender: AnyObject) {
        guard NFCNDEFReaderSession.readingAvailable else {
            let alertController = UIAlertController(
                title: "Scanning Not Supported",
                message: "This device doesn't support tag scanning.",
                preferredStyle: .alert
            )
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
            return
        }
        
        session = NFCNDEFReaderSession(delegate: self, queue: nil, invalidateAfterFirstRead: false)
        //nfc 스캔 시작시 나오는 메시지
        session?.alertMessage = "스캔을 위해 태그위에 핸드폰을 가까이 하세요."
        session?.begin()
    }
}

//NFCNDEFReaderSessionDelegate 상속
extension NFCViewController: NFCNDEFReaderSessionDelegate {
    //nfc 발견한 경우
    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        for message in messages {
            for record in message.records {
                if let string = String(data: record.payload, encoding: .ascii) {
                    print(string)
                }
            }
        }
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didDetect tags: [NFCNDEFTag]) {
        if tags.count > 1 {
            //하나 이상 발견
        }else {
            guard let tag = tags.first else { return }
            session.connect(to: tag, completionHandler: { (error: Error?) in
                if nil != error {
                    session.alertMessage = "태그에 연결할 수 없습니다."
                    session.invalidate()
                }else{
//                    tag.queryNDEFStatus(completionHandler: {(ndefStatus: )})
                }
                    
            })
        }
    }
    
    
    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        print(error.localizedDescription)
    }
    
}
