//
//  LoginCoordinatorDelegate.swift
//  Login
//
//  Created by Pinto Junior, William James on 02/12/22.
//

import Foundation

public protocol LoginCoordinatorDelegate: AnyObject {
    func goToRegistration()
    func didAuthenticate(customerId: String, accountId: String)
}
