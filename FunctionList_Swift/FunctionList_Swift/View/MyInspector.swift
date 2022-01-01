//
//  MyInspector.swift
//  FunctionList_Swift
//
//  Created by leeyeon2 on 2022/01/01.
//

import UIKit

class MyInspector: UIButton {
    @IBInspectable var borderColor: UIColor{
        set {
            self.layer.borderColor = newValue.cgColor
        }
        get {
            let color = self.layer.borderColor ?? UIColor.clear.cgColor
            return UIColor(cgColor: color)
        }
    }
    
    @IBInspectable var borderWidth: CGFloat{
        set {
            self.layer.borderWidth = newValue
        }
        get {
            return self.layer.borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat{
        set {
            self.layer.cornerRadius = newValue
        }
        get {
            return self.layer.cornerRadius
        }
    }
}
