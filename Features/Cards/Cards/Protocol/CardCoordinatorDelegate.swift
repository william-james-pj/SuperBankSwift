//
//  CardCoordinatorDelegate.swift
//  Cards
//
//  Created by Pinto Junior, William James on 06/12/22.
//

import Foundation
import Common

public protocol CardCoordinatorDelegate: AnyObject {
    func goToPresentCard()
    func goToCreditLimit()
    func goToInvoiceDueDate()
    func goToCardPin()
    func goToCardTerm()
    func goToRequestCardResume()
    func goToCompletedRequestCard()
    func finalizeRequest()

    func goToMyCards()
    func goToCardDetails(_ card: CardModel, delegate: CardDetailsVCDelegate)

    func goToNewVirtualCard(_ delegate: NewVirtualCardVCDelegate)
    func finalizeSavingCard()
}
