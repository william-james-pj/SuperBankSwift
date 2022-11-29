//
//  AplicationCoordinator.swift
//  Router
//
//  Created by Pinto Junior, William James on 22/11/22.
//

import UIKit

public class AplicationCoordinator: Coordinator {
    public var parentCoordinator: Coordinator?
    public var childCoordinators: [Coordinator] = []
    public var navigationController = UINavigationController()

    let window: UIWindow
    
    public init(window: UIWindow) {
        self.window = window
    }
    
    public func start() {
        let mainCoordinator = LoginCoordinator(navigationController: navigationController)
        mainCoordinator.start()
        self.childCoordinators = [mainCoordinator]
        window.rootViewController = mainCoordinator.navigationController
    }
}
