//
//  RegistrationService.swift
//  FirebaseService
//
//  Created by Pinto Junior, William James on 22/11/22.
//

import Foundation
import Common
import Firebase

public class RegistrationService {
    let db = Firestore.firestore()
    
    public init() {
        
    }
    
    public func register(customer: Customer) -> Login {
        let id = self.saveCustomer(customer)
        
        let account = self.createAccount(id)
        let accountId = self.saveAccount(account)
        
        let login = self.createLogin(accountId, id, account.accountNumber)
        self.saveLogin(login)
        return login
    }
    
    public func validateCPF(_ cpf: String) async -> Bool {
        do {            
            let q = db.collection("customers").whereField("cpf", isEqualTo: cpf)
            let snapshot = try await q.getDocuments()
            
            if snapshot.documents.count > 0 {
                return false
            }
            return true
        }
        catch {
            print("Error getting documents")
            return false
        }
    }
    
    public func validateEmail(_ email: String) async -> Bool {
        do {
            let q = db.collection("customers").whereField("email", isEqualTo: email)
            let snapshot = try await q.getDocuments()
            
            if snapshot.documents.count > 0 {
                return false
            }
            return true
        }
        catch {
            print("Error getting documents")
            return false
        }
    }
    
    private func saveCustomer(_ customer: Customer) -> String {
        let newObjRef = db.collection("customers").document()
        newObjRef.setData(customer.dictionary)
        return newObjRef.documentID
    }
    
    private func saveAccount(_ account: Account) -> String {
        let newObjRef = db.collection("accounts").document()
        newObjRef.setData(account.dictionary)
        return newObjRef.documentID
    }
    
    private func saveLogin(_ login: Login) {
        let newObjRef = db.collection("login").document()
        newObjRef.setData(login.dictionary)
    }
    
    private func createAccount(_ customerId: String) -> Account {
        let code = self.generateAccountCode(7)
        let date = getCurrentDate()
        
        let newAccount = Account(accountNumber: code, balance: 0, customerId: customerId, openDate: date)
        return newAccount
    }
    
    private func createLogin(_ accountId: String, _ customerId: String, _ accountCode: String) -> Login {
        let password = generateAccountCode(5)
        
        let newLogin = Login(accountId: accountId, customerId: customerId, accountNumber: accountCode, password: password)
        return newLogin
    }
    
    private func generateAccountCode(_ digits: Int) -> String {
        var number = String()
        for _ in 1...digits {
            number += "\(Int.random(in: 1...9))"
        }
        return number
    }
    
    private func getCurrentDate() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/y HH:mm:ss"
        return dateFormatter.string(from: date)
    }
}
