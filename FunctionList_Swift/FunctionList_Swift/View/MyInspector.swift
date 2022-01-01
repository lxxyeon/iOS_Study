//
//  MyInspector.swift
//  FunctionList_Swift
//
//  Created by leeyeon2 on 2022/01/01.
//

import UIKit

class MyInspector: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat{
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
            
        }
    }
}
