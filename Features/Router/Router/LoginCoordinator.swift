//
//  LoginCoordinator.swift
//  Router
//
//  Created by Pinto Junior, William James on 22/11/22.
//

import UIKit
import Login

class LoginCoordinator: Coordinator {
    weak var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        settingNav()
        let initialViewController = LoginViewController()
        initialViewController.coordinatorDelegate = self
        self.navigationController.pushViewController(initialViewController, animated: false)
    }
    
    fileprivate func settingNav() {
        navigationController.navigationBar.titleTextAttributes = [.foregroundColor: UIColor(named: "Text") ?? .label]
        navigationController.navigationBar.tintColor = UIColor(named: "Text")
    }
}

extension LoginCoordinator: LoginCoordinatorDelegate {
    func goToRegistration() {
        let coordinator = RegistrationCoordinator(navigationController: navigationController)
        coordinator.parentCoordinator = self
        childCoordinators.append(coordinator)
        coordinator.start()
    }
}
