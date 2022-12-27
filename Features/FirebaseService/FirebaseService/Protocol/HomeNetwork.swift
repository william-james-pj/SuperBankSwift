//
//  HomeNetwork.swift
//  FirebaseService
//
//  Created by Pinto Junior, William James on 27/12/22.
//

import Foundation
import Common

public protocol HomeNetwork {
    func getCustomer(_ id: String) async throws -> CustomerModel
    func getAccount(_ id: String) async throws -> AccountModel
}
