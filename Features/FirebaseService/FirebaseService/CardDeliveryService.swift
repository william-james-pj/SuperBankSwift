//
//  CardDeliveryService.swift
//  FirebaseService
//
//  Created by Pinto Junior, William James on 20/12/22.
//

import Foundation
import Firebase
import Common

public enum CardDeliveryError: Error {
    case errorSaving
    case errorDeliveryDate
    case invalidDocument
    case invalidAccount
}

public class CardDeliveryService: CardDeliveryNetwork {
    // MARK: - Constraints
    private let dataBase = Firestore.firestore()

    // MARK: - Init
    public init() {
    }

    // MARK: - Methods
    public func createDeliveryCard(accountId: String) async throws {
        do {
            try await saveDelivery(accountId: accountId)
            try await saveAccountHasCardDelivery(accountId: accountId)
        } catch {
            throw error
        }
    }

    public func getDeliveryCard(accountId: String) async throws -> CardDeliveryModel {
        let query = dataBase.collection("cardDelivery").whereField("accountId", isEqualTo: accountId)
        let documents = try? await query.getDocuments()

        guard let documents = documents else {
            throw CardDeliveryError.invalidDocument
        }

        if documents.documents.isEmpty {
            throw CardDeliveryError.invalidAccount
        }

        var aux: [CardDeliveryModel] = []
        for document in documents.documents {
            let data = document.data()
            let accountId = data["accountId"] as? String ?? ""
            let deliveryDate = data["deliveryDate"] as? String ?? ""
            let status = data["status"] as? String ?? ""
            let statusEnum = ECardDeliveryStatusType(rawValue: status) ?? .production
            let newObj = CardDeliveryModel(accountId: accountId, deliveryDate: deliveryDate, status: statusEnum)
            aux.append(newObj)
        }

        return aux[0]
    }

    private func saveDelivery(accountId: String) async throws {
        do {
            let date = UtilityCardDelivery.generateDeliveryDate(by: 5)

            guard let date = date else {
                throw CardDeliveryError.errorDeliveryDate
            }

            let cardDelivery = CardDeliveryModel(accountId: accountId, deliveryDate: date, status: .production)

            let newObjRef = dataBase.collection("cardDelivery").document()
            try await newObjRef.setData(cardDelivery.dictionary)
        } catch {
            throw CardDeliveryError.errorSaving
        }
    }

    private func saveAccountHasCardDelivery(accountId: String) async throws {
        do {
            let newObjRef = dataBase.collection("accounts").document(accountId)
            try await newObjRef.updateData(["hasCardDelivery": true])
        } catch {
            throw CardDeliveryError.errorSaving
        }
    }
}
