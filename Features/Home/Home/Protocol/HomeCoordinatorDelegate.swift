//
//  HomeCoordinatorDelegate.swift
//  Home
//
//  Created by Pinto Junior, William James on 02/12/22.
//

import Foundation

public protocol HomeCoordinatorDelegate: AnyObject {
    func goToDrawerMenu()
    func closeDrawerMenu()
    func logoff()
    
    func goToCard(hasCard: Bool)
}
