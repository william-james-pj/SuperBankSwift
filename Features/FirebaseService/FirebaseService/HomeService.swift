//
//  HomeService.swift
//  FirebaseService
//
//  Created by Pinto Junior, William James on 05/12/22.
//

import Foundation
import Firebase
import Common

public enum HomeError: Error {
    case invalidDocument
    case invalidCustomer
    case invalidAccount
}

public class HomeService {
    // MARK: - Constrants
    private let db = Firestore.firestore()
    
    // MARK: - Init
    public init() {
    }
    
    // MARK: - Methods
    public func getCustomer(_ id: String) async throws -> CustomerModel {
        let q = db.collection("customers").document(id)
        let document = try? await q.getDocument()
        
        guard let document = document else {
            throw HomeError.invalidDocument
        }
        
        if !document.exists {
            throw HomeError.invalidCustomer
        }
        
        let data = document.data()
        let birthDate = data?["birthDate"] as? String ?? ""
        let cpf = data?["cpf"] as? String ?? ""
        let email = data?["email"] as? String ?? ""
        let fullName = data?["fullName"] as? String ?? ""
        let phoneNumber = data?["phoneNumber"] as? String ?? ""
        
        return CustomerModel(
            birthDate: birthDate,
            cpf: cpf,
            email: email,
            fullName: fullName,
            phoneNumber: phoneNumber
        )
    }
    
    public func getAccount(_ id: String) async throws -> AccountModel {
        let q = db.collection("accounts").document(id)
        let document = try? await q.getDocument()
        
        guard let document = document else {
            throw HomeError.invalidDocument
        }
        
        if !document.exists {
            throw HomeError.invalidAccount
        }
            
        let data = document.data()
        let accountNumber = data?["birthDate"] as? String ?? ""
        let balance = data?["balance"] as? Double ?? 0
        let customerId = data?["customerId"] as? String ?? ""
        let openDate = data?["openDate"] as? String ?? ""
        let hasCard = data?["hasCard"] as? Bool ?? false
        let cardPin = data?["cardPin"] as? String ?? ""
        let hasCardDelivery = data?["hasCardDelivery"] as? Bool ?? false
        
        return AccountModel(
            accountNumber: accountNumber,
            balance: balance,
            customerId: customerId,
            openDate: openDate,
            hasCard: hasCard,
            cardPin: cardPin,
            hasCardDelivery: hasCardDelivery
        )
    }
}
