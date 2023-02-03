//
//  RootViewController.swift
//  RxSwift(MVVM)
//
//  Created by 김병엽 on 2023/02/02.
//

import UIKit
import RxSwift
import RxRelay

class RootViewController: UIViewController {
    
    // MARK: Properties
    let disposeBag = DisposeBag()
    let viewModel: RootViewModel
    
    private let articleViewModel = BehaviorRelay<[ArticleViewModel]>(value: [])
    var articleViewModelObserver: Observable<[ArticleViewModel]> {
        return articleViewModel.asObservable()
    }
    
    private lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.register(ArticleCell.self, forCellWithReuseIdentifier: "cell")
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    // MARK: Lifecycles
    init(viewModel: RootViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "News"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        configureUI()
        fetchArticles()
        subscribe()
    }
    
    // MARK: Configures
    
    private func configureUI() {
        
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func fetchArticles() {
        
        viewModel.fetchArticles()
            .subscribe { articleViewModel in
                self.articleViewModel.accept(articleViewModel)
            }.disposed(by: disposeBag)
    }
    
    func subscribe() {
        
        articleViewModelObserver
            .observe(on: MainScheduler.instance)
            .subscribe { articles in
                self.collectionView.reloadData()
            }.disposed(by: disposeBag)
        
    }

}

extension RootViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return articleViewModel.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("cell")
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? ArticleCell else {
            print("error")
            return UICollectionViewCell()
        }
        
        cell.imageView.image = nil
        let articleViewModel = self.articleViewModel.value[indexPath.row]
        cell.viewModel.onNext(articleViewModel)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 120)
    }
    
}
