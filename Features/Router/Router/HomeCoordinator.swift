//
//  HomeCoordinator.swift
//  Router
//
//  Created by Pinto Junior, William James on 02/12/22.
//

import UIKit
import Home

protocol LogoutCoordinatorDelegate: AnyObject {
    func coordinatorDidLogout()
}

class HomeCoordinator: Coordinator {
    // MARK: - Variables
    weak var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    weak var delegate: LogoutCoordinatorDelegate?
    
    var accountId: String?
    
    // MARK: - Init
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Methods
    func start() {
        settingNav()
    }
    
    func start(customerId: String, accountId: String) {
        self.start()

        let initialViewController = HomeViewController()
        initialViewController.loaderData(customerId: customerId, accountId: accountId)
        initialViewController.coordinatorDelegate = self
        self.navigationController.setViewControllers([initialViewController], animated: false)
    }
    
    private func settingNav() {
        self.navigationController.navigationBar.titleTextAttributes = [.foregroundColor: UIColor(named: "Text") ?? .label]
        self.navigationController.navigationBar.tintColor = UIColor(named: "Text")
    }
}

// MARK: - extension HomeCoordinatorDelegate
extension HomeCoordinator: HomeCoordinatorDelegate {
    func goToDrawerMenu(customerName: String) {
        let drawerVC = DrawerMenuViewController()
        drawerVC.coordinatorDelegate = self
        drawerVC.customerName = customerName
        drawerVC.modalPresentationStyle = .fullScreen
        self.navigationController.present(drawerVC, animated: true, completion: nil)
    }
    
    func closeDrawerMenu() {
        self.navigationController.dismiss(animated: true, completion: nil)
    }
    
    func logoff() {
        self.navigationController.popToRootViewController(animated: true)
        self.parentCoordinator?.childDidFinish(self)
        self.delegate?.coordinatorDidLogout()
    }
    
    func goToCard(hasCard: Bool) {
        let coordinator = CardCoordinator(navigationController: navigationController)
        coordinator.parentCoordinator = self
        coordinator.accountId = accountId
        childCoordinators.append(coordinator)
        coordinator.start(hasCard: hasCard)
    }
}
