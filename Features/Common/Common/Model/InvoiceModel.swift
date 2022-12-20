//
//  InvoiceModel.swift
//  Common
//
//  Created by Pinto Junior, William James on 14/12/22.
//

import Foundation

public class InvoiceModel {
    public let accountId: String
    public let dueDate: String
    public let limitTotal: Double
    public let limitUsed: Double
    
    public var dictionary: [String: Any] {
        return [
            "accountId": accountId,
            "dueDate": dueDate,
            "limitTotal": limitTotal,
            "limitUsed": limitUsed,
        ]
    }
    
    public init(accountId: String, dueDate: String, limitTotal: Double, limitUsed: Double) {
        self.accountId = accountId
        self.dueDate = dueDate
        self.limitTotal = limitTotal
        self.limitUsed = limitUsed
    }
}
