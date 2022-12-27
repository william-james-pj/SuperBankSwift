//
//  MyCardsViewModelTests.swift
//  CardsTests
//
//  Created by Pinto Junior, William James on 27/12/22.
//

import XCTest
@testable import Cards

import Common

class MyCardsViewModelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetCards_WhenAccountIdProvided_ShouldGetOnePysicalCard() async {
        // Given
        let viewModel = MyCardsViewModel(service: CardServiceMock())
        
        var cards: [CardModel] = []
        viewModel.finishGetCards = { physicalCards, _ in
            cards = physicalCards
        }
        
        // When
        await viewModel.getCards(accountId: "")
        
        // Then
        XCTAssertEqual(cards.count, 1)
    }
    
    func testGetCards_WhenAccountIdProvided_ShouldGetOneVirtualCard() async {
        // Given
        let viewModel = MyCardsViewModel(service: CardServiceMock())
        
        var cards: [CardModel] = []
        viewModel.finishGetCards = { _, virtualCards in
            cards = virtualCards
        }
        
        // When
        await viewModel.getCards(accountId: "")
        
        // Then
        XCTAssertEqual(cards.count, 1)
    }
}
