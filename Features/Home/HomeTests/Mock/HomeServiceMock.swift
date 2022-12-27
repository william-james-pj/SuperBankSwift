//
//  HomeServiceMock.swift
//  HomeTests
//
//  Created by Pinto Junior, William James on 27/12/22.
//

import Foundation
import Common
import FirebaseService

class HomeServiceMock: HomeNetwork {
    func getCustomer(_ id: String) async throws -> CustomerModel {
        if id == "" {
            throw HomeError.invalidCustomer
        }
        
        return CustomerModel(birthDate: "", cpf: "", email: "", fullName: "", phoneNumber: "")
    }
    
    func getAccount(_ id: String) async throws -> AccountModel {
        if id == "" {
            throw HomeError.invalidAccount
        }
        
        if id == "2222" {
            return AccountModel(accountNumber: "", balance: 0, customerId: "", openDate: "", hasCard: true, cardPin: "", hasCardDelivery: false)
        }
        
        return AccountModel(accountNumber: "", balance: 0, customerId: "", openDate: "", hasCard: true, cardPin: "", hasCardDelivery: true)
    }
}
