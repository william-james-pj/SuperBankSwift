//
//  RegistrationCoordinator.swift
//  Router
//
//  Created by Pinto Junior, William James on 22/11/22.
//

import UIKit
import Common
import Registration

class RegistrationCoordinator: NSObject, Coordinator {
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

        self.settingNav()
        let initialViewController = FirstInfoViewController()
        initialViewController.coordinatorDelegate = self
        self.navigationController.pushViewController(initialViewController, animated: false)
    }

    private func settingNav() {
        self.navigationController.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor(named: "Text") ?? .label
        ]
        self.navigationController.navigationBar.tintColor = UIColor(named: "Text")
    }
}

// MARK: - extension RegistrationCoordinatorDelegate
extension RegistrationCoordinator: RegistrationCoordinatorDelegate {
    func goToFullName() {
        let fullNameVC = FullNameRegistrationViewController()
        fullNameVC.coordinatorDelegate = self
        self.navigationController.pushViewController(fullNameVC, animated: true)
    }

    func goToCPF() {
        let cpfVC = CPFRegistrationViewController()
        cpfVC.coordinatorDelegate = self
        self.navigationController.pushViewController(cpfVC, animated: true)
    }

    func goToBirthDate() {
        let birthDateVC = BirthDateRegistrationViewController()
        birthDateVC.coordinatorDelegate = self
        self.navigationController.pushViewController(birthDateVC, animated: true)
    }

    func goToPhoneNumber() {
        let phoneNumberVC = PhoneNumberRegistrationViewController()
        phoneNumberVC.coordinatorDelegate = self
        self.navigationController.pushViewController(phoneNumberVC, animated: true)
    }

    func goToEmail() {
        let emailVC = EmailRegistrationViewController()
        emailVC.coordinatorDelegate = self
        self.navigationController.pushViewController(emailVC, animated: true)
    }

    func goToRepeatEmail() {
        let repeatEmailVC = RepeatEmailRegistrationViewController()
        repeatEmailVC.coordinatorDelegate = self
        self.navigationController.pushViewController(repeatEmailVC, animated: true)
    }

    func goToCompletedRegistration(login: LoginModel) {
        self.navigationController.popToRootViewController(animated: false)

        let completedRegistrationVC = CompletedRegistrationViewController()
        completedRegistrationVC.coordinatorDelegate = self
        completedRegistrationVC.settingVC(login: login)
        self.navigationController.pushViewController(completedRegistrationVC, animated: true)
    }

    func didFinishRegistration() {
        self.navigationController.popToRootViewController(animated: true)
        self.parentCoordinator?.childDidFinish(self)
    }
}

// MARK: - extension UINavigationControllerDelegate
extension RegistrationCoordinator: UINavigationControllerDelegate {
    func navigationController(
        _ navigationController: UINavigationController,
        didShow viewController: UIViewController,
        animated: Bool
    ) {
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
            return
        }

        if navigationController.viewControllers.contains(fromViewController) {
            return
        }

        if fromViewController as? FirstInfoViewController != nil {
            self.parentCoordinator?.childDidFinish(self)
        }

        if fromViewController as? CompletedRegistrationViewController != nil {
            self.parentCoordinator?.childDidFinish(self)
        }
    }
}
