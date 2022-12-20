//
//  NewVirtualCardViewModel.swift
//  Cards
//
//  Created by Pinto Junior, William James on 16/12/22.
//

import Foundation
import FirebaseService

class NewVirtualCardViewModel {
    // MARK: - Constrants
    private let firebaseService = CardService()
    
    // MARK: - Variables
    // MARK: - Closures
    var finishSavingCard: (() -> Void)?
    
    // MARK: - Init
    init() {
    }
    
    // MARK: - Methods
    func createVirtualCard(accountId: String, nickname: String) async {
        do {
            try await self.firebaseService.saveVirtualCard(accountId: accountId, nickname: nickname)
            self.finishSavingCard?()
        }
        catch {
            print("Unexpected error: \(error).")
        }
    }
}
