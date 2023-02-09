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
    // MARK: - Constraints
    private let firebaseService: HomeNetwork!
    private let cardDeliveryService: CardDeliveryNetwork!

    // MARK: - Variables
    private var customerId: String?
    private var accountId: String?
    private var customer: CustomerModel?
    private var account: AccountModel?
    private var cardDeliver: CardDeliveryModel?

    // MARK: - Closures
    var updateCustomerUI: ((_ customer: CustomerModel) -> Void)?
    var updateAccountUI: ((_ account: AccountModel) -> Void)?
    var updateHideMoney: ((_ isHide: Bool) -> Void)?
    var updateCardDelivery: ((_ cardDelivery: CardDeliveryModel) -> Void)?

    // MARK: - Init
    init(service: HomeNetwork = HomeService(), deliveryService: CardDeliveryNetwork = CardDeliveryService()) {
        self.firebaseService = service
        self.cardDeliveryService = deliveryService
    }

    // MARK: - Methods
    func reloadAccount() async {
        guard let accountId = accountId else {
            return
        }
        await self.getAccount(accountId)
        await self.getCardDelivery()
    }

    func getData(customerId: String, accountId: String) async {
        self.customerId = customerId
        self.accountId = accountId
        await self.getCustomer(customerId)
        await self.getAccount(accountId)
        await self.getCardDelivery()
    }

    func getMoneyIsHide() {
        let isHide = UtilityHideMoney.getIsHide()
        self.updateHideMoney?(isHide)
    }

    func setMoneyIsHide(to isHide: Bool) {
        UtilityHideMoney.setIsHide(to: isHide)
        self.updateHideMoney?(isHide)
    }

    private func getAccount(_ id: String) async {
        do {
            let account = try await self.firebaseService.getAccount(id)
            self.account = account
            self.updateAccountUI?(account)
        } catch {
            print("Unexpected error: \(error).")
        }
    }

    private func getCustomer(_ id: String) async {
        do {
            let customer = try await self.firebaseService.getCustomer(id)
            self.customer = customer
            self.updateCustomerUI?(customer)
        } catch {
            print("Unexpected error: \(error).")
        }
    }

    private func getCardDelivery() async {
        do {
            guard let account = account, let accountId = accountId else {
                return
            }

            if !account.hasCardDelivery {
                return
            }

            let cardDelivery = try await self.cardDeliveryService.getDeliveryCard(accountId: accountId)
            self.cardDeliver = cardDelivery
            self.updateCardDelivery?(cardDelivery)
        } catch {
            print("Unexpected error: \(error).")
        }
    }
}
