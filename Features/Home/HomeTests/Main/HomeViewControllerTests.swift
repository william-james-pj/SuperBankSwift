//
//  HomeViewControllerTests.swift
//  HomeTests
//
//  Created by Pinto Junior, William James on 28/12/22.
//

import XCTest
@testable import Home

class HomeViewControllerTests: XCTestCase {
    var sut: HomeViewController!

    override func setUpWithError() throws {
        sut = HomeViewController()
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    
}
