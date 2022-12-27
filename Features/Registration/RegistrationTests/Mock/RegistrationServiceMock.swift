//
//  RegistrationServiceMock.swift
//  RegistrationTests
//
//  Created by Pinto Junior, William James on 27/12/22.
//

import Foundation
import Common
import FirebaseService

class RegistrationServiceMock: RegistrationNetwork {
    func register(customer: CustomerModel) async throws -> LoginModel {
        if customer.fullName == "" {
            throw RegistrationError.errorSaving
        }
        
        return LoginModel(accountId: "", customerId: "", accountNumber: "", password: "")
    }
    
    func validateCPF(_ cpf: String) async throws -> Bool {
        if cpf == "11111111111" {
            return true
        }
        return false
    }
    
    func validateEmail(_ email: String) async throws -> Bool {
        if email == "email@aa.aaa" {
            return true
        }
        return false
    }
    
}
