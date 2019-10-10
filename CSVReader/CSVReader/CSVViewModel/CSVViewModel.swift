//
//  CSVViewModel.swift
//  CSVReader
//
//  Created by Femke Offringa on 09/10/2019.
//  Copyright © 2019 Femke Offringa. All rights reserved.
//

import Foundation

class CSVViewModel {
    let reader = CSVReader()
    let issues = [Issue]()

    func retrieveIssues() {
        if let csvFilePath = reader.findCSVFile(name: "issues") {
            let csvRows = reader.readCSV(path: csvFilePath)
        }
    }
}
