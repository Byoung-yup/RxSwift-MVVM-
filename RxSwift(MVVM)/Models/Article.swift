//
//  Article.swift
//  RxSwift(MVVM)
//
//  Created by 김병엽 on 2023/02/02.
//

import Foundation

struct ArticleResponse: Decodable {
    let articles: [Article]
    
//    enum CodingKeys: String, CodingKey {
//        case status = "status"
//        case totalResults = "totalResults"
//        case articles = "articles"
//    }
}

struct Article: Decodable {
    let title: String?
    let description: String?
    let urlToImage: String?
}
