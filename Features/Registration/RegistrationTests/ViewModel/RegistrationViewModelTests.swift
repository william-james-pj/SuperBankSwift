//
//  RegistrationViewModelTests.swift
//  RegistrationTests
//
//  Created by Pinto Junior, William James on 27/12/22.
//

import XCTest
@testable import Registration

class RegistrationViewModelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testRegisterCustomer_WhenValidCustomerProvided_ShouldCallFinishRegister() async {
        // Given
        let modelView = RegistrationViewModel.sharedRegistration
        modelView.settingFirebaseService(service: RegistrationServiceMock())
        
        var hasCalled = false
        modelView.finishRegister = { _ in
            hasCalled = true
        }
        
        // When
        modelView.setName("João Pedro")
        await modelView.registerCustomer()
        
        // Then
        XCTAssertTrue(hasCalled)
    }
    
    func testRegisterCustomer_WhenInvalidCustomerProvided_ShouldNotCallFinishRegister() async {
        // Given
        let modelView = RegistrationViewModel.sharedRegistration
        modelView.settingFirebaseService(service: RegistrationServiceMock())
        
        var hasCalled = false
        modelView.finishRegister = { _ in
            hasCalled = true
        }
        
        // When
        modelView.setName("")
        await modelView.registerCustomer()
        
        // Then
        XCTAssertFalse(hasCalled)
    }
    
    func testValidateCPF_WhenValidCPFProvided_ShouldReturnTrue() async {
        // Given
        let modelView = RegistrationViewModel.sharedRegistration
        modelView.settingFirebaseService(service: RegistrationServiceMock())
        
        // When
        let isValid = await modelView.validateCPF("11111111111")
        
        // Then
        XCTAssertTrue(isValid)
    }
    
    func testValidateCPF_WhenInvalidCPFProvided_ShouldReturnFalse() async {
        // Given
        let modelView = RegistrationViewModel.sharedRegistration
        modelView.settingFirebaseService(service: RegistrationServiceMock())
        
        // When
        let isValid = await modelView.validateCPF("1111111")
        
        // Then
        XCTAssertFalse(isValid)
    }
    
    func testValidateEmail_WhenValidEmailProvided_ShouldReturnTrue() async {
        // Given
        let modelView = RegistrationViewModel.sharedRegistration
        modelView.settingFirebaseService(service: RegistrationServiceMock())
        
        // When
        let isValid = await modelView.validateEmail("email@aa.aaa")
        
        // Then
        XCTAssertTrue(isValid)
    }
    
    func testValidateEmail_WhenInvalidEmailProvided_ShouldReturnFalse() async {
        // Given
        let modelView = RegistrationViewModel.sharedRegistration
        modelView.settingFirebaseService(service: RegistrationServiceMock())
        
        // When
        let isValid = await modelView.validateEmail("invalidemail@aa.aaa")
        
        // Then
        XCTAssertFalse(isValid)
    }
    
    func testGetFirstAndSecondName_WhenOneNameProvided_ShouldReturnFirstName() {
        // Given
        let modelView = RegistrationViewModel.sharedRegistration
        modelView.settingFirebaseService(service: RegistrationServiceMock())
        let fullName = "João"
        
        // When
        modelView.setName(fullName)
        let nameAbbreviation = modelView.getFirstAndSecondName()
        
        // Then
        XCTAssertEqual(nameAbbreviation, "João")
    }

    func testGetFirstAndSecondName_WhenTwoNameProvided_ShouldReturnFirstAndSecondName() {
        // Given
        let modelView = RegistrationViewModel.sharedRegistration
        modelView.settingFirebaseService(service: RegistrationServiceMock())
        let fullName = "João Pedro"
        
        // When
        modelView.setName(fullName)
        let nameAbbreviation = modelView.getFirstAndSecondName()
        
        // Then
        XCTAssertEqual(nameAbbreviation, "João Pedro")
    }
    
    func testGetFirstAndSecondName_WhenThreeNameProvided_ShouldReturnFirstAndSecondName() {
        // Given
        let modelView = RegistrationViewModel.sharedRegistration
        modelView.settingFirebaseService(service: RegistrationServiceMock())
        let fullName = "João Pedro Victor"
        
        // When
        modelView.setName(fullName)
        let nameAbbreviation = modelView.getFirstAndSecondName()
        
        // Then
        XCTAssertEqual(nameAbbreviation, "João Pedro")
    }
    
    func testValidateName_WhenValidNameProvided_ShouldReturnTrue() {
        // Given
        let modelView = RegistrationViewModel.sharedRegistration
        modelView.settingFirebaseService(service: RegistrationServiceMock())
        let fullName = "João Pedro"
        
        // When
        let isValid = modelView.validateName(fullName)
        
        // Then
        XCTAssertTrue(isValid)
    }
    
    func testValidateName_WhenInvalidNameProvided_ShouldReturnFalse() {
        // Given
        let modelView = RegistrationViewModel.sharedRegistration
        modelView.settingFirebaseService(service: RegistrationServiceMock())
        let fullName = "João"
        
        // When
        let isValid = modelView.validateName(fullName)
        
        // Then
        XCTAssertFalse(isValid)
    }
    
    func testValidateName_WhenShortNameProvided_ShouldReturnFalse() {
        // Given
        let modelView = RegistrationViewModel.sharedRegistration
        modelView.settingFirebaseService(service: RegistrationServiceMock())
        let fullName = "João Pe"
        
        // When
        let isValid = modelView.validateName(fullName)
        
        // Then
        XCTAssertFalse(isValid)
    }
    
    func testFormartCPFMask_WhenValidCPFProvided_ShouldReturnFormatted() {
        // Given
        let modelView = RegistrationViewModel.sharedRegistration
        modelView.settingFirebaseService(service: RegistrationServiceMock())
        let cpf = "11111111111"
        
        // When
        let cpfFormatted = modelView.formartCPFMask(cpf)
        
        // Then
        XCTAssertEqual(cpfFormatted, "111.111.111-11")
    }
    
    func testFormartCPFMask_WhenShortCPFProvided_ShouldReturnFormatted() {
        // Given
        let modelView = RegistrationViewModel.sharedRegistration
        modelView.settingFirebaseService(service: RegistrationServiceMock())
        let cpf = "111111"
        
        // When
        let cpfFormatted = modelView.formartCPFMask(cpf)
        
        // Then
        XCTAssertEqual(cpfFormatted, "111.111")
    }
    
    func testFormartBirthDateMask_WhenValidBirthDateProvided_ShouldReturnFormatted() {
        // Given
        let modelView = RegistrationViewModel.sharedRegistration
        modelView.settingFirebaseService(service: RegistrationServiceMock())
        let birthDate = "02012022"
        
        // When
        let birthDateFormatted = modelView.formartBirthDateMask(birthDate)
        
        // Then
        XCTAssertEqual(birthDateFormatted, "02/01/2022")
    }
    
    func testFormartBirthDateMask_WhenShortBirthDateProvided_ShouldReturnFormatted() {
        // Given
        let modelView = RegistrationViewModel.sharedRegistration
        modelView.settingFirebaseService(service: RegistrationServiceMock())
        let birthDate = "0201"
        
        // When
        let birthDateFormatted = modelView.formartBirthDateMask(birthDate)
        
        // Then
        XCTAssertEqual(birthDateFormatted, "02/01")
    }
    
    func testFormartPhoneNumberMask_WhenValidPhoneNumberProvided_ShouldReturnFormatted() {
        // Given
        let modelView = RegistrationViewModel.sharedRegistration
        modelView.settingFirebaseService(service: RegistrationServiceMock())
        let phoneNumber = "11111111111"
        
        // When
        let phoneNumberFormatted = modelView.formartPhoneNumberMask(phoneNumber)
        
        // Then
        XCTAssertEqual(phoneNumberFormatted, "(11) 11111-1111")
    }
    
    func testFormartPhoneNumberMask_WhenShortPhoneNumberProvided_ShouldReturnFormatted() {
        // Given
        let modelView = RegistrationViewModel.sharedRegistration
        modelView.settingFirebaseService(service: RegistrationServiceMock())
        let phoneNumber = "1111111"
        
        // When
        let phoneNumberFormatted = modelView.formartPhoneNumberMask(phoneNumber)
        
        // Then
        XCTAssertEqual(phoneNumberFormatted, "(11) 11111")
    }
    
    func testValidateEmail_WhenValidEmailProvided_ShouldReturnTrue() {
        // Given
        let modelView = RegistrationViewModel.sharedRegistration
        modelView.settingFirebaseService(service: RegistrationServiceMock())
        let email = "meuemail@gmail.com"
        
        // When
        let isValid = modelView.validateName(email)
        
        // Then
        XCTAssertTrue(isValid)
    }
    
    func testValidateEmail_WhenInvalidEmailProvided_ShouldReturnFalse() {
        // Given
        let modelView = RegistrationViewModel.sharedRegistration
        modelView.settingFirebaseService(service: RegistrationServiceMock())
        let email = "meuemailemail.com"
        
        // When
        let isValid = modelView.validateName(email)
        
        // Then
        XCTAssertFalse(isValid)
    }
}
