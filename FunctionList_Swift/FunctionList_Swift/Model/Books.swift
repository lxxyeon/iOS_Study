//
//  Books.swift
//  FunctionList_Swift
//
//  Created by leeyeon2 on 2022/01/16.
//

import Foundation

struct Books: Codable {
    var books: [Book]
    var total: String
    var page: String
}

struct Book: Codable {
    var isbn13: String
    var subtitle: String
    var url: String
    var thumbnail: String
    var title: String
    var price: String
    
    enum CodingKeys: String, CodingKey{
        case title
        case subtitle
        case isbn13
        case price
        case thumbnail = "image"
        case url
    }
}
