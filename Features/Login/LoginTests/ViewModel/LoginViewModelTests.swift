//
//  LoginViewModelTests.swift
//  LoginTests
//
//  Created by Pinto Junior, William James on 26/12/22.
//

import XCTest
@testable import Login

class LoginViewModelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testFormatAccountMask_WhenAccountProvided_ShouldReturnFormatted() {
        // Given
        let modelView = LoginViewModel(service: LoginServiceMock())
        let account = "1111111"
        
        // When
        let accountFormatted = modelView.formatAccountMask(account)
        
        // Then
        XCTAssertEqual(account, accountFormatted)
    }
    
    func testFormatAccountMask_WhenAccountProvidedSmaller_ShouldReturnFormatted() {
        // Given
        let modelView = LoginViewModel(service: LoginServiceMock())
        let account = "11111"
        
        // When
        let accountFormatted = modelView.formatAccountMask(account)
        
        // Then
        XCTAssertEqual(account, accountFormatted)
    }
    
    func testTypePassword_WhenFirstCharacterTyped_ShouldUpdateTextField() {
        // Given
        var hasAppend = false
        
        let modelView = LoginViewModel(service: LoginServiceMock())
        modelView.updatePasswordTextField = { isRemoving in
            hasAppend = true
        }
        
        // When
        modelView.setTypedPassword(ButtonPasswordText(first: 1, second: 2))
        
        //Then
        XCTAssertTrue(hasAppend)
    }
    
    func testTypePassword_WhenLastCharacterTyped_ShouldFinishPassword() {
        // Given
        var isFinalized = false
        
        let modelView = LoginViewModel(service: LoginServiceMock())
        modelView.finalizedPassword = {
            isFinalized = true
        }
        
        // When
        for _ in 0...4 {
            modelView.setTypedPassword(ButtonPasswordText(first: 1, second: 2))
        }
        
        //Then
        XCTAssertTrue(isFinalized)
    }
    
    func testRemoveLastTypedPassword_WhenTypedPasswordIsEmpty_ShouldNotUpdateTextField() {
        // Given
        var hasUpdated = false
        
        let modelView = LoginViewModel(service: LoginServiceMock())
        modelView.updatePasswordTextField = { _ in
            hasUpdated = true
        }
        
        // When
        modelView.removeLastTypedPassword()
        
        //Then
        XCTAssertFalse(hasUpdated)
    }
    
    func testRemoveLastTypedPassword_WhenTypedPasswordIsNotEmpty_ShouldUpdateTextField() {
        // Given
        var hasUpdated = false
        
        let modelView = LoginViewModel(service: LoginServiceMock())
        modelView.updatePasswordTextField = { isRemoving in
            hasUpdated = true
        }
        
        // When
        modelView.setTypedPassword(ButtonPasswordText(first: 1, second: 2))
        modelView.removeLastTypedPassword()
        
        //Then
        XCTAssertTrue(hasUpdated)
    }
    
    func testGetAccount_WhenAccountProvided_ShouldUpdateAccountUI() async {
        // Given
        var hasUpdated = false
        
        let modelView = LoginViewModel(service: LoginServiceMock())
        modelView.updateAccountUI = { _, _ in
            hasUpdated = true
        }
        // When
        await modelView.getAccount("1122334")
        
        //Then
        XCTAssertTrue(hasUpdated)
    }
    
    func testGetAccount_WhenInvalidAccountProvided_ShouldNotUpdateAccountUI() async {
        // Given
        var hasUpdated = false
        
        let modelView = LoginViewModel(service: LoginServiceMock())
        modelView.updateAccountUI = { _, _ in
            hasUpdated = true
        }
        // When
        await modelView.getAccount("1122335")
        
        //Then
        XCTAssertFalse(hasUpdated)
    }
    
    func testLogin_WhenInvalidPasswordProvided_ShouldCallInvalidPassword() async {
        // Given
        var hasCalled = false
        
        let modelView = LoginViewModel(service: LoginServiceMock())
        modelView.invalidPassword = {
            hasCalled = true
        }
        
        // When
        await modelView.getAccount("1122334")
        
        for _ in 0...4 {
            modelView.setTypedPassword(ButtonPasswordText(first: 1, second: 2))
        }
        modelView.logIn()
        //Then
        XCTAssertTrue(hasCalled)
    }
    
    func testLogin_WhenCorrectPasswordProvided_ShouldCallLoggedIn() async {
        // Given
        var hasCalled = false
        
        let modelView = LoginViewModel(service: LoginServiceMock())
        modelView.loggedIn = { _, _ in
            hasCalled = true
        }
        
        // When
        await modelView.getAccount("1122334")
        
        modelView.setTypedPassword(ButtonPasswordText(first: 1, second: 9))
        modelView.setTypedPassword(ButtonPasswordText(first: 8, second: 2))
        modelView.setTypedPassword(ButtonPasswordText(first: 3, second: 7))
        modelView.setTypedPassword(ButtonPasswordText(first: 6, second: 4))
        modelView.setTypedPassword(ButtonPasswordText(first: 5, second: 0))
        modelView.logIn()
        //Then
        XCTAssertTrue(hasCalled)
    }
}
