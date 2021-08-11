//
//  UserInfo.swift
//  FunctionList_Swift
//
//  Created by leeyeon2 on 2021/08/10.
//
import Foundation
//Singleton Instance
class UserInfo{
    //shared: 타입 프로퍼티
    static let shared: UserInfo = UserInfo()
    
    var id: String?
    var password: String?
    var text: String?
    var phonenumber: String?
    var birth: String?
}
