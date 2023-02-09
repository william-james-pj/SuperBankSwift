//
//  RegistrationUITests.swift
//  SuperBankUITests
//
//  Created by Pinto Junior, William James on 02/01/23.
//

import XCTest

class RegistrationUITests: XCTestCase {

    private var app: XCUIApplication!

    override func setUpWithError() throws {
        try super.setUpWithError()
        app = XCUIApplication()
        app.launch()

        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        app = nil
        try super.tearDownWithError()
    }

    func testFirstInfoVC_WhenViewLoaded_RequiredUIElementsAreEnabled() {
        self.open_FirstInfoVC()

        let isExistence = app.otherElements["Registration_VC_FirstInfo"].waitForExistence(timeout: 1)
        let buttonOpenAccount = app.buttons["FirstInfo_Button_OpenAccount"]

        XCTAssertTrue(
            isExistence,
            "The FirstInfoViewController was not presented when the NewAccount Button was tapped"
        )
        XCTAssertTrue(buttonOpenAccount.isEnabled, "OpenAccount UIButton is not enabled for user interactions")
    }

    func testFullNameRegistrationVC_WhenViewLoaded_RequiredUIElementsAreEnabled() {
        self.open_FullNameVC()

        let isExistence = app.otherElements["Registration_VC_FullName"].waitForExistence(timeout: 1)
        let textFieldFullName = app.textFields["FullNameRegistration_TextField_FullName"]
        let buttonGOFullName = app.buttons["FullNameRegistration_Button_GO"]

        XCTAssertTrue(isExistence, "The FullNameRegistrationViewController was not presented")
        XCTAssertTrue(
            textFieldFullName.isEnabled,
            "FullName UITextField in FullNameRegistrationViewController is not enabled for user interactions"
        )
        XCTAssertFalse(
            buttonGOFullName.isEnabled,
            """
            GO UIButton in FullNameRegistrationViewController is
            enabled for user interactions when FullName UITextField is not predefined
            """
        )
    }

    func testCPFVCRegistration_WhenViewLoaded_RequiredUIElementsAreEnabled() {
        self.open_CPFVC()

        let isExistence = app.otherElements["Registration_VC_CPF"].waitForExistence(timeout: 1)
        let textFieldCPF = app.textFields["CPFRegistration_TextField_CPF"]
        let buttonGOCPF = app.buttons["CPFRegistration_Button_GO"]

        XCTAssertTrue(isExistence, "The FullNameRegistrationViewController was not presented")
        XCTAssertTrue(
            textFieldCPF.isEnabled,
            "CPF UITextField in CPFVCRegistrationViewController is not enabled for user interactions"
        )
        XCTAssertFalse(
            buttonGOCPF.isEnabled,
            """
            GO UIButton in CPFVCRegistrationViewController is enabled for
            user interactions when CPF UITextField is not predefined
            """
        )
    }

    func testBirthDate_WhenViewLoaded_RequiredUIElementsAreEnabled() {
        self.open_BirthDate()

        let isExistence = app.otherElements["Registration_VC_BirthDate"].waitForExistence(timeout: 1)
        let textFieldBirthDate = app.textFields["BirthDateRegistration_TextField_BirthDate"]
        let buttonGOBirthDate = app.buttons["BirthDateRegistration_Button_GO"]

        XCTAssertTrue(isExistence, "The BirthDateRegistrationViewController was not presented")
        XCTAssertTrue(
            textFieldBirthDate.isEnabled,
            "BirthDate UITextField in BirthDateRegistrationViewController is not enabled for user interactions"
        )
        XCTAssertFalse(
            buttonGOBirthDate.isEnabled,
            """
            GO UIButton in BirthDateRegistrationViewController is enabled for
            user interactions when BirthDate UITextField is not predefined
            """
        )
    }

    func testPhoneNumber_WhenViewLoaded_RequiredUIElementsAreEnabled() {
        self.open_PhoneNumber()

        let isExistence = app.otherElements["Registration_VC_PhoneNumber"].waitForExistence(timeout: 1)
        let textFieldPhoneNumber = app.textFields["PhoneNumberRegistration_TextField_BirthDate"]
        let buttonGOPhoneNumber = app.buttons["PhoneNumberRegistration_Button_GO"]

        XCTAssertTrue(isExistence, "The PhoneNumberRegistrationViewController was not presented")
        XCTAssertTrue(
            textFieldPhoneNumber.isEnabled,
            "PhoneNumber UITextField in PhoneNumberRegistrationViewController is not enabled for user interactions"
        )
        XCTAssertFalse(
            buttonGOPhoneNumber.isEnabled,
            """
            GO UIButton in PhoneNumberRegistrationViewController is enabled for user
            interactions when PhoneNumber UITextField is not predefined
            """
        )
    }

    // Helpers
    private func open_FirstInfoVC() {
        let buttonGoToRegistration = app.buttons["Login_Button_NewAccount"]
        buttonGoToRegistration.tap()
    }

    private func open_FullNameVC() {
        self.open_FirstInfoVC()

        let buttonOpenAccount = app.buttons["FirstInfo_Button_OpenAccount"]
        buttonOpenAccount.tap()
    }

    private func open_CPFVC() {
        self.open_FullNameVC()

        let textFieldFullName = app.textFields["FullNameRegistration_TextField_FullName"]
        textFieldFullName.tap()
        textFieldFullName.typeText("João Pedro")

        let buttonGOFullName = app.buttons["FullNameRegistration_Button_GO"]
        buttonGOFullName.tap()
    }

    private func open_BirthDate() {
        self.open_CPFVC()

        let textFieldCPF = app.textFields["CPFRegistration_TextField_CPF"]
        textFieldCPF.tap()
        textFieldCPF.typeText("11111111111")

        let buttonGOCPF = app.buttons["CPFRegistration_Button_GO"]
        buttonGOCPF.tap()
    }

    private func open_PhoneNumber() {
        self.open_BirthDate()

        let textFieldBirthDate = app.textFields["BirthDateRegistration_TextField_BirthDate"]
        textFieldBirthDate.tap()
        textFieldBirthDate.typeText("01012001")

        let buttonGOBirthDate = app.buttons["BirthDateRegistration_Button_GO"]
        buttonGOBirthDate.tap()
    }
}
