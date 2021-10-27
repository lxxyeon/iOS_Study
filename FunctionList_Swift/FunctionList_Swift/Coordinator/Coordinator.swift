//
//  Coordinator.swift
//  FunctionList_Swift
//
//  Created by leeyeon2 on 2021/10/03.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    func start()
}

