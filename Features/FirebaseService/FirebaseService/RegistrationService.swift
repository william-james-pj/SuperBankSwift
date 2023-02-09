//
//  RegistrationService.swift
//  FirebaseService
//
//  Created by Pinto Junior, William James on 22/11/22.
//

import Foundation
import Common
import Firebase

public enum RegistrationError: Error {
    case invalidCPF
    case invalidEmail
    case invalidDocument
    case errorSaving
}

public class RegistrationService: RegistrationNetwork {
    // MARK: - Constraints
    private let dataBase = Firestore.firestore()

    // MARK: - Init
    public init() {
    }

    // MARK: - Methods
    public func register(customer: CustomerModel) async throws -> LoginModel {
        do {
        let id = try await self.saveCustomer(customer)

        let account = self.createAccount(id)
        let accountId = try await self.saveAccount(account)

        let login = self.createLogin(accountId, id, account.accountNumber)
        try await self.saveLogin(login)
        return login
        } catch {
            throw error
        }
    }

    public func validateCPF(_ cpf: String) async throws -> Bool {
        let query = dataBase.collection("customers").whereField("cpf", isEqualTo: cpf)
        let snapshot = try? await query.getDocuments()

        guard let snapshot = snapshot else {
            throw RegistrationError.invalidCPF
        }

        if snapshot.documents.count > 0 {
            return false
        }
        return true
    }

    public func validateEmail(_ email: String) async throws -> Bool {
        let query = dataBase.collection("customers").whereField("email", isEqualTo: email)
        let snapshot = try? await query.getDocuments()

        guard let snapshot = snapshot else {
            throw RegistrationError.invalidEmail
        }

        if snapshot.documents.count > 0 {
            return false
        }
        return true
    }

    private func saveCustomer(_ customer: CustomerModel) async throws -> String {
        do {
            let newObjRef = dataBase.collection("customers").document()
            try await newObjRef.setData(customer.dictionary)
            return newObjRef.documentID
        } catch {
            throw RegistrationError.errorSaving
        }
    }

    private func saveAccount(_ account: AccountModel) async throws -> String {
        do {
            let newObjRef = dataBase.collection("accounts").document()
            try await newObjRef.setData(account.dictionary)
            return newObjRef.documentID
        } catch {
            throw RegistrationError.errorSaving
        }
    }

    private func saveLogin(_ login: LoginModel) async throws {
        do {
            let newObjRef = dataBase.collection("login").document()
            try await newObjRef.setData(login.dictionary)
        } catch {
            throw RegistrationError.errorSaving
        }
    }

    private func createAccount(_ customerId: String) -> AccountModel {
        let code = self.generateAccountCode(7)
        let date = getCurrentDate()

        let newAccount = AccountModel(
            accountNumber: code,
            balance: 0,
            customerId: customerId,
            openDate: date,
            hasCard: false,
            cardPin: "",
            hasCardDelivery: false
        )
        return newAccount
    }

    private func createLogin(_ accountId: String, _ customerId: String, _ accountCode: String) -> LoginModel {
        let password = generateAccountCode(5)

        let newLogin = LoginModel(
            accountId: accountId,
            customerId: customerId,
            accountNumber: accountCode,
            password: password
        )
        return newLogin
    }

    private func generateAccountCode(_ digits: Int) -> String {
        var number = String()
        for _ in 1...digits {
            number += "\(Int.random(in: 1...9))"
        }
        return number
    }

    private func getCurrentDate() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/y HH:mm:ss"
        return dateFormatter.string(from: date)
    }
}
