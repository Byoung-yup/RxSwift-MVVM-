//
//  RootViewModel.swift
//  RxSwift(MVVM)
//
//  Created by 김병엽 on 2023/02/02.
//

import Foundation
import RxSwift

final class RootViewModel {
    
    let title = "News"
    
    private let articleService: ArticleServiceProtocol
    
    init(articleService: ArticleServiceProtocol) {
        self.articleService = articleService
    }
    
    func fetchArticles() -> Observable<[ArticleViewModel]> {
        articleService.fetchNews().map { $0.map { ArticleViewModel(article: $0) } }
    }
}
