//
//  LoginViewModelTests.swift
//  LoginTests
//
//  Created by Pinto Junior, William James on 26/12/22.
//

import XCTest
@testable import Login

class LoginViewModelTests: XCTestCase {

    var viewModel: LoginViewModel!

    override func setUpWithError() throws {
        viewModel = LoginViewModel(service: LoginServiceMock())
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }

    func testFormatAccountMask_WhenAccountProvided_ShouldReturnFormatted() {
        // Given
        let account = "1111111"

        // When
        let accountFormatted = viewModel.formatAccountMask(account)

        // Then
        XCTAssertEqual(account, accountFormatted)
    }

    func testFormatAccountMask_WhenAccountProvidedSmaller_ShouldReturnFormatted() {
        // Given
        let account = "11111"

        // When
        let accountFormatted = viewModel.formatAccountMask(account)

        // Then
        XCTAssertEqual(account, accountFormatted)
    }

    func testTypePassword_WhenFirstCharacterTyped_ShouldUpdateTextField() {
        // Given
        var hasAppend = false
        viewModel.updatePasswordTextField = { _ in
            hasAppend = true
        }

        // When
        viewModel.setTypedPassword(ButtonPasswordText(first: 1, second: 2))

        // Then
        XCTAssertTrue(hasAppend)
    }

    func testTypePassword_WhenLastCharacterTyped_ShouldFinishPassword() {
        // Given
        var isFinalized = false
        viewModel.finalizedPassword = {
            isFinalized = true
        }

        // When
        for _ in 0...4 {
            viewModel.setTypedPassword(ButtonPasswordText(first: 1, second: 2))
        }

        // Then
        XCTAssertTrue(isFinalized)
    }

    func testRemoveLastTypedPassword_WhenTypedPasswordIsEmpty_ShouldNotUpdateTextField() {
        // Given
        var hasUpdated = false
        viewModel.updatePasswordTextField = { _ in
            hasUpdated = true
        }

        // When
        viewModel.removeLastTypedPassword()

        // Then
        XCTAssertFalse(hasUpdated)
    }

    func testRemoveLastTypedPassword_WhenTypedPasswordIsNotEmpty_ShouldUpdateTextField() {
        // Given
        var hasUpdated = false
        viewModel.updatePasswordTextField = { _ in
            hasUpdated = true
        }

        // When
        viewModel.setTypedPassword(ButtonPasswordText(first: 1, second: 2))
        viewModel.removeLastTypedPassword()

        // Then
        XCTAssertTrue(hasUpdated)
    }

    func testGetAccount_WhenAccountProvided_ShouldUpdateAccountUI() async {
        // Given
        let account = "1122334"

        var hasUpdated = false
        viewModel.updateAccountUI = { _, _ in
            hasUpdated = true
        }
        // When
        await viewModel.getAccount(account)

        // Then
        XCTAssertTrue(hasUpdated)
    }

    func testGetAccount_WhenInvalidAccountProvided_ShouldNotUpdateAccountUI() async {
        // Given
        let account = "1122335"

        var hasUpdated = false
        viewModel.updateAccountUI = { _, _ in
            hasUpdated = true
        }
        // When
        await viewModel.getAccount(account)

        // Then
        XCTAssertFalse(hasUpdated)
    }

    func testLogin_WhenInvalidPasswordProvided_ShouldCallInvalidPassword() async {
        // Given
        let account = "1122334"

        var hasCalled = false
        viewModel.invalidPassword = {
            hasCalled = true
        }

        // When
        await viewModel.getAccount(account)

        for _ in 0...4 {
            viewModel.setTypedPassword(ButtonPasswordText(first: 1, second: 2))
        }
        viewModel.logIn()
        // Then
        XCTAssertTrue(hasCalled)
    }

    func testLogin_WhenCorrectPasswordProvided_ShouldCallLoggedIn() async {
        // Given
        let account = "1122334"

        var hasCalled = false
        viewModel.loggedIn = { _, _ in
            hasCalled = true
        }

        // When
        await viewModel.getAccount(account)

        viewModel.setTypedPassword(ButtonPasswordText(first: 1, second: 9))
        viewModel.setTypedPassword(ButtonPasswordText(first: 8, second: 2))
        viewModel.setTypedPassword(ButtonPasswordText(first: 3, second: 7))
        viewModel.setTypedPassword(ButtonPasswordText(first: 6, second: 4))
        viewModel.setTypedPassword(ButtonPasswordText(first: 5, second: 0))
        viewModel.logIn()
        // Then
        XCTAssertTrue(hasCalled)
    }
}
