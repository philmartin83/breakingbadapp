//
//  BreakingBadCoreDataTest.swift
//  BreakingBadTests
//
//  Created by Phil Martin on 15/09/2022.
//

import XCTest

final class BreakingBadCoreDataTest: XCTestCase {

    var expectation: XCTestExpectation?
    var charactersResponse: Character?
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        charactersResponse = nil
    }
    
    @MainActor func testAPIIntegration() {
        let viewModel = HomeViewModel()
        viewModel.output = self
        viewModel.fetchCharacters()
        expectation = expectation(description: "Fetch Characters")
        waitForExpectations(timeout: 2)
        do {
            let result = try XCTUnwrap(charactersResponse)
            XCTAssertEqual(result.name, "Walter White")
        } catch {
            XCTFail("Do catch failed")
        }
    }

    func contentRecieved(model: [Character]) {
        charactersResponse = model.first
        expectation?.fulfill()
        expectation = nil
    }

    func requestFailed(error: String) {

    }
}
