//
//  LoginService.swift
//  FirebaseService
//
//  Created by Pinto Junior, William James on 30/11/22.
//

import Foundation
import Common
import Firebase

public enum LoginError: Error {
    case invalidDocument
    case invalidAccount
    case invalidCustomer
}

public class LoginService {
    let db = Firestore.firestore()
    
    public init() {
        
    }
    
    public func getLogin(_ accountNumber: String) async throws -> LoginModel {
        let q = db.collection("login").whereField("accountNumber", isEqualTo: accountNumber)
        let documents = try? await q.getDocuments()
        
        guard let documents = documents else {
            throw LoginError.invalidDocument
        }
        
        if documents.documents.isEmpty {
            throw LoginError.invalidAccount
        }
        
        let data = documents.documents[0].data()
        let accountId = data["accountId"] as? String ?? ""
        let customerId = data["customerId"] as? String ?? ""
        let accountNumber = data["accountNumber"] as? String ?? ""
        let password = data["password"] as? String ?? ""
        
        let login = LoginModel(accountId: accountId, customerId: customerId, accountNumber: accountNumber, password: password)
        return login
    }
    
    public func getCustomerName(_ customerId: String) async throws -> String {
        let q = db.collection("customers").document(customerId)
        let document = try? await q.getDocument()
        
        guard let document = document else {
            throw LoginError.invalidDocument
        }
        
        if !document.exists {
            throw LoginError.invalidDocument
        }
        
        let data = document.data()
        
        let customerName = data?["fullName"] as? String ?? ""
        
        return customerName
    }
}
