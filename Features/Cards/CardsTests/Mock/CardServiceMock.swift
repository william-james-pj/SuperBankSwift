//
//  CardServiceMock.swift
//  CardsTests
//
//  Created by Pinto Junior, William James on 27/12/22.
//

import Foundation
import FirebaseService
import Common

class CardServiceMock: CardNetwork {
    func saveInvoice(_ invoice: InvoiceModel) async throws {

    }

    func saveAccountHasCard(accountId: String, cardPin: String) async throws {

    }

    func savePhysicalCard(accountId: String) async throws {

    }

    func saveVirtualCard(accountId: String, nickname: String) async throws {
        if accountId == "" {
            throw CardError.errorSaving
        }
    }

    func getAllCard(accountId: String) async throws -> [CardModel] {
        let card1 = CardModel(
            cardId: "",
            accountId: "",
            cardName: "",
            cardNumber: "",
            cvc: "",
            expireDate: "",
            isEnabled: true,
            isInternationalPurchasesEnabled: true,
            cardType: .physical,
            nickname: ""
        )
        let card2 = CardModel(
            cardId: "",
            accountId: "",
            cardName: "",
            cardNumber: "",
            cvc: "",
            expireDate: "",
            isEnabled: true,
            isInternationalPurchasesEnabled: true,
            cardType: .virtual,
            nickname: ""
        )
        return [card1, card2]
    }

    func updateBlockers(cardId: String, keyName: String, value: Bool) async throws {
        if cardId == "" {
            throw CardError.errorSaving
        }
    }

}
