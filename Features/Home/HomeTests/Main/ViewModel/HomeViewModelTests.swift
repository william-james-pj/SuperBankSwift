//
//  HomeViewModelTests.swift
//  HomeTests
//
//  Created by Pinto Junior, William James on 27/12/22.
//

import XCTest
@testable import Home

class HomeViewModelTests: XCTestCase {

    var viewModel: HomeViewModel!

    override func setUpWithError() throws {
        viewModel = HomeViewModel(service: HomeServiceMock(), deliveryService: CardDeliveryServiceMock())
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }

    func testGetData_WhenCustomerEndAccountProvided_ShouldCallUpdateAccountUI() async {
        // Given
        var hasCalled = false
        viewModel.updateAccountUI = { _ in
            hasCalled = true
        }
        // When
        await viewModel.getData(customerId: "1111", accountId: "1111")

        // Then
        XCTAssertTrue(hasCalled)
    }

    func testGetData_WhenInvalidAccountProvided_ShouldNotCallUpdateAccountUI() async {
        // Given
        var hasCalled = false
        viewModel.updateAccountUI = { _ in
            hasCalled = true
        }
        // When
        await viewModel.getData(customerId: "1111", accountId: "")

        // Then
        XCTAssertFalse(hasCalled)
    }

    func testGetData_WhenInvalidCustomerProvided_ShouldNotCallUpdateCustomerUI() async {
        // Given
        var hasCalled = false
        viewModel.updateCustomerUI = { _ in
            hasCalled = true
        }
        // When
        await viewModel.getData(customerId: "", accountId: "1111")

        // Then
        XCTAssertFalse(hasCalled)
    }

    func testGetData_WhenCustomerHasNotCardDelivery_ShouldNotCallCardDelivery() async {
        // Given
        var hasCalled = false
        viewModel.updateCardDelivery = { _ in
            hasCalled = true
        }
        // When
        await viewModel.getData(customerId: "1111", accountId: "2222")

        // Then
        XCTAssertFalse(hasCalled)
    }

    func testSetMoneyIsHide_WhenSetToHide_ShouldReturnTrue() {
        // Given
        var hasHide = false
        viewModel.updateHideMoney = { isHide in
            hasHide = isHide
        }
        // When
        viewModel.setMoneyIsHide(to: true)
        viewModel.getMoneyIsHide()

        // Then
        XCTAssertTrue(hasHide)
    }

    func testSetMoneyIsHide_WhenSetToNotHide_ShouldReturnFalse() {
        // Given
        var hasHide = true
        viewModel.updateHideMoney = { isHide in
            hasHide = isHide
        }
        // When
        viewModel.setMoneyIsHide(to: false)
        viewModel.getMoneyIsHide()

        // Then
        XCTAssertFalse(hasHide)
    }
}
