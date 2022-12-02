//
//  LoginViewModel.swift
//  Login
//
//  Created by Pinto Junior, William James on 30/11/22.
//

import Foundation
import Common
import RxSwift
import FirebaseService

class LoginViewModel {
    // MARK: - Constrants
    private let firebaseService = LoginService()
    
    // MARK: - Variables
    private var loginSaved: Login?
    private var typedPassword: [ButtonPasswordText] = []
    
    // MARK: - Closures
    var updateAccountUI: ((_ customerName: String, _ accountNumber: String) -> Void)?
    var updatePasswordTextField: ((_ isRemoving: Bool) -> Void)?
    var finalizedPassword: (() -> Void)?
    var loggedIn: (() -> Void)?
    var invalidPassword: (() -> Void)?
    
    // MARK: - Init
    init() {
    }
    
    // MARK: - Methods
    func setTypedPassword(_ character: ButtonPasswordText) {
        self.typedPassword.append(character)
        self.updatePasswordTextField?(false)
        
        if typedPassword.count == 5 {
            self.finalizedPassword?()
        }
    }
    
    func removeLastTypedPassword() {
        if self.typedPassword.count == 0 {
            return
        }
        self.typedPassword.removeLast()
        self.updatePasswordTextField?(true)
    }
    
    func logIn() {
        let isLoggedIn = self.validatePassword()
        
        if !isLoggedIn {
            self.invalidPassword?()
            self.typedPassword = []
            return
        }
        
        self.loggedIn?()
    }
    
    func getAccount(_ accountNumber: String) async {
        self.loginSaved = nil
        do {
            let login = try await firebaseService.getLogin(accountNumber)
            let fullName = try await firebaseService.getCustomerName(login.customerId)
            self.updateAccountUI?(fullName, login.accountNumber)
            self.loginSaved = login
        }
        catch LoginError.invalidAccount {
            print("invalidAccount")
        }
        catch {
            print("Unexpected error: \(error).")
        }
    }
    
    private func validatePassword() -> Bool {
        guard let correctPassword = self.loginSaved?.password else {
            return false
        }
        
        var isCorrect: [Bool] = []
        
        for (index, char) in correctPassword.enumerated() {
            if String(char) == "\(typedPassword[index].first)"
                || String(char) == "\(typedPassword[index].second)" {
                isCorrect.append(true)
                continue
            }
            isCorrect.append(false)
        }
        
        return !isCorrect.contains(false)
    }
}
