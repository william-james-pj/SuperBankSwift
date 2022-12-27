//
//  JourneyRequestCardViewModelTests.swift
//  CardsTests
//
//  Created by Pinto Junior, William James on 27/12/22.
//

import XCTest
@testable import Cards

class JourneyRequestCardViewModelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testCreateInvoice_WhenCreateSucecessfully_ShouldCallFinishSavingInvoice() async {
        // Given
        let viewModel = JourneyRequestCardViewModel(service: CardServiceMock(), deliveryService: CardDeliveryServiceMock())
        
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
        let viewModel = JourneyRequestCardViewModel(service: CardServiceMock(), deliveryService: CardDeliveryServiceMock())
        let creditValueProvided = 500.00
        
        // When
        viewModel.setCreditValue(creditValueProvided)
        let creditValue = viewModel.getCreditValue()
        
        // Then
        XCTAssertEqual(creditValue, "R$ 500,00")
    }
    
    func testCreditValue_WhenCreditValueNotProvided_ShouldReturnEmpty() {
        // Given
        let viewModel = JourneyRequestCardViewModel(service: CardServiceMock(), deliveryService: CardDeliveryServiceMock())
        
        // When
        let creditValue = viewModel.getCreditValue()
        
        // Then
        XCTAssertEqual(creditValue, "")
    }
    
    func testGetDueDate_WhenDueDateProvided_ShouldReturnDueDate() {
        // Given
        let viewModel = JourneyRequestCardViewModel(service: CardServiceMock(), deliveryService: CardDeliveryServiceMock())
        let dueDateProvided = "02"
        
        // When
        viewModel.setInvoiceDueDate(dueDateProvided)
        let dueDate = viewModel.getDueDate()
        
        // Then
        XCTAssertEqual(dueDate, dueDateProvided)
    }
    
    func testGetDueDate_WhenDueDateNotProvided_ShouldReturnEmpty() {
        // Given
        let viewModel = JourneyRequestCardViewModel(service: CardServiceMock(), deliveryService: CardDeliveryServiceMock())
        
        // When
        let dueDate = viewModel.getDueDate()
        
        // Then
        XCTAssertEqual(dueDate, "")
    }
    
    func testFormatCurrency_WhenNumberProvided_ShouldReturnFormated() {
        // Given
        let viewModel = JourneyRequestCardViewModel(service: CardServiceMock(), deliveryService: CardDeliveryServiceMock())
        let money = 5300.30
        
        // When
        let moneyFormated = viewModel.formatCurrency(money)
        
        // Then
        XCTAssertEqual(moneyFormated, "R$ 5.300,30")
    }

}
