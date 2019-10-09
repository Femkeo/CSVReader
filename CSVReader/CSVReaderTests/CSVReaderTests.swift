//
//  CSVReaderTests.swift
//  CSVReaderTests
//
//  Created by Femke Offringa on 09/10/2019.
//  Copyright © 2019 Femke Offringa. All rights reserved.
//

import XCTest
@testable import CSVReader

class CSVReaderTests: XCTestCase {
    
    let reader = CSVReader()

    override func setUp() {
        
    }

    override func tearDown() {
        
    }
    
    func testIfNoCSVFileReturnsNil(){
        let result = reader.findCSVFile(name: "Fake File")
        XCTAssertNil(result, "The CSV file does not return nil when never found")
    }
    
    func testIfCSVFileReturnsPath(){
        let result = reader.findCSVFile(name: "issues")
        XCTAssertNotNil(result)
    }
    
    func testIfCSVFileIsReadCorrectly(){
        //works only with provided CSV
        let path = reader.findCSVFile(name: "issues")
        if let result = reader.readCSV(path: path ?? ""){
            XCTAssertEqual(result.first?["First name"] ?? "", "Theo", "The first name that was found is not the first name in the document")
        }else{
            XCTFail()
        }
    }
    

}
