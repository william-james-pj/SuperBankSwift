//
//  LoginUITests.swift
//  SuperBankUITests
//
//  Created by Pinto Junior, William James on 30/12/22.
//

import XCTest

class LoginUITests: XCTestCase {

    private var app: XCUIApplication!
    
    private var textFieldAccount: XCUIElement!
    private var buttonAccess: XCUIElement!
    private var buttonGoToRegistration: XCUIElement!

    override func setUpWithError() throws {
        try super.setUpWithError()
        app = XCUIApplication()
        app.launch()
        
        textFieldAccount = app.textFields["Login_TextField_Account"]
        buttonAccess = app.buttons["Login_Button_Access"]
        buttonGoToRegistration = app.buttons["Login_Button_NewAccount"]
        
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        app = nil
        textFieldAccount = nil
        buttonAccess = nil
        buttonGoToRegistration = nil
        try super.tearDownWithError()
    }

    func testLoginVC_WhenViewLoaded_RequiredUIElementsAreEnabled() {
        // Assert
        XCTAssertTrue(textFieldAccount.isEnabled, "Account UITextField is not enabled for user interactions")
        XCTAssertTrue(buttonGoToRegistration.isEnabled, "Registration UIButton is not enabled for user interactions")
        XCTAssertFalse(buttonAccess.isEnabled, "Access UIButton is enabled for user interactions")
    }
    
    func testLoginVC_WhenValidAccountSubmitted_PresentsPasswordButtons() {
        // Arrange
        textFieldAccount.tap()
        textFieldAccount.typeText("9697538")
        
        let textFieldPassword = app.secureTextFields["Login_TextField_Password"]
        
        // Act
        buttonAccess.tap()
        
        // Assert
        XCTAssertFalse(textFieldPassword.isEnabled, "Password UITextField is enabled for user interactions")
        XCTAssertFalse(buttonAccess.isEnabled, "Access UIButton is enabled for user interactions")
    }
    
    func testLoginVC_WhenNewAccountTapped_PresentsRegistrationVC() {
        // Act
        buttonGoToRegistration.tap()
        let isExistence = app.otherElements["Registration_VC_FirstInfo"].waitForExistence(timeout: 1)
        
        // Assert
        XCTAssertTrue(isExistence, "The FirstInfoViewController was not presented when the NewAccount Button was tapped")
    }

}
