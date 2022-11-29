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
    
    var finishRegister: ((_ login: Login) -> Void)?
    
    // MARK: - Init
    private init() {
        
    }
    
    // MARK: - Methods
    func registerCustomer() {
        let customer = Customer(birthDate: birthDate, cpf: cpf, email: email, fullName: fullName, phoneNumber: phoneNumber)
        let login = firebaseService.register(customer: customer)
        self.finishRegister?(login)
    }
    
    func validateCPF(_ cpf: String) async -> Bool {
        let isValid = await self.firebaseService.validateCPF(cpf)
        
        if isValid {
            self.cpf = cpf
        }
        
        return isValid
    }
    
    func validateEmail(_ email: String) async -> Bool {
        let isValid = await self.firebaseService.validateEmail(email)
        
        if isValid {
            self.email = email
        }
        
        return isValid
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
