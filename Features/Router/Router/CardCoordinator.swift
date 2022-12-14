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
    
    var accountId: String?
    
    // MARK: - Init
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Methods
    func start() {
        self.navigationController.delegate = self
        settingNav()
    }
    
    func start(hasCard: Bool) {
        self.start()
        
        if hasCard {
            goToMyCards()
            return
        }
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
    
    func goToCreditLimit() {
        let creditLimitVC = CreditLimitViewController()
        creditLimitVC.coordinatorDelegate = self
        self.navigationController.pushViewController(creditLimitVC, animated: true)
    }
    
    func goToInvoiceDueDate() {
        let invoiceDueDateVC = InvoiceDueDateViewController()
        invoiceDueDateVC.coordinatorDelegate = self
        self.navigationController.pushViewController(invoiceDueDateVC, animated: true)
    }
    
    func goToCardPin() {
        let cardPinVC = CardPinViewController()
        cardPinVC.coordinatorDelegate = self
        self.navigationController.pushViewController(cardPinVC, animated: true)
    }
    
    func goToCardTerm() {
        let cardTermVC = CardTermViewController()
        cardTermVC.coordinatorDelegate = self
        self.navigationController.pushViewController(cardTermVC, animated: true)
    }
    
    func goToRequestCardResume() {
        let resumeVC = RequestCardResumeViewController()
        resumeVC.coordinatorDelegate = self
        resumeVC.settingAccountId(accountId)
        self.navigationController.pushViewController(resumeVC, animated: true)
    }
    
    func goToCompledRequestCard() {
        self.navigationController.popToRootViewController(animated: false)
        
        let completedRequestVC = CompletedRequestCardViewController()
        completedRequestVC.coordinatorDelegate = self
        self.navigationController.pushViewController(completedRequestVC, animated: true)
    }
    
    func finalizeRequest() {
        self.navigationController.popToRootViewController(animated: true)
        self.parentCoordinator?.childDidFinish(self)
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
        
        if let _ = fromViewController as? CompletedRequestCardViewController {
            self.parentCoordinator?.childDidFinish(self)
        }
        
        if let _ = fromViewController as? MyCardsViewController {
            self.parentCoordinator?.childDidFinish(self)
        }
        
    }
}
