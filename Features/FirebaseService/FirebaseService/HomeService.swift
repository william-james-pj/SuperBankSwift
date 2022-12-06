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
    let db = Firestore.firestore()
    
    // MARK: - Closures
    public var updateAccount: ((_ account: Account) -> Void)?
    
    // MARK: - Init
    public init() {
    }
    
    // MARK: - Methods
    public func getCustomer(_ id: String) async throws -> Customer {
        let q = db.collection("customers").document(id)
        let document = try? await q.getDocument()
        
        guard let document = document else {
            throw HomeError.invalidDocument
        }
        
        if !document.exists {
            throw LoginError.invalidCustomer
        }
        
        let data = document.data()
        let birthDate = data?["birthDate"] as? String ?? ""
        let cpf = data?["cpf"] as? String ?? ""
        let email = data?["email"] as? String ?? ""
        let fullName = data?["fullName"] as? String ?? ""
        let phoneNumber = data?["phoneNumber"] as? String ?? ""
        
        return Customer(
            birthDate: birthDate,
            cpf: cpf,
            email: email,
            fullName: fullName,
            phoneNumber: phoneNumber
        )
    }
    
    public func getAccount(_ id: String) {
        let q = db.collection("accounts").document(id)
        
        q.addSnapshotListener { documentSnapshot, error in
            guard let document = documentSnapshot else {
                print("Error fetching document: \(error!)")
                return
            }
            
            let data = document.data()
            let accountNumber = data?["birthDate"] as? String ?? ""
            let balance = data?["balance"] as? Double ?? 0
            let customerId = data?["customerId"] as? String ?? ""
            let openDate = data?["openDate"] as? String ?? ""
            
            let account = Account(
                accountNumber: accountNumber,
                balance: balance,
                customerId: customerId,
                openDate: openDate
            )
            
            self.updateAccount?(account)
        }
    }
}
