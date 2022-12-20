//
//  UtilityCardDelivery.swift
//  FirebaseService
//
//  Created by Pinto Junior, William James on 20/12/22.
//

import Foundation

class UtilityCardDelivery {
    
    static func generateDeliveryDate(by numberOfDate: Int) -> String? {
        var components = DateComponents()
        components.setValue(numberOfDate, for: .day)
        
        let now = Date()
        guard let expireDate = Calendar.current.date(byAdding: components, to: now) else {
            return nil
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "pt_BR")
        dateFormatter.dateFormat = "dd/MM"
        return dateFormatter.string(from: expireDate)
    }
}
