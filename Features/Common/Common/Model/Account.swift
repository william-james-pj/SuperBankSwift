//
//  Account.swift
//  Common
//
//  Created by Pinto Junior, William James on 29/11/22.
//

import Foundation

public struct Account {
    public let accountNumber: String
    public let balance: Double
    public let customerId: String
    public let openDate: String
    
    public var dictionary: [String: Any] {
        return [
            "accountNumber": accountNumber,
            "balance": balance,
            "customerId": customerId,
            "openDate": openDate,
        ]
    }
    
    public init(accountNumber: String, balance: Double, customerId: String, openDate: String) {
        self.accountNumber = accountNumber
        self.balance = balance
        self.customerId = customerId
        self.openDate = openDate
    }
}
