//
//  CardDeliveryModel.swift
//  Common
//
//  Created by Pinto Junior, William James on 20/12/22.
//

import Foundation

public enum ECardDeliveryStatusType: String {
    case production = "production"
    case delivery = "delivery"
    case delivered = "delivered"
}

public struct CardDeliveryModel {
    public let accountId: String
    public let deliveryDate: String
    public let status: ECardDeliveryStatusType
    
    public var dictionary: [String: Any] {
        return [
            "accountId": accountId,
            "deliveryDate": deliveryDate,
            "status": status.rawValue,
        ]
    }
    
    public init(accountId: String, deliveryDate: String, status: ECardDeliveryStatusType) {
        self.accountId = accountId
        self.deliveryDate = deliveryDate
        self.status = status
    }
}
