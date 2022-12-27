//
//  CardDeliveryNetwork.swift
//  FirebaseService
//
//  Created by Pinto Junior, William James on 27/12/22.
//

import Foundation
import Common

public protocol CardDeliveryNetwork {
    func createDeliveryCard(accountId: String) async throws
    func getDeliveryCard(accountId: String) async throws -> CardDeliveryModel
}
