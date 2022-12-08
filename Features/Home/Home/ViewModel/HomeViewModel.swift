//
//  HomeViewModel.swift
//  Home
//
//  Created by Pinto Junior, William James on 05/12/22.
//

import Foundation
import FirebaseService
import Common

class HomeViewModel {
    // MARK: - Constrants
    private let firebaseService = HomeService()
    
    // MARK: - Variables
    var customer: Customer?
    
    // MARK: - Closures
    var updateCustomerUI: ((_ customer: Customer) -> Void)?
    var updateAccountUI: ((_ account: Account) -> Void)?
    var updateHideMoney: ((_ isHide: Bool) -> Void)?
    
    // MARK: - Init
    init() {
        self.firebaseService.updateAccount = { account in
            self.updateAccountUI?(account)
        }
    }
    
    // MARK: - Methods
    func getData(customerId: String, accountId: String) async {
        await self.getCustomer(customerId)
        await self.getAccount(accountId)
    }
    
    func getMoneyIsHide() {
        let isHide = HideMoney().getIsHide()
        self.updateHideMoney?(isHide)
    }
    
    func setMoneyIsHide(to isHide: Bool) {
        HideMoney().setIsHide(to: isHide)
        self.updateHideMoney?(isHide)
    }
    
    private func getAccount(_ id: String) async {
        self.firebaseService.getAccount(id)
    }
    
    private func getCustomer(_ id: String) async {
        do {
            let customer = try await self.firebaseService.getCustomer(id)
            self.customer = customer
            self.updateCustomerUI?(customer)
        }
        catch {
            print("Unexpected error: \(error).")
        }
    }
}
