//
//  API.swift
//  FunctionList_Swift
//
//  Created by leeyeon2 on 2022/01/10.
//

import UIKit
import Alamofire

//네트워크 통신
final class API {
    
    // 1
    static let shared = API()
    
    //post
    func requestAccessTokenToLogIn(with username: String, password: String) {
        let url = "https://3.38.165.81:80/sign-in"
        let headers: HTTPHeaders = ["Accept" : "application/json"]
        let parameters = ["username": username,
                          "password": password]
        AF.request(url, method: .post, parameters: parameters, headers: headers).responseJSON(){
            response in
            switch response.result {
            case .success:
                if let jsonObject = try! response.result.get() as? [String: Any] {
                    if let accessToken = jsonObject["access_token"] as? String {
                        self.getUser(accessToken: accessToken)
                    }
                }
            case .failure(let error):
                print(error)
                return
            }
        }
    }
    
    //get token
    func getUser(accessToken: String) {
        let url = "https://3.38.165.81:80/sign-in"
        let headers: HTTPHeaders = ["Authorization" : "token \(accessToken)"]
        AF.request(url, headers: headers).responseJSON(){
            response in
            switch response.result {
            case .success:
                //                    var user = UserData()
                var user = UserModel()
                if let jsonObject = try! response.result.get() as? [String: Any] {
                    // 토큰 가져오기
                    print(jsonObject["accessToken"] as! String)
                }
            case .failure(let error):
                print(error)
                return
            }
        }
    }
    
    //get
    func getAPI(){
        AF.request("https://api.itbook.store/1.0/search/Swift/1").responseJSON() { response in
          switch response.result {
          case .success:
            if let data = try! response.result.get() as? [String: Any] {
              print(data)
            }
          case .failure(let error):
            print("Error: \(error)")
            return
          }
        }
    }
    
    //get
    func requestAPI(
        _ query: String,
        _ page: Int
    ) {
        let url = Config.baseURL + "search/" + "\(query)/\(page)"
        print(url)
        //        let url = Config.baseURL + "search/" + "\("Swift")/\(1)"
        //encoding
        if let urlEncoding = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed){
            //request
            AF.request(urlEncoding, method: .get)
                .responseString{dataResponse in
                    print(dataResponse.result)
                    //                    switch dataResponse.result{
                    switch dataResponse.result{
                        //jsonData >> any Type
                    case .success(let jsonData)://잘 가져왔다면
                        do {
//                                                        let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String : Any]
                            let json = try JSONSerialization.data(withJSONObject: jsonData, options: .prettyPrinted)
                            let result = try JSONDecoder().decode(Books.self, from: json)
                            let books: [Book] = result.books
                            for book in books{
                                print(book.title)
                            }
                        }
                        catch{
                            //                            print(error.localizedDescription)
                        }
                        print("jsonData: \(jsonData)")
                    case .failure:
                        print("실패")
                    }
                }
        }
    }
    
    //post - 회원가입
    // "https://3.38.165.81:80/sign-up"
//    "email" : "jaeyeonling@gmail.com",
//    "password" : "PASSWORD",
//    "name" : "김재연",
//    "thumbnail" : "THUMBNAIL",
//    "gender" : "MAN"
//  }'
    func postAPI() {
        print("post!!!!!!")
        let param: Parameters = [
             "email" : "lxxyeon@gmail.com",
             "password" : "PASSWORD",
             "name" : "이연",
             "thumbnail" : "THUMBNAIL",
             "gender" : "MAN"
         ]
        
        AF.request("https://3.38.165.81:80/sign-up", method: .post, parameters: param, encoding: URLEncoding.httpBody).responseJSON() { response in
          switch response.result {
          case .success:
            if let data = try! response.result.get() as? [String: Any] {
              print(data)
            }
          case .failure(let error):
            print("Error: \(error)")
            return
          }
        }
    }

    
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
        
        //        reachability.listener = { status in
        //            print("Reachability Status Changed: \(status)")
        //        }
        //
        //        reachability.startListening()
    }
    
    // 4
    func get1(completionHandler: @escaping (Result<[UserData], Error>) -> Void) {
        self.request = AF.request("\(Config.baseURL)/posts")
        self.request?.responseDecodable { (response: DataResponse<[UserData], AFError>) in
            switch response.result {
            case .success(let userDatas):
                completionHandler(.success(userDatas))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func put(completionHandler: @escaping (Result<[UserData], Error>) -> Void) {
        let userData = PostUserData(id: 1)
        self.request = AF.request("\(Config.baseURL)/posts/1", method: .put, parameters: userData)
        self.request?.responseDecodable {  (response: DataResponse<[UserData], AFError>)in
            switch response.result {
            case .success(let userData):
                completionHandler(.success(userData))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    // 4-1
    //    func get2(completionHandler: @escaping (Result<[UserData], Error>) -> Void) {
    //        let parameters: Parameters = ["userId": 1]
    //        self.request = AF.request("\(Config.baseURL)/posts", method: .get, parameters: parameters, encoding: URLEncoding.default)
    //        self.request?.responseDecodable { (response: DataResponse<[UserData]>) in
    //            switch response.result {
    //            case .success(let userDatas):
    //                completionHandler(.success(userDatas))
    //            case .failure(let error):
    //                completionHandler(.failure(error))
    //            }
    //        }
    //    }
    //
    //    // 5
    //    func post(completionHandler: @escaping (Result<[UserData], Error>) -> Void) {
    //        let userData = PostUserData()
    //        self.request = AF.request("\(Config.baseURL)/posts", method: .post, parameters: userData)
    //        self.request?.responseDecodable { (response: DataResponse<PostUserData>) in
    //            switch response.result {
    //            case .success(let userData):
    //                completionHandler(.success([userData.toUserData()]))
    //            case .failure(let error):
    //                completionHandler(.failure(error))
    //            }
    //        }
    //    }
    //
    //    // 6

    
    // 7
    //    func patch(completionHandler: @escaping (Result<[UserData], Error>) -> Void) {
    //        let userData = PostUserData(id: 1)
    //        self.request = AF.request("\(Config.baseURL)/posts/1", method: .patch, parameters: userData)
    //        self.request?.responseDecodable { (response: DataResponse<PatchUserData>) in
    //            switch response.result {
    //            case .success(let userData):
    //                completionHandler(.success([userData.toUserData()]))
    //            case .failure(let error):
    //                completionHandler(.failure(error))
    //            }
    //        }
    //    }
    
    // 8
    //    func delete(completionHandler: @escaping (Result<[UserData], Error>) -> Void) {
    //        self.request = AF.request("\(Config.baseURL)/posts/1", method: .delete)
    //        self.request?.response { response in
    //            switch response.result {
    //            case .success:
    //                completionHandler(.success([UserData(userId: -1, id: -1, title: "DELETE", body: "SUCCESS")]))
    //            case .failure(let error):
    //                completionHandler(.failure(error))
    //            }
    //        }
    //    }
    
    func fetchData2(userName: String, completionHandler: @escaping (Result<UserData, AFError>) -> Void) {
        self.request = AF.request("\(Config.baseURL)")
        self.request?.responseDecodable { (response: DataResponse<UserData, AFError>) in
            switch response.result {
            case .success(let data):
                completionHandler(.success(data))
            case .failure(let err):
                completionHandler(.failure(err))
            }
        }
    }
}
