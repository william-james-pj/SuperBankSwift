//
//  LoginNetwork.swift
//  FirebaseService
//
//  Created by Pinto Junior, William James on 26/12/22.
//

import Foundation
import Common

public protocol LoginNetwork {
    func getLogin(_ accountNumber: String) async throws -> LoginModel
    func getCustomerName(_ customerId: String) async throws -> String
}
