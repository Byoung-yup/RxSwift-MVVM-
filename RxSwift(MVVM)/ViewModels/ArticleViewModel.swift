//
//  ArticleViewModel.swift
//  RxSwift(MVVM)
//
//  Created by 김병엽 on 2023/02/03.
//

import Foundation

struct ArticleViewModel {
    
    private let article: Article
    
    var imageUrl: String? {
        return article.urlToImage
    }
    
    var title: String? {
        return article.title
    }
    
    var description: String? {
        return article.description
    }
    
    init(article: Article) {
        self.article = article
    }
}
