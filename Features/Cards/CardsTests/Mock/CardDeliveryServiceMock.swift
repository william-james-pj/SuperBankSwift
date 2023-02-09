//
//  CardDeliveryServiceMock.swift
//  CardsTests
//
//  Created by Pinto Junior, William James on 27/12/22.
//

import Foundation
import Common
import FirebaseService

class CardDeliveryServiceMock: CardDeliveryNetwork {
    func createDeliveryCard(accountId: String) async throws {

    }

    func getDeliveryCard(accountId: String) async throws -> CardDeliveryModel {
        return CardDeliveryModel(accountId: "", deliveryDate: "", status: .delivered)
    }

}
