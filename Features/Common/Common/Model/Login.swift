//
//  Login.swift
//  Common
//
//  Created by Pinto Junior, William James on 29/11/22.
//

import Foundation

public struct Login {
    public let accountId: String
    public let accountNumber: String
    public let password: String
    
    public var dictionary: [String: Any] {
        return [
            "accountId": accountId,
            "accountNumber": accountNumber,
            "password": password
        ]
    }
    
    public init(accountId: String, accountNumber: String, password: String) {
        self.accountId = accountId
        self.accountNumber = accountNumber
        self.password = password
    }
}
