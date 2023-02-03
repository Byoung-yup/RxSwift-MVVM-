//
//  ArticleCell.swift
//  RxSwift(MVVM)
//
//  Created by 김병엽 on 2023/02/03.
//

import UIKit
import RxSwift
import SDWebImage

class ArticleCell: UICollectionViewCell {
    
    // MARK: Properties
    let disposeBag = DisposeBag()
    var viewModel = PublishSubject<ArticleViewModel>()
    
    lazy var imageView: UIImageView = {
       let imageV = UIImageView()
        imageV.layer.cornerRadius = 8
        imageV.contentMode = .scaleAspectFill
        imageV.clipsToBounds = true
        imageV.widthAnchor.constraint(equalToConstant: 60).isActive = true
        imageV.heightAnchor.constraint(equalToConstant: 60).isActive = true
        imageV.backgroundColor = .secondarySystemBackground
        return imageV
    }()
    
    lazy var titleLabel: UILabel = {
       let lbl = UILabel()
        lbl.font = .boldSystemFont(ofSize: 20)
        return lbl
    }()
    
    lazy var descriptionLabel: UILabel = {
       let lbl = UILabel()
        lbl.numberOfLines = 3
        return lbl
    }()
    
    // MARK: Lifecycles
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        subscribe()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Helpers
    func subscribe() {
        
        viewModel.subscribe { articleViewModel in
            if let urlString = articleViewModel.element?.imageUrl {
                self.imageView.sd_setImage(with: URL(string: urlString))
            }
            
            self.titleLabel.text = articleViewModel.element?.title
            self.descriptionLabel.text = articleViewModel.element?.description
            
        }.disposed(by: disposeBag)
        
    }
    
    // MARK: Configures
    private func configureUI() {
        
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        imageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: imageView.topAnchor).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 20).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -40).isActive = true
        
        addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        descriptionLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor).isActive = true
        descriptionLabel.rightAnchor.constraint(equalTo: titleLabel.rightAnchor).isActive = true
        
    }
}
