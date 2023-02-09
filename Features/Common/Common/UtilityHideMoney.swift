//
//  UtilityHideMoney.swift
//  Common
//
//  Created by Pinto Junior, William James on 06/12/22.
//

import Foundation

public class UtilityHideMoney {
    // MARK: - Methods
    static public func getIsHide() -> Bool {
        let userDefaults = UserDefaults.standard
        do {
            let isHide = try userDefaults.getObject(forKey: "moneyIsHide", castTo: Bool.self)
            return isHide
        } catch {
            return true
        }
    }

    static public func setIsHide(to isHide: Bool) {
        let userDefaults = UserDefaults.standard
        do {
            try userDefaults.setObject(isHide, forKey: "moneyIsHide")
        } catch {
            print("Error saving moneyIsHide")
        }
    }
}
