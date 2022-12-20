//
//  Date+extension.swift
//  Common
//
//  Created by Pinto Junior, William James on 20/12/22.
//

import Foundation

extension Date {
    public func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
}
