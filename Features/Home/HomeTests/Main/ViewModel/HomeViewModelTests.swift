//
//  HomeViewModelTests.swift
//  HomeTests
//
//  Created by Pinto Junior, William James on 27/12/22.
//

import XCTest
@testable import Home

class HomeViewModelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetData_WhenCustomerEndAccountProvided_ShouldCallUpdateAccountUI() async {
        // Given
        let viewModel = HomeViewModel(service: HomeServiceMock(), deliveryService: CardDeliveryServiceMock())
        
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
        let viewModel = HomeViewModel(service: HomeServiceMock(), deliveryService: CardDeliveryServiceMock())
        
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
        let viewModel = HomeViewModel(service: HomeServiceMock(), deliveryService: CardDeliveryServiceMock())
        
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
        let viewModel = HomeViewModel(service: HomeServiceMock(), deliveryService: CardDeliveryServiceMock())
        
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
        let viewModel = HomeViewModel(service: HomeServiceMock(), deliveryService: CardDeliveryServiceMock())
        
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
        let viewModel = HomeViewModel(service: HomeServiceMock(), deliveryService: CardDeliveryServiceMock())
        
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
