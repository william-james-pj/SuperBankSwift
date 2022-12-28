//
//  RegistrationViewModelTests.swift
//  RegistrationTests
//
//  Created by Pinto Junior, William James on 27/12/22.
//

import XCTest
@testable import Registration

class RegistrationViewModelTests: XCTestCase {
    
    var viewModel: RegistrationViewModel!

    override func setUpWithError() throws {
        viewModel = RegistrationViewModel(service: RegistrationServiceMock())
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }
    
    func testRegisterCustomer_WhenValidCustomerProvided_ShouldCallFinishRegister() async {
        // Given
        var hasCalled = false
        viewModel.finishRegister = { _ in
            hasCalled = true
        }
        
        // When
        viewModel.setName("João Pedro")
        await viewModel.registerCustomer()
        
        // Then
        XCTAssertTrue(hasCalled)
    }
    
    func testRegisterCustomer_WhenInvalidCustomerProvided_ShouldNotCallFinishRegister() async {
        // Given
        var hasCalled = false
        viewModel.finishRegister = { _ in
            hasCalled = true
        }
        
        // When
        viewModel.setName("")
        await viewModel.registerCustomer()
        
        // Then
        XCTAssertFalse(hasCalled)
    }
    
    func testValidateCPF_WhenValidCPFProvided_ShouldReturnTrue() async {
        // Given
        let cpf = "11111111111"
        
        // When
        let isValid = await viewModel.validateCPF(cpf)
        
        // Then
        XCTAssertTrue(isValid)
    }
    
    func testValidateCPF_WhenInvalidCPFProvided_ShouldReturnFalse() async {
        // Given
        let cpf = "1111111"

        // When
        let isValid = await viewModel.validateCPF(cpf)
        
        // Then
        XCTAssertFalse(isValid)
    }
    
    func testValidateEmail_WhenValidEmailProvided_ShouldReturnTrue() async {
        // Given
        let email = "email@aa.aaa"
 
        // When
        let isValid = await viewModel.validateEmail(email)
        
        // Then
        XCTAssertTrue(isValid)
    }
    
    func testValidateEmail_WhenInvalidEmailProvided_ShouldReturnFalse() async {
        // Given
        let email = "invalidemail@aa.aaa"
        
        // When
        let isValid = await viewModel.validateEmail(email)
        
        // Then
        XCTAssertFalse(isValid)
    }
    
    func testGetFirstAndSecondName_WhenOneNameProvided_ShouldReturnFirstName() {
        // Given
        let fullName = "João"
        
        // When
        viewModel.setName(fullName)
        let nameAbbreviation = viewModel.getFirstAndSecondName()
        
        // Then
        XCTAssertEqual(nameAbbreviation, "João")
    }

    func testGetFirstAndSecondName_WhenTwoNameProvided_ShouldReturnFirstAndSecondName() {
        // Given
        let fullName = "João Pedro"
        
        // When
        viewModel.setName(fullName)
        let nameAbbreviation = viewModel.getFirstAndSecondName()
        
        // Then
        XCTAssertEqual(nameAbbreviation, "João Pedro")
    }
    
    func testGetFirstAndSecondName_WhenThreeNameProvided_ShouldReturnFirstAndSecondName() {
        // Given
        let fullName = "João Pedro Victor"
        
        // When
        viewModel.setName(fullName)
        let nameAbbreviation = viewModel.getFirstAndSecondName()
        
        // Then
        XCTAssertEqual(nameAbbreviation, "João Pedro")
    }
    
    func testValidateName_WhenValidNameProvided_ShouldReturnTrue() {
        // Given
        let fullName = "João Pedro"
        
        // When
        let isValid = viewModel.validateName(fullName)
        
        // Then
        XCTAssertTrue(isValid)
    }
    
    func testValidateName_WhenInvalidNameProvided_ShouldReturnFalse() {
        // Given

        let fullName = "João"
        
        // When
        let isValid = viewModel.validateName(fullName)
        
        // Then
        XCTAssertFalse(isValid)
    }
    
    func testValidateName_WhenShortNameProvided_ShouldReturnFalse() {
        // Given

        let fullName = "João Pe"
        
        // When
        let isValid = viewModel.validateName(fullName)
        
        // Then
        XCTAssertFalse(isValid)
    }
    
    func testFormartCPFMask_WhenValidCPFProvided_ShouldReturnFormatted() {
        // Given

        let cpf = "11111111111"
        
        // When
        let cpfFormatted = viewModel.formartCPFMask(cpf)
        
        // Then
        XCTAssertEqual(cpfFormatted, "111.111.111-11")
    }
    
    func testFormartCPFMask_WhenShortCPFProvided_ShouldReturnFormatted() {
        // Given

        let cpf = "111111"
        
        // When
        let cpfFormatted = viewModel.formartCPFMask(cpf)
        
        // Then
        XCTAssertEqual(cpfFormatted, "111.111")
    }
    
    func testFormartBirthDateMask_WhenValidBirthDateProvided_ShouldReturnFormatted() {
        // Given

        let birthDate = "02012022"
        
        // When
        let birthDateFormatted = viewModel.formartBirthDateMask(birthDate)
        
        // Then
        XCTAssertEqual(birthDateFormatted, "02/01/2022")
    }
    
    func testFormartBirthDateMask_WhenShortBirthDateProvided_ShouldReturnFormatted() {
        // Given

        let birthDate = "0201"
        
        // When
        let birthDateFormatted = viewModel.formartBirthDateMask(birthDate)
        
        // Then
        XCTAssertEqual(birthDateFormatted, "02/01")
    }
    
    func testFormartPhoneNumberMask_WhenValidPhoneNumberProvided_ShouldReturnFormatted() {
        // Given

        let phoneNumber = "11111111111"
        
        // When
        let phoneNumberFormatted = viewModel.formartPhoneNumberMask(phoneNumber)
        
        // Then
        XCTAssertEqual(phoneNumberFormatted, "(11) 11111-1111")
    }
    
    func testFormartPhoneNumberMask_WhenShortPhoneNumberProvided_ShouldReturnFormatted() {
        // Given

        let phoneNumber = "1111111"
        
        // When
        let phoneNumberFormatted = viewModel.formartPhoneNumberMask(phoneNumber)
        
        // Then
        XCTAssertEqual(phoneNumberFormatted, "(11) 11111")
    }
    
    func testValidateEmailMask_WhenValidEmailProvided_ShouldReturnTrue() {
        // Given
        let email = "meuemail@email.com"
        
        // When
        let isValid = viewModel.validateEmailMask(email)
        
        // Then
        XCTAssertTrue(isValid)
    }
    
    func testValidateEmailMask_WhenInvalidEmailProvided_ShouldReturnFalse() {
        // Given

        let email = "meuemailemail.com"
        
        // When
        let isValid = viewModel.validateEmailMask(email)
        
        // Then
        XCTAssertFalse(isValid)
    }
}
