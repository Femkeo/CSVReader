//
//  CSVViewModelTests.swift
//  CSVReaderTests
//
//  Created by Femke Offringa on 10/10/2019.
//  Copyright © 2019 Femke Offringa. All rights reserved.
//

import XCTest
@testable import CSVReader

class CSVViewModelTests: XCTestCase {
    var viewModel: CSVViewModel?
    let viewController = CSVResultMockTableViewController()

    override func setUp() {
        viewModel = CSVViewModel()
        viewModel?.delegate = viewController
    }

    override func tearDown() {
    }

    //works only with provided csv
    func testIfArrayHasNewElementWhenRequestingCSV() {
        if let viewModel = viewModel {
            let amountOfElements = viewModel.issues.count
            let issueUpdateExpectation = expectation(description:
                                    "ViewController received a number of issues, higher then 0")
            viewModel.retrieveIssues()
            viewController.didRecieveUpdateRequestClosure = { issues in
                if issues.count > amountOfElements {
                    //Removing the delegate, since expectation is already fulfilled
                    viewModel.delegate = nil
                    issueUpdateExpectation.fulfill()
                }
            }
            wait(for: [issueUpdateExpectation], timeout: 10)
        }
    }

    func testErrorMessageHandling() {
        guard let viewModel = viewModel else { return }
        viewModel.delegate = viewController
        viewModel.mainDispatchQueue = DispatchQueue.global(qos: .background)
        viewModel.handleErrorMessage()
        XCTAssertFalse(viewModel.noErrorHasOccuredYet)
    }
}
