//
//  CSVViewPresenterTests.swift
//  CSVReaderTests
//
//  Created by Femke Offringa on 10/10/2019.
//  Copyright © 2019 Femke Offringa. All rights reserved.
//

import XCTest
@testable import CSVReader

class CSVViewPresenterTests: XCTestCase {
    var presenter: CSVViewPresenter?
    let viewController = CSVResultMockTableViewController()

    override func setUp() {
        presenter = CSVViewPresenter()
        presenter?.delegate = viewController
    }

    override func tearDown() {
    }

    //works only with provided csv
    func testIfArrayHasNewElementWhenRequestingCSV() {
        if let presenter = presenter {
            let amountOfElements = presenter.issues.count
            let issueUpdateExpectation = expectation(description:
                                    "ViewController received a number of issues, higher then 0")
            presenter.retrieveIssues()
            viewController.didRecieveUpdateRequestClosure = { issues in
                if issues.count > amountOfElements {
                    //Removing the delegate, since expectation is already fulfilled
                    presenter.delegate = nil
                    issueUpdateExpectation.fulfill()
                }
            }
            wait(for: [issueUpdateExpectation], timeout: 10)
        }
    }

    func testErrorMessageHandling() {
        guard let presenter = presenter else { return }
        presenter.delegate = viewController
        presenter.mainDispatchQueue = DispatchQueue.global(qos: .background)
        presenter.handleErrorMessage()
        XCTAssertFalse(presenter.noErrorHasOccuredYet)
    }

    func testIfEmptyRowIsHandled() {
        let errorExpectation = expectation(description:
        "ViewController received message of an error")
        presenter?.csvName = "testIssues"
        presenter?.delegate = viewController
        presenter?.retrieveIssues()
        viewController.didRecieveErrorFeedbackRequestClosure = {
            errorExpectation.fulfill()
        }
        wait(for: [errorExpectation], timeout: 10)

     }
}
