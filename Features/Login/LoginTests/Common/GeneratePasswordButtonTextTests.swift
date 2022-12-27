//
//  GeneratePasswordButtonTextTests.swift
//  LoginTests
//
//  Created by Pinto Junior, William James on 26/12/22.
//

import XCTest
@testable import Login

class GeneratePasswordButtonTextTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGenerateText_WhenGenerateButtons_ShouldCountEqual5() {
        // Given
        let generatePasswordButtonText = GeneratePasswordButtonText()
        // When
        let buttons = generatePasswordButtonText.generationText()
        
        // Then
        XCTAssertEqual(buttons.count, 5)
    }
}
