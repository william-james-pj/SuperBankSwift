//
//  AplicationCoordinator.swift
//  Router
//
//  Created by Pinto Junior, William James on 22/11/22.
//

import UIKit

public class AplicationCoordinator: Coordinator {
    // MARK: - Constrants
    let window: UIWindow
    
    // MARK: - Variables
    public var parentCoordinator: Coordinator?
    public var childCoordinators: [Coordinator] = []
    public var navigationController = UINavigationController()
    
    private var isLoggedIn: Bool = false
    
    // MARK: - Init
    public init(window: UIWindow) {
        self.window = window
    }
    
    public func start() {
//        self.goToMain(customerId: "j2Ky1kqXFXutJbd6NEZA", accountId: "VENfK2YsMQ860MhS53aC")
//        if isLoggedIn {
//            self.goToMain()
//            return
//        }

        self.goToAuthentication()
    }
    
    // MARK: - Methods
    private func goToAuthentication() {
        let coordinator = LoginCoordinator(navigationController: navigationController)
        coordinator.parentCoordinator = self
        coordinator.delegate = self
        coordinator.start()
        self.childCoordinators.append(coordinator)
        window.rootViewController = coordinator.navigationController
    }
    
    private func goToMain(customerId: String, accountId: String) {
        let coordinator = HomeCoordinator(navigationController: navigationController)
        coordinator.parentCoordinator = self
        coordinator.delegate = self
        coordinator.start()
        coordinator.goToMain(customerId: customerId, accountId: accountId)
        self.childCoordinators.append(coordinator)
        window.rootViewController = coordinator.navigationController
    }
}

// MARK: - extension AuthenticationCoordinatorDelegate
extension AplicationCoordinator: AuthenticationCoordinatorDelegate {
    func coordinatorDidAuthenticate(customerId: String, accountId: String) {
        self.goToMain(customerId: customerId, accountId: accountId)
    }
}

// MARK: - extension LogOffCoordinatorDelegate
extension AplicationCoordinator: LogoutCoordinatorDelegate {
    func coordinatorDidLogout() {
        self.goToAuthentication()
    }
}
