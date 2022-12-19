//
//  UtilityCard.swift
//  FirebaseService
//
//  Created by Pinto Junior, William James on 16/12/22.
//

import Foundation

class UtilityCard {
    static func generateCardNumber() -> String? {
        let numberLength = 16
        let prefixList = ["71", "72", "73", "74", "75"]
        guard let prefix = prefixList.randomElement() else {
            return nil
        }
        
        var ccNumber = prefix
        while ccNumber.count < (numberLength - 1) {
            ccNumber += String(Int.random(in: 0...9))
        }
        
        let reversedCCNumberString = String(ccNumber.reversed())
        let reversedCCNumber = reversedCCNumberString.compactMap{$0.wholeNumberValue}
        
        var sum = 0
        var pos = 0
        
        while pos < (numberLength - 1) {
            var odd = reversedCCNumber[pos] * 2
            if odd > 9 {
                odd -= 9
            }
            
            sum += odd
            
            if pos != (numberLength - 2) {
                sum += reversedCCNumber[pos + 1]
            }
            pos += 2
        }
            
        let checkdigit = ((Int(floor(Float(sum/10))) + 1) * 10 - sum) % 10
        ccNumber += String(checkdigit);
        return ccNumber;
    }
    
    static func generateCVC() -> String {
        var number = String()
        for _ in 1...3 {
           number += "\(Int.random(in: 1...9))"
        }
        return number
    }
    
    static func generateExpireDate(by numberOfYear: Int) -> String? {
        var components = DateComponents()
        components.setValue(numberOfYear, for: .year)
        
        let now = Date()
        guard let expireDate = Calendar.current.date(byAdding: components, to: now) else {
            return nil
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "pt_BR")
        dateFormatter.dateFormat = "MM/yy"
        return dateFormatter.string(from: expireDate)
    }
}
