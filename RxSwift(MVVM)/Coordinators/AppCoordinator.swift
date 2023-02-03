//
//  AppCoordinator.swift
//  RxSwift(MVVM)
//
//  Created by 김병엽 on 2023/02/02.
//

import Foundation
import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    func start()
}

class AppCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    private var navigationController: UINavigationController!
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showRootViewController()
    }
 
    private func showRootViewController() {
        let mainCoordinator = MainCoordinator(navigationController: navigationController)
        mainCoordinator.start()
        childCoordinators.append(mainCoordinator)
    }
}
