//
//  LoginModel.swift
//  Common
//
//  Created by Pinto Junior, William James on 29/11/22.
//

import Foundation

public struct LoginModel {
    public let accountId: String
    public let customerId: String
    public let accountNumber: String
    public let password: String
    
    public var dictionary: [String: Any] {
        return [
            "accountId": accountId,
            "customerId": customerId,
            "accountNumber": accountNumber,
            "password": password
        ]
    }
    
    public init(accountId: String, customerId: String, accountNumber: String, password: String) {
        self.accountId = accountId
        self.customerId = customerId
        self.accountNumber = accountNumber
        self.password = password
    }
}
