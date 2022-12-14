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
}

public class CardService {
    // MARK: - Constrants
    let db = Firestore.firestore()
    
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
}
