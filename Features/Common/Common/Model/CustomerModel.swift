//
//  CustomerModel.swift
//  Common
//
//  Created by Pinto Junior, William James on 29/11/22.
//

import Foundation

public struct CustomerModel {
    public let birthDate: String
    public let cpf: String
    public let email: String
    public let fullName: String
    public let phoneNumber: String
    
    public var dictionary: [String: Any] {
        return [
            "birthDate": birthDate,
            "cpf": cpf,
            "email": email,
            "fullName": fullName,
            "phoneNumber": phoneNumber,
        ]
    }
    
    public init(birthDate: String, cpf: String, email: String, fullName: String, phoneNumber: String) {
        self.birthDate = birthDate
        self.cpf = cpf
        self.email = email
        self.fullName = fullName
        self.phoneNumber = phoneNumber
    }
}
