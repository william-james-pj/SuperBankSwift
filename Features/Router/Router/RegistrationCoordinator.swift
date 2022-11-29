//
//  RegistrationCoordinator.swift
//  Router
//
//  Created by Pinto Junior, William James on 22/11/22.
//

import UIKit
import Common
import Registration

class RegistrationCoordinator: Coordinator {
    weak var parentCoordinator: Coordinator?
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
    
    func goToCompletedRegistration(login: Login) {
        let completedRegistrationVC = CompletedRegistrationViewController()
        completedRegistrationVC.coordinatorDelegate = self
        completedRegistrationVC.settingVC(login: login)
        self.navigationController.pushViewController(completedRegistrationVC, animated: true)
    }
    
    func didFinishRegistration() {
        navigationController.popToRootViewController(animated: true)
        parentCoordinator?.childDidFinish(self)
    }
}