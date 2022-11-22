//
//  RegistrationCoordinator.swift
//  Router
//
//  Created by Pinto Junior, William James on 22/11/22.
//

import UIKit
import Registration

class RegistrationCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        settingNav()
        let initialViewController = FirstInfoViewController()
        initialViewController.coordinatorDelegate = self
        self.navigationController.pushViewController(initialViewController, animated: false)
    }
    
    
    fileprivate func settingNav() {
        navigationController.navigationBar.titleTextAttributes = [.foregroundColor: UIColor(named: "Text") ?? .label]
        navigationController.navigationBar.tintColor = UIColor(named: "Text")
    }
}

extension RegistrationCoordinator: RegistrationCoordinatorDelegate {
    func goToFirstStep() {
        let firstStepVC = FirstStepViewController()
        self.navigationController.pushViewController(firstStepVC, animated: true)
    }
    
}
