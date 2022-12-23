//
//  CardModel.swift
//  Common
//
//  Created by Pinto Junior, William James on 16/12/22.
//

import Foundation

public enum ECardType: String {
    case physical = "physical"
    case virtual = "virtual"
}

public struct CardModel {
    public let cardId: String?
    public let accountId: String
    public let cardName: String
    public let cardNumber: String
    public let cvc: String
    public let expireDate: String
    public let isEnabled: Bool
    public let isInternationPurchasesEnabled: Bool
    public let cardType: ECardType
    public let nickname: String
    
    public var dictionary: [String: Any] {
        return [
            "accountId": accountId,
            "cardName": cardName,
            "cardNumber": cardNumber,
            "cvc": cvc,
            "expireDate": expireDate,
            "isEnabled": isEnabled,
            "isInternationPurchasesEnabled": isInternationPurchasesEnabled,
            "cardType": cardType.rawValue,
            "nickname": nickname,
        ]
    }
    
    public init(cardId: String?, accountId: String, cardName: String, cardNumber: String, cvc: String, expireDate: String, isEnabled: Bool, isInternationPurchasesEnabled: Bool, cardType: ECardType, nickname: String) {
        self.cardId = cardId
        self.accountId = accountId
        self.cardName = cardName
        self.cardNumber = cardNumber
        self.cvc = cvc
        self.expireDate = expireDate
        self.isEnabled = isEnabled
        self.isInternationPurchasesEnabled = isInternationPurchasesEnabled
        self.cardType = cardType
        self.nickname = nickname
    }
}
