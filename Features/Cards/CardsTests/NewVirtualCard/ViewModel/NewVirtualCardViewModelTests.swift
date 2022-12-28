//
//  NewVirtualCardViewModelTests.swift
//  CardsTests
//
//  Created by Pinto Junior, William James on 27/12/22.
//

import XCTest
@testable import Cards

class NewVirtualCardViewModelTests: XCTestCase {
    
    var viewModel: NewVirtualCardViewModel!

    override func setUpWithError() throws {
        viewModel = NewVirtualCardViewModel(service: CardServiceMock())
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }
    
    func testCreateVirtualCard_WhenValidCardProvided_ShouldCallFinishSavingCard() async {
        // Given
        let accountId = "11111"
        let nickName = ""
        
        var hasCalled = false
        viewModel.finishSavingCard = {
            hasCalled = true
        }
        
        // When
        await viewModel.createVirtualCard(accountId: accountId, nickname: nickName)
        
        // Then
        XCTAssertTrue(hasCalled)
    }

    func testCreateVirtualCard_WhenInvalidCardProvided_ShouldNotCallFinishSavingCard() async {
        // Given
        let accountId = ""
        let nickName = ""
        
        var hasCalled = false
        viewModel.finishSavingCard = {
            hasCalled = true
        }
        
        // When
        await viewModel.createVirtualCard(accountId: accountId, nickname: nickName)
        
        // Then
        XCTAssertFalse(hasCalled)
    }
}
