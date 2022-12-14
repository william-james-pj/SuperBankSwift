//
//  CardCoordinatorDelegate.swift
//  Cards
//
//  Created by Pinto Junior, William James on 06/12/22.
//

import Foundation

public protocol CardCoordinatorDelegate: AnyObject {
    func goToPresentCard()
    func goToCreditLimit()
    func goToInvoiceDueDate()
    func goToCardPin()
    func goToCardTerm()
    func goToRequestCardResume()
    func goToCompledRequestCard()
    func finalizeRequest()
    
    func goToMyCards()
}
