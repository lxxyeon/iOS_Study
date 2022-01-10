//
//  API.swift
//  FunctionList_Swift
//
//  Created by leeyeon2 on 2022/01/10.
//

import UIKit
import Alamofire

class API {
    // 1
    static let shared: API = API()
    
    // 2
    private var request: DataRequest? {
        didSet {
            oldValue?.cancel()
        }
    }
    
    // 3
    private var reachability: NetworkReachabilityManager!
    
    private init() {
        monitorReachability()
    }
    
    // 3-1
    private func monitorReachability() {
        reachability = NetworkReachabilityManager(host: "www.apple.com")
        
        reachability.listener = { status in
            print("Reachability Status Changed: \(status)")
        }
        
        reachability.startListening()
    }
    
    // 4
    func get1(completionHandler: @escaping (Result<[UserData], Error>) -> Void) {
        self.request = AF.request("\(Config.baseURL)/posts")
        self.request?.responseDecodable { (response: DataResponse<[UserData]>) in
            switch response.result {
            case .success(let userDatas):
                completionHandler(.success(userDatas))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    // 4-1
    func get2(completionHandler: @escaping (Result<[UserData], Error>) -> Void) {
        let parameters: Parameters = ["userId": 1]
        self.request = AF.request("\(Config.baseURL)/posts", method: .get, parameters: parameters, encoding: URLEncoding.default)
        self.request?.responseDecodable { (response: DataResponse<[UserData]>) in
            switch response.result {
            case .success(let userDatas):
                completionHandler(.success(userDatas))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    // 5
    func post(completionHandler: @escaping (Result<[UserData], Error>) -> Void) {
        let userData = PostUserData()
        self.request = AF.request("\(Config.baseURL)/posts", method: .post, parameters: userData)
        self.request?.responseDecodable { (response: DataResponse<PostUserData>) in
            switch response.result {
            case .success(let userData):
                completionHandler(.success([userData.toUserData()]))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    // 6
    func put(completionHandler: @escaping (Result<[UserData], Error>) -> Void) {
        let userData = PostUserData(id: 1)
        self.request = AF.request("\(Config.baseURL)/posts/1", method: .put, parameters: userData)
        self.request?.responseDecodable { (response: DataResponse<PostUserData>) in
            switch response.result {
            case .success(let userData):
                completionHandler(.success([userData.toUserData()]))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    // 7
    func patch(completionHandler: @escaping (Result<[UserData], Error>) -> Void) {
        let userData = PostUserData(id: 1)
        self.request = AF.request("\(Config.baseURL)/posts/1", method: .patch, parameters: userData)
        self.request?.responseDecodable { (response: DataResponse<PatchUserData>) in
            switch response.result {
            case .success(let userData):
                completionHandler(.success([userData.toUserData()]))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    // 8
    func delete(completionHandler: @escaping (Result<[UserData], Error>) -> Void) {
        self.request = AF.request("\(Config.baseURL)/posts/1", method: .delete)
        self.request?.response { response in
            switch response.result {
            case .success:
                completionHandler(.success([UserData(userId: -1, id: -1, title: "DELETE", body: "SUCCESS")]))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}
