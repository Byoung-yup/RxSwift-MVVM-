//
//  MainCoordinator.swift
//  RxSwift(MVVM)
//
//  Created by 김병엽 on 2023/02/02.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    
    private var navigationController: UINavigationController!
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let rootViewController = RootViewController(viewModel: RootViewModel(articleService: ArticleService()))
        rootViewController.view.backgroundColor = .systemBackground
        navigationController.viewControllers = [rootViewController]
    }
    
}
