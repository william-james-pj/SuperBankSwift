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
    
    // MARK: - Variables
    private var firebaseService: RegistrationNetwork!
    
    private var fullName: String = ""
    private var cpf: String = ""
    private var birthDate: String = ""
    private var phoneNumber: String = ""
    private var email: String = ""
    
    // MARK: - Closures
    var finishRegister: ((_ login: LoginModel) -> Void)?
    
    // MARK: - Init
    init(service: RegistrationNetwork = RegistrationService()) {
        self.firebaseService = service
    }
    
    // MARK: - Methods
    func registerCustomer() async {
        do {
            let customer = CustomerModel(birthDate: birthDate, cpf: cpf, email: email, fullName: fullName, phoneNumber: phoneNumber)
            let login = try await self.firebaseService.register(customer: customer)
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
    
    func validateName(_ name: String) -> Bool {
        let textArr = name.components(separatedBy: " ")
        if textArr.count == 1 {
            return false
        }
        let length = textArr[1].count
        if length < 3 {
            return false
        }
        return true
    }
    
    func formartCPFMask(_ cpf: String) -> String {
        let cleanCPF = cpf.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        self.cpf = cleanCPF
        let mask = "###.###.###-##"
        var result = ""
        var index = cleanCPF.startIndex
        for ch in mask where index < cleanCPF.endIndex {
            if ch == "#" {
                result.append(cleanCPF[index])
                index = cleanCPF.index(after: index)
            } else {
                result.append(ch)
            }
        }
        return result
    }
    
    func formartBirthDateMask(_ birthDate: String) -> String {
        let cleanBirthDate = birthDate.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        self.birthDate = cleanBirthDate
        let mask = "##/##/####"
        var result = ""
        var index = cleanBirthDate.startIndex
        for ch in mask where index < cleanBirthDate.endIndex {
            if ch == "#" {
                result.append(cleanBirthDate[index])
                index = cleanBirthDate.index(after: index)
            } else {
                result.append(ch)
            }
        }
        return result
    }
    
    func formartPhoneNumberMask(_ phoneNumber: String) -> String {
        let cleanPhoneNumber = phoneNumber.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        self.phoneNumber = cleanPhoneNumber
        let mask = "(##) #####-####"
        var result = ""
        var index = cleanPhoneNumber.startIndex
        for ch in mask where index < cleanPhoneNumber.endIndex {
            if ch == "#" {
                result.append(cleanPhoneNumber[index])
                index = cleanPhoneNumber.index(after: index)
            } else {
                result.append(ch)
            }
        }
        return result
    }
    
    func validateEmailMask(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        if emailPred.evaluate(with: email) {
            return true
        }
        return false
    }
}
