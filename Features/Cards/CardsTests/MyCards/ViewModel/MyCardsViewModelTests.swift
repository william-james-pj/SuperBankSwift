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
    
    var viewModel: MyCardsViewModel!

    override func setUpWithError() throws {
        viewModel = MyCardsViewModel(service: CardServiceMock())
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }

    func testGetCards_WhenAccountIdProvided_ShouldGetOnePysicalCard() async {
        // Given
        let accountId = ""
        
        var cards: [CardModel] = []
        viewModel.finishGetCards = { physicalCards, _ in
            cards = physicalCards
        }
        
        // When
        await viewModel.getCards(accountId: accountId)
        
        // Then
        XCTAssertEqual(cards.count, 1)
    }
    
    func testGetCards_WhenAccountIdProvided_ShouldGetOneVirtualCard() async {
        // Given
        let accountId = ""
        
        var cards: [CardModel] = []
        viewModel.finishGetCards = { _, virtualCards in
            cards = virtualCards
        }
        
        // When
        await viewModel.getCards(accountId: accountId)
        
        // Then
        XCTAssertEqual(cards.count, 1)
    }
}
