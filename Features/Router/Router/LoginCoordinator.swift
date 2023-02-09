//
//  LoginCoordinator.swift
//  Router
//
//  Created by Pinto Junior, William James on 22/11/22.
//

import UIKit
import Login

protocol AuthenticationCoordinatorDelegate: AnyObject {
    func coordinatorDidAuthenticate(customerId: String, accountId: String)
}

class LoginCoordinator: Coordinator {
    // MARK: - Variables
    weak var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController

    weak var delegate: AuthenticationCoordinatorDelegate?

    // MARK: - Init
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    // MARK: - Methods
    func start() {
        settingNav()
        let initialViewController = LoginViewController()
        initialViewController.coordinatorDelegate = self
        self.navigationController.setViewControllers([initialViewController], animated: false)
    }

    private func settingNav() {
        self.navigationController.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor(named: "Text") ?? .label
        ]
        self.navigationController.navigationBar.tintColor = UIColor(named: "Text")
    }
}

// MARK: - extension LoginCoordinatorDelegate
extension LoginCoordinator: LoginCoordinatorDelegate {
    func goToRegistration() {
        let coordinator = RegistrationCoordinator(navigationController: navigationController)
        coordinator.parentCoordinator = self
        childCoordinators.append(coordinator)
        coordinator.start()
    }

    func didAuthenticate(customerId: String, accountId: String) {
        self.navigationController.popToRootViewController(animated: true)
        self.parentCoordinator?.childDidFinish(self)
        self.delegate?.coordinatorDidAuthenticate(customerId: customerId, accountId: accountId)
    }
}
