//
//  CardDetailsViewModel.swift
//  Cards
//
//  Created by Pinto Junior, William James on 22/12/22.
//

import Foundation
import Common
import FirebaseService

class CardDetailsViewModel {
    // MARK: - ConstraintsCharacters
    private let firebaseService: CardNetwork!

    // MARK: - Variables
    // MARK: - Closures
    var finishUpdateCard: (() -> Void)?

    // MARK: - Init
    init(service: CardNetwork = CardService()) {
        self.firebaseService = service
    }

    // MARK: - Methods
    func updateBlockerCard(cardId: String, keyName: String, value: Bool) async {
        do {
            try await self.firebaseService.updateBlockers(cardId: cardId, keyName: keyName, value: value)
            self.finishUpdateCard?()
        } catch {
            print("Unexpected error: \(error).")
        }
    }
}
