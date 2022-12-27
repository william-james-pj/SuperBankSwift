//
//  RegistrationNetwork.swift
//  FirebaseService
//
//  Created by Pinto Junior, William James on 27/12/22.
//

import Foundation
import Common

public protocol RegistrationNetwork {
    func register(customer: CustomerModel) async throws -> LoginModel
    func validateCPF(_ cpf: String) async throws -> Bool
    func validateEmail(_ email: String) async throws -> Bool
}
