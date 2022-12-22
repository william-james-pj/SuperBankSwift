//
//  CardService.swift
//  FirebaseService
//
//  Created by Pinto Junior, William James on 14/12/22.
//

import Foundation
import Firebase
import Common

public enum CardError: Error {
    case errorSaving
    case invalidDocument
    case invalidAccount
    case invalidCustomer
}

public class CardService {
    // MARK: - Constrants
    private let db = Firestore.firestore()
    
    // MARK: - Init
    public init() {
    }
    
    // MARK: - Methods
    public func saveInvoice(_ invoice: InvoiceModel) async throws {
        do {
            let newObjRef = db.collection("invoices").document()
            try await newObjRef.setData(invoice.dictionary)
        }
        catch {
            throw CardError.errorSaving
        }
    }
    
    public func saveAccountHasCard(accountId: String, cardPin: String) async throws {
        do {
            let newObjRef = db.collection("accounts").document(accountId)
            try await newObjRef.updateData(["hasCard": true,"cardPin": cardPin])
        }
        catch {
            throw CardError.errorSaving
        }
    }
    
    public func savePhysicalCard(accountId: String) async throws {
        do {
            let cardNumber = UtilityCard.generateCardNumber()
            let cvc = UtilityCard.generateCVC()
            let expireDate = UtilityCard.generateExpireDate(by: 3)
            let cardName = try await self.generateCardName(accountId: accountId)
            
            guard let cardNumber = cardNumber, let expireDate = expireDate else {
                return
            }
            
            let newCard = CardModel(
                cardId: nil,
                accountId: accountId,
                cardName: cardName,
                cardNumber: cardNumber,
                cvc: cvc,
                expireDate: expireDate,
                isEnabled: true,
                isInternationPurchasesEnabled: true,
                cardType: .physical,
                nickname: cardName
            )
            
            let newObjRef = db.collection("cards").document()
            try await newObjRef.setData(newCard.dictionary)
        }
        catch {
            throw error
        }
    }
    
    public func saveVirtualCard(accountId: String, nickname: String) async throws {
        do {
            let cardNumber = UtilityCard.generateCardNumber()
            let cvc = UtilityCard.generateCVC()
            let expireDate = UtilityCard.generateExpireDate(by: 3)
            let cardName = try await self.generateCardName(accountId: accountId)
            
            guard let cardNumber = cardNumber, let expireDate = expireDate else {
                return
            }
            
            let newCard = CardModel(
                cardId: nil,
                accountId: accountId,
                cardName: cardName,
                cardNumber: cardNumber,
                cvc: cvc,
                expireDate: expireDate,
                isEnabled: true,
                isInternationPurchasesEnabled: true,
                cardType: .virtual,
                nickname: nickname
            )
            
            let newObjRef = db.collection("cards").document()
            try await newObjRef.setData(newCard.dictionary)
        }
        catch {
            throw error
        }
    }
    
    public func getAllCard(accountId: String) async throws -> [CardModel] {
        let q = db.collection("cards").whereField("accountId", isEqualTo: accountId)
        let documents = try? await q.getDocuments()
        
        guard let documents = documents else {
            throw CardError.invalidDocument
        }
        
        if documents.documents.isEmpty {
            throw CardError.invalidAccount
        }
        
        var aux: [CardModel] = []
        for document in documents.documents {
            let data = document.data()
            let accountId = data["accountId"] as? String ?? ""
            let cardName = data["cardName"] as? String ?? ""
            let cardNumber = data["cardNumber"] as? String ?? ""
            let cardType = data["cardType"] as? String ?? ""
            let cvc = data["cvc"] as? String ?? ""
            let expireDate = data["expireDate"] as? String ?? ""
            let isEnabled = data["isEnabled"] as? Bool ?? false
            let isInternationPurchasesEnabled = data["isInternationPurchasesEnabled"] as? Bool ?? false
            let nickname = data["nickname"] as? String ?? ""
            let typeEnum = ECardType(rawValue: cardType) ?? .virtual
            let newObj = CardModel(
                cardId: document.documentID,
                accountId: accountId,
                cardName: cardName,
                cardNumber: cardNumber,
                cvc: cvc,
                expireDate: expireDate,
                isEnabled: isEnabled,
                isInternationPurchasesEnabled: isInternationPurchasesEnabled,
                cardType: typeEnum,
                nickname: nickname
            )
            aux.append(newObj)
        }
        
        return aux
    }
    
    public func updateBlockers(cardId: String, keyName: String, value: Bool) async throws {
        do {
            let newObjRef = db.collection("cards").document(cardId)
            try await newObjRef.updateData([keyName: value])
        }
        catch {
            throw CardError.errorSaving
        }
    }
    
    // Functions Aux
    private func generateCardName(accountId: String) async throws -> String {
        do {
            let fullName = try await self.getCustomerName(accountId: accountId)
            return UtilityCard.generateCardname(fullName: fullName)
        }
        catch {
            throw error
        }
    }
    
    private func getCustomerName(accountId: String) async throws -> String {
        do {
            let customerId = try await getCustomerId(accountId: accountId)
            
            let qCustomer = db.collection("customers").document(customerId)
            let documentCustomer = try? await qCustomer.getDocument()
            
            guard let documentCustomer = documentCustomer else {
                throw CardError.invalidDocument
            }
            
            if !documentCustomer.exists {
                throw CardError.invalidCustomer
            }
            
            let dataCustomer = documentCustomer.data()
            
            return dataCustomer?["fullName"] as? String ?? ""
        }
        catch {
            throw error
        }
    }
    
    private func getCustomerId(accountId: String) async throws -> String {
        let qAccount = db.collection("accounts").document(accountId)
        let documentAccount = try? await qAccount.getDocument()
        
        guard let documentAccount = documentAccount else {
            throw CardError.invalidDocument
        }
        
        if !documentAccount.exists {
            throw CardError.invalidAccount
        }
        
        let dataAccount = documentAccount.data()
        let customerId = dataAccount?["customerId"] as? String ?? ""
        return customerId
    }
}
