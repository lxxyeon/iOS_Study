//
//  MainCoordinator.swift
//  FunctionList_Swift
//
//  Created by leeyeon2 on 2021/10/03.
//

import UIKit

class MainCoordinator: NSObject, Coordinator, UINavigationControllerDelegate {

    var navigationController: UINavigationController
    var childCoordinators = [Coordinator]()

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
//        let vc = TestViewController.instantiate()
//        let vc = FirebaseViewController.instantiate()
        let vc = FuncTableViewController.instantiate()
//        let vc = AViewController.instantiate()
        
//        vc.coordinator = self
        
        navigationController.delegate = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func pushSecondVC() {
        let secondViewCoodinator = SecondViewCoordinator(navigationController: navigationController)
        secondViewCoodinator.parentCoodinator = self
        //메모리에서 제거되지 않도록
        childCoordinators.append(secondViewCoodinator)
        secondViewCoodinator.start()
    }
    
    func childDidFinish(_ child: Coordinator?){
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
            return
        }
        
        if navigationController.viewControllers.contains(fromViewController) {
            return
        }
        
        DispatchQueue.main.async {
            // Main 큐에서 비동기 방식으로 실행할 코드
        }
        DispatchQueue.global().async {
            // Background 큐에서 비동기 방식으로 실행할 코드
        }
        DispatchQueue.main.sync {
            // Main 큐에서 동기 방식으로 실행할 코드
        }
        DispatchQueue.global().sync {
            // Background 큐에서 동기 방식으로 실행할 코드
        }
        
        if let buyViewController = fromViewController as? BViewController {
            childDidFinish(buyViewController.coordinator)
        }
    }
    
}
