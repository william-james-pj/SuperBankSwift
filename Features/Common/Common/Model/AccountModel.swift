//
//  AccountModel.swift
//  Common
//
//  Created by Pinto Junior, William James on 29/11/22.
//

import Foundation

public struct AccountModel {
    public let accountNumber: String
    public let balance: Double
    public let customerId: String
    public let openDate: String
    public let hasCard: Bool
    public let cardPin: String
    
    public var dictionary: [String: Any] {
        return [
            "accountNumber": accountNumber,
            "balance": balance,
            "customerId": customerId,
            "openDate": openDate,
            "hasCard": hasCard,
            "cardPin": cardPin
        ]
    }
    
    public init(accountNumber: String, balance: Double, customerId: String, openDate: String, hasCard: Bool, cardPin: String) {
        self.accountNumber = accountNumber
        self.balance = balance
        self.customerId = customerId
        self.openDate = openDate
        self.hasCard = hasCard
        self.cardPin = cardPin
    }
}
