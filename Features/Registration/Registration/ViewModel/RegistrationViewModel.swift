//
//  RegistrationViewModel.swift
//  Registration
//
//  Created by Pinto Junior, William James on 22/11/22.
//

import Foundation
import Common
import FirebaseService

class RegistrationViewModel {
    // MARK: - Constrants
    static let sharedRegistration = RegistrationViewModel()
    private let firebaseService = RegistrationService()
    
    // MARK: - Variables
    private var fullName: String = ""
    private var cpf: String = ""
    private var birthDate: String = ""
    private var phoneNumber: String = ""
    private var email: String = ""
    
    // MARK: - Closures
    var finishRegister: ((_ login: LoginModel) -> Void)?
    
    // MARK: - Init
    private init() {
        
    }
    
    // MARK: - Methods
    func registerCustomer() async {
        do {
            let customer = CustomerModel(birthDate: birthDate, cpf: cpf, email: email, fullName: fullName, phoneNumber: phoneNumber)
            let login = try await firebaseService.register(customer: customer)
            self.finishRegister?(login)
        }
        catch {
            print("Unexpected error: \(error).")
        }
    }
    
    func validateCPF(_ cpf: String) async -> Bool {
        do {
            let isValid = try await self.firebaseService.validateCPF(cpf)
            
            if isValid {
                self.cpf = cpf
            }
            
            return isValid
        }
        catch {
            print("Unexpected error: \(error).")
            return false
        }
    }
    
    func validateEmail(_ email: String) async -> Bool {
        do {
            let isValid = try await self.firebaseService.validateEmail(email)
            
            if isValid {
                self.email = email
            }
            
            return isValid
        }
        catch {
            print("Unexpected error: \(error).")
            return false
        }
    }
    
    func setName(_ name: String) {
        self.fullName = name
    }
    
    func getFirstAndSecondName() -> String {
        let nameArr = fullName.components(separatedBy: " ")
        if nameArr.count == 1 {
            return nameArr[0]
        }
        return "\(nameArr[0]) \(nameArr[1])"
    }
    
    func setBirthDate(_ birthDate: String) {
        self.birthDate = birthDate
    }
    
    func setPhoneNumber(_ phoneNumber: String) {
        self.phoneNumber = phoneNumber
    }
    
    func getEmail() -> String {
        return self.email
    }
    
}
