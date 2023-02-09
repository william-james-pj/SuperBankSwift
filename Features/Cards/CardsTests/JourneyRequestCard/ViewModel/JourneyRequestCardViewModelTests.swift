//
//  JourneyRequestCardViewModelTests.swift
//  CardsTests
//
//  Created by Pinto Junior, William James on 27/12/22.
//

import XCTest
@testable import Cards

class JourneyRequestCardViewModelTests: XCTestCase {

    var viewModel: JourneyRequestCardViewModel!

    override func setUpWithError() throws {
        viewModel = JourneyRequestCardViewModel(service: CardServiceMock(), deliveryService: CardDeliveryServiceMock())
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }

    func testCreateInvoice_WhenCreateSuccessfully_ShouldCallFinishSavingInvoice() async {
        // Given
        var hasCalled = false
        viewModel.finishSavingInvoice = {
            hasCalled = true
        }

        // When
        viewModel.setAccountId("111111")
        viewModel.setCreditValue(500)
        viewModel.setInvoiceDueDate("01")
        viewModel.setCardPin("1111")
        await viewModel.createInvoice()

        // Then
        XCTAssertTrue(hasCalled)
    }

    func testGetCreditValue_WhenCreditValueProvided_ShouldReturnDueDate() {
        // Given
        let creditValueProvided = 500.00

        // When
        viewModel.setCreditValue(creditValueProvided)
        let creditValue = viewModel.getCreditValue()

        // Then
        XCTAssertEqual(creditValue, "R$ 500,00")
    }

    func testCreditValue_WhenCreditValueNotProvided_ShouldReturnEmpty() {
        // Given

        // When
        let creditValue = viewModel.getCreditValue()

        // Then
        XCTAssertEqual(creditValue, "")
    }

    func testGetDueDate_WhenDueDateProvided_ShouldReturnDueDate() {
        // Given
        let dueDateProvided = "02"

        // When
        viewModel.setInvoiceDueDate(dueDateProvided)
        let dueDate = viewModel.getDueDate()

        // Then
        XCTAssertEqual(dueDate, dueDateProvided)
    }

    func testGetDueDate_WhenDueDateNotProvided_ShouldReturnEmpty() {
        // Given

        // When
        let dueDate = viewModel.getDueDate()

        // Then
        XCTAssertEqual(dueDate, "")
    }

    func testFormatCurrency_WhenNumberProvided_ShouldReturnFormatted() {
        // Given
        let money = 5300.30

        // When
        let moneyFormatted = viewModel.formatCurrency(money)

        // Then
        XCTAssertEqual(moneyFormatted, "R$ 5.300,30")
    }

}
