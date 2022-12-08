//
//  CardCoordinator.swift
//  Router
//
//  Created by Pinto Junior, William James on 06/12/22.
//

import UIKit
import Cards

class CardCoordinator: NSObject, Coordinator {
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
        self.navigationController.delegate = self
        
        settingNav()
        goToPresentCard()
    }
    
    private func settingNav() {
        self.navigationController.navigationBar.titleTextAttributes = [.foregroundColor: UIColor(named: "Text") ?? .label]
        self.navigationController.navigationBar.tintColor = UIColor(named: "Text")
    }
}

// MARK: - extension HomeCoordinatorDelegate
extension CardCoordinator: CardCoordinatorDelegate {
    func goToPresentCard() {
        let presentCardVC = PresentCardViewController()
        presentCardVC.coordinatorDelegate = self
        self.navigationController.pushViewController(presentCardVC, animated: true)
    }
    
    func goToMyCards() {
        let myCards = MyCardsViewController()
        myCards.coordinatorDelegate = self
        self.navigationController.pushViewController(myCards, animated: true)
    }
    
}

// MARK: - extension UINavigationControllerDelegate
extension CardCoordinator: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
            return
        }

        if navigationController.viewControllers.contains(fromViewController) {
            return
        }

        if let _ = fromViewController as? PresentCardViewController {
            self.parentCoordinator?.childDidFinish(self)
        }
    }
}
