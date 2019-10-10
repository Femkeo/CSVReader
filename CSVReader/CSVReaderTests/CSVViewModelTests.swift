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
    let viewModel = CSVViewModel(delegate: nil, dispatchQueue: DispatchQueue.global())

    override func setUp() {
    }

    override func tearDown() {
    }

    //works only with provided csv
    func testIfArrayHasNewElementWhenRequestingCSV() {
        let amountOfElements = viewModel.issues.count
        viewModel.retrieveIssues()

        XCTAssertLessThan(amountOfElements, viewModel.issues.count, "\(amountOfElements), !< \(viewModel.issues.count)")

    }
}
