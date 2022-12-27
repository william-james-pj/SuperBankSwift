//
//  NewVirtualCardViewModelTests.swift
//  CardsTests
//
//  Created by Pinto Junior, William James on 27/12/22.
//

import XCTest
@testable import Cards

class NewVirtualCardViewModelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testCreateVirtualCard_WhenValidCardProvided_ShouldCallFinishSavingCard() async {
        // Given
        let viewModel = NewVirtualCardViewModel(service: CardServiceMock())
        
        var hasCalled = false
        viewModel.finishSavingCard = {
            hasCalled = true
        }
        
        // When
        await viewModel.createVirtualCard(accountId: "11111", nickname: "")
        
        // Then
        XCTAssertTrue(hasCalled)
    }

    func testCreateVirtualCard_WhenInvalidCardProvided_ShouldNotCallFinishSavingCard() async {
        // Given
        let viewModel = NewVirtualCardViewModel(service: CardServiceMock())
        
        var hasCalled = false
        viewModel.finishSavingCard = {
            hasCalled = true
        }
        
        // When
        await viewModel.createVirtualCard(accountId: "", nickname: "")
        
        // Then
        XCTAssertFalse(hasCalled)
    }
}
