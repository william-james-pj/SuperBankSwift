//
//  CardNetwork.swift
//  FirebaseService
//
//  Created by Pinto Junior, William James on 27/12/22.
//

import Foundation
import Common

public protocol CardNetwork {
    func saveInvoice(_ invoice: InvoiceModel) async throws
    func saveAccountHasCard(accountId: String, cardPin: String) async throws
    func savePhysicalCard(accountId: String) async throws
    func saveVirtualCard(accountId: String, nickname: String) async throws
    func getAllCard(accountId: String) async throws -> [CardModel]
    func updateBlockers(cardId: String, keyName: String, value: Bool) async throws
}
