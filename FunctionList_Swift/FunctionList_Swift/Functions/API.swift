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
            //            AF.request(urlEncoding, method: .get, parameters: parameters, encoding: URLEncoding.queryString, headers: head)
            //resposeJSON > responseString
                .responseString{dataResponse in
                    print(dataResponse.result)
                    //                    switch dataResponse.result{
                    switch dataResponse.result{
                        //jsonData >> any Type
                    case .success(let jsonData)://잘 가져왔다면
//                        do{
//                            if let json = try? JSONSerialization.jsonObject(with: jsonData, options: []) as? [String : Any] {
//                              if let name = json["name"] as? String {
//                                print(name) // hyeon
//                              }
//                            }
//                        }

                        
                        
                        do {
//                            let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String : Any]

                            let json = try JSONSerialization.data(withJSONObject: jsonData, options: .prettyPrinted)
                            
//                            guard let json = try! JSONSerialization.jsonObject(with: data) as? [String: Any] else {
//                                             print(String(data: data, encoding: .utf8) ?? "Not string?!?")
//                                             return
//                                         }
                            
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
            
            //                .responseDecodable{ (response: DataResponse<[UserData], AFError>) in
            //                    print("jsonData: \(response.result)") // decodingFailed
            //                    //                            print(response.result)
            //                    switch response.result{
            //                    case .success(let jsonData):
            //                        //                                let decoded = try decoder.decode([UserData].self, from: data!)
            //                        print("jsonData: \(jsonData)")
            //                    case .failure(let error):
            //                        print(error.localizedDescription)
            //                    }
            //
            //                }
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
    //    func put(completionHandler: @escaping (Result<[UserData], Error>) -> Void) {
    //        let userData = PostUserData(id: 1)
    //        self.request = AF.request("\(Config.baseURL)/posts/1", method: .put, parameters: userData)
    //        self.request?.responseDecodable { (response: DataResponse<PostUserData>) in
    //            switch response.result {
    //            case .success(let userData):
    //                completionHandler(.success([userData.toUserData()]))
    //            case .failure(let error):
    //                completionHandler(.failure(error))
    //            }
    //        }
    //    }
    
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
