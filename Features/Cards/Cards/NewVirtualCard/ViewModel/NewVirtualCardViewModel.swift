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
    private let firebaseService: CardNetwork?
    
    // MARK: - Variables
    // MARK: - Closures
    var finishSavingCard: (() -> Void)?
    
    // MARK: - Init
    init(service: CardNetwork = CardService()) {
        self.firebaseService = service
    }
    
    // MARK: - Methods
    func createVirtualCard(accountId: String, nickname: String) async {
        do {
            guard let firebaseService = firebaseService else {
                return
            }
            
            try await firebaseService.saveVirtualCard(accountId: accountId, nickname: nickname)
            self.finishSavingCard?()
        }
        catch {
            print("Unexpected error: \(error).")
        }
    }
}
