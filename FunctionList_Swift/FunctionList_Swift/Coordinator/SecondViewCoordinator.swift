//
//  SecondViewCoordinator.swift
//  FunctionList_Swift
//
//  Created by leeyeon2 on 2021/10/03.
//

import UIKit

class SecondViewCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    weak var parentCoodinator: MainCoordinator?

    
//    init(presenter: UINavigationController, viewModel: HomeViewModel? = HomeViewModel()) {
//        self.navigationController = presenter
//        self.childCoordinators = []
//
//    }

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    func start() {
        let secondVC = BViewController.instantiate()
        secondVC.coordinator = self
        navigationController.pushViewController(secondVC, animated: true)
    }
    
    func didFinishBuying(){
        parentCoodinator?.childDidFinish(self)
    }
}
