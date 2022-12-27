//
//  MyCardsViewModel.swift
//  Cards
//
//  Created by Pinto Junior, William James on 16/12/22.
//

import Foundation
import Common
import FirebaseService

class MyCardsViewModel {
    // MARK: - Constrants
    private let firebaseService: CardNetwork?
    
    // MARK: - Variables
    // MARK: - Closures
    var finishGetCards: ((_ physicalCards: [CardModel], _ virtualCards: [CardModel]) -> Void)?
    
    // MARK: - Init
    init(service: CardNetwork = CardService()) {
        self.firebaseService = service
    }
    
    // MARK: - Methods
    func getCards(accountId: String) async {
        do {
            guard let firebaseService = firebaseService else {
                return
            }
            
            let cards = try await firebaseService.getAllCard(accountId: accountId)
            
            let physicalCards = cards.filter { $0.cardType == .physical }
            let virtualCards = cards.filter { $0.cardType == .virtual }
            
            finishGetCards?(physicalCards, virtualCards)
        }
        catch {
            print("Unexpected error: \(error).")
        }
    }
}
