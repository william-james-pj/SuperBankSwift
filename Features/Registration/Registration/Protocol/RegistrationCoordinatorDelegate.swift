//
//  RegistrationCoordinatorDelegate.swift
//  Registration
//
//  Created by Pinto Junior, William James on 22/11/22.
//

import UIKit
import Common

public protocol RegistrationCoordinatorDelegate: AnyObject {
    func goToFullName()
    func goToCPF()
    func goToBirthDate()
    func goToPhoneNumber()
    func goToEmail()
    func goToRepeatEmail()
    func goToCompletedRegistration(login: LoginModel)
    func didFinishRegistration()
}
