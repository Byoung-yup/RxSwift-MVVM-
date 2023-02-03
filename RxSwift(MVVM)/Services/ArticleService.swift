//
//  ArticleService.swift
//  RxSwift(MVVM)
//
//  Created by 김병엽 on 2023/02/02.
//

import Foundation
import Alamofire
import RxSwift

enum ArticleServiceError: Error {
    case fetchError
}

protocol ArticleServiceProtocol {
    func fetchNews() -> Observable<[Article]>
}

class ArticleService: ArticleServiceProtocol {
    
    func fetchNews() -> Observable<[Article]> {
        
        return Observable.create { (observer) -> Disposable in
            
            self.fetchNews { result in
                
                switch result {
                case .success(let data):
                    observer.onNext(data)
                case .failure(let error):
                    observer.onError(error)
                }
                
                observer.onCompleted()
            }
            
            return Disposables.create()
        }
        
    }
    
    private func fetchNews(completion: @escaping (Result<[Article], Error>) -> Void) {
        
        let urlString = "https://newsapi.org/v2/everything?q=bitcoin&apiKey=4ab010d03297419eb3cd5e2210cf0916"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(ArticleServiceError.fetchError))
            return
        }
        
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, _, error in
            
            if error != nil {
                completion(.failure(ArticleServiceError.fetchError))
                return
            }
            
            if let data = data {
                let articleList = try! JSONDecoder().decode(ArticleResponse.self, from: data)
                completion(.success(articleList.articles))
            }
            
        }.resume()
        
        
    }
}
