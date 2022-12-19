//
//  JourneyRequestCardViewModel.swift
//  Cards
//
//  Created by Pinto Junior, William James on 08/12/22.
//

import Foundation
import Common
import FirebaseService

class JourneyRequestCardViewModel {
    // MARK: - Constrants
    static let sharedJourneyRequestCard = JourneyRequestCardViewModel()
    private let firebaseService = CardService()
    
    // MARK: - Variables
    private var accountId: String?
    private var creditValue: Double?
    private var invoiceDueDate: String?
    private var cardPin: String?
    
    // MARK: - Closures
    var finishSavingInvoice: (() -> Void)?
    
    // MARK: - Init
    private init() {
    }
    
    // MARK: - Methods
    func createInvoice() async {
        do {
            guard let creditValue = creditValue, let invoiceDueDate = invoiceDueDate, let accountId = accountId, let cardPin = cardPin else {
                return
            }
            
            let newInvoice = InvoiceModel(accountId: accountId, dueDate: invoiceDueDate, limitTotal: creditValue, limitUsed: 0)
            try await self.firebaseService.saveInvoice(newInvoice)
            
            try await self.firebaseService.saveAccountHasCard(accountId: accountId, cardPin: cardPin)
            
            try await self.firebaseService.savePhysicalCard(accountId: accountId)

            self.finishSavingInvoice?()
        }
        catch {
            print("Unexpected error: \(error).")
        }
    }
    
    func generationCreditValue() -> Double {
        if let creditValue = creditValue {
            return creditValue
        }
        let values = [500.0, 700.0, 1000.0, 1300.0, 1500.0, 1800.0, 2000.0, 2500.0, 3000.0]
        let randomInt = Int.random(in: 0..<values.count)
        let credit = values[randomInt]
        self.creditValue = credit
        return credit
    }
    
    func setAccountId(_ accountId: String) {
        self.accountId = accountId
    }
    
    func setCreditValue(_ value: Double) {
        self.creditValue = value
    }
    
    func setInvoiceDueDate(_ invoiceDueDate: String) {
        self.invoiceDueDate = invoiceDueDate
    }
    
    func setCardPin(_ cardPin: String) {
        self.cardPin = cardPin
    }
    
    func getCreditValue() -> String {
        guard let creditValue = creditValue else {
            return ""
        }
        return formatCurrency(creditValue)
    }
    
    func getDueDate() -> String {
        guard let invoiceDueDate = invoiceDueDate else {
            return ""
        }

        return invoiceDueDate
    }
    
    func formatCurrency(_ number: Double) -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale.init(identifier: "pt_BR")
        formatter.numberStyle = .currency
        if let formattedTipAmount = formatter.string(from: number as NSNumber) {
            return "\(formattedTipAmount)"
        }
        return ""
    }
}
