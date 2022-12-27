//
//  CardDetailsViewModelTests.swift
//  CardsTests
//
//  Created by Pinto Junior, William James on 27/12/22.
//

import XCTest
@testable import Cards

class CardDetailsViewModelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testUpdateBlockerCard_WhenValidCardProvided_ShouldCallFinishUpdateCard() async {
        // Given
        let viewModel = CardDetailsViewModel(service: CardServiceMock())
        
        var hasCalled = false
        viewModel.finishUpdateCard = {
            hasCalled = true
        }
        
        // When
        await viewModel.updateBlockerCard(cardId: "11111", keyName: "", value: true)
        
        // Then
        XCTAssertTrue(hasCalled)
    }
    
    func testUpdateBlockerCard_WhenInvalidCardProvided_ShouldNotCallFinishUpdateCard() async {
        // Given
        let viewModel = CardDetailsViewModel(service: CardServiceMock())
        
        var hasCalled = false
        viewModel.finishUpdateCard = {
            hasCalled = true
        }
        
        // When
        await viewModel.updateBlockerCard(cardId: "", keyName: "", value: true)
        
        // Then
        XCTAssertFalse(hasCalled)
    }
}
