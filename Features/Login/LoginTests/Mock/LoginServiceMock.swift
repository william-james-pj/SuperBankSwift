//
//  LoginServiceMock.swift
//  LoginTests
//
//  Created by Pinto Junior, William James on 26/12/22.
//

import Foundation
import Common
import FirebaseService

class LoginServiceMock: LoginNetwork {
    func getLogin(_ accountNumber: String) async throws -> LoginModel {

        if accountNumber != "1122334" {
            throw LoginError.invalidAccount
        }
        return LoginModel(accountId: "", customerId: "", accountNumber: "1122334", password: "12345")
    }

    func getCustomerName(_ customerId: String) async throws -> String {
        return "Customer name"
    }
}
