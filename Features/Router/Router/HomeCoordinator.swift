//
//  HomeCoordinator.swift
//  Router
//
//  Created by Pinto Junior, William James on 02/12/22.
//

import UIKit
import Home

class HomeCoordinator: Coordinator {
    // MARK: - Variables
    weak var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    // MARK: - Init
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Methods
    func start() {
        settingNav()
        let initialViewController = HomeViewController()
        initialViewController.coordinatorDelegate = self
        self.navigationController.pushViewController(initialViewController, animated: false)
    }
    
    private func settingNav() {
        self.navigationController.navigationBar.titleTextAttributes = [.foregroundColor: UIColor(named: "Text") ?? .label]
        self.navigationController.navigationBar.tintColor = UIColor(named: "Text")
    }
}

// MARK: - extension HomeCoordinatorDelegate
extension HomeCoordinator: HomeCoordinatorDelegate {
    func goToDrawerMenu() {
        let drawerVC = DrawerMenuViewController()
        drawerVC.coordinatorDelegate = self
        drawerVC.modalPresentationStyle = .fullScreen
        self.navigationController.present(drawerVC, animated: true, completion: nil)
    }
    
    func closeDrawerMenu() {
        self.navigationController.dismiss(animated: true, completion: nil)
    }
    
    func goToPresentCard() {
        let coordinator = CardCoordinator(navigationController: navigationController)
        coordinator.parentCoordinator = self
        childCoordinators.append(coordinator)
        coordinator.start()
    }
}
