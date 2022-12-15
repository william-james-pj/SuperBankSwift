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
    private var customerId: String?
    private var accountId: String?
    private var customer: CustomerModel?
    private var account: AccountModel?
    
    // MARK: - Closures
    var updateCustomerUI: ((_ customer: CustomerModel) -> Void)?
    var updateAccountUI: ((_ account: AccountModel) -> Void)?
    var updateHideMoney: ((_ isHide: Bool) -> Void)?
    var updateHasCard: ((_ hasCard: Bool) -> Void)?
    
    // MARK: - Init
    init() {
    }
    
    // MARK: - Methods
    func reloadAccount() async {
        guard let accountId = accountId else {
            return
        }
        await self.getAccount(accountId)
    }
    
    func getData(customerId: String, accountId: String) async {
        self.customerId = customerId
        self.accountId = accountId
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
        do {
            let account = try await self.firebaseService.getAccount(id)
            self.account = account
            self.updateAccountUI?(account)
        }
        catch {
            print("Unexpected error: \(error).")
        }
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
