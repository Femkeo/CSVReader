//
//  CSVViewModel.swift
//  CSVReader
//
//  Created by Femke Offringa on 09/10/2019.
//  Copyright © 2019 Femke Offringa. All rights reserved.
//

import Foundation

protocol HandleIssuesUpdate: class {
    func reloadSinceIssuesIsUpdated()
}

class CSVViewModel {
    let reader = CSVReader()
    var issues = [Issue]() {
        didSet {
            DispatchQueue.main.async {
                self.delegate?.reloadSinceIssuesIsUpdated()
            }
        }
    }

    weak var delegate: HandleIssuesUpdate?

    init(delegate: HandleIssuesUpdate) {
        self.delegate = delegate
        self.retrieveIssues()
    }

    func retrieveIssues() {
        if let csvFilePath = reader.findCSVFile(name: Constants.csvFileName) {
            if let csvRows = reader.readCSV(path: csvFilePath) {
                for row in csvRows {
                    let newIssue = Issue(firstname: row[Constants.firstNameKey],
                                         lastname: row[Constants.lastNameKey],
                                         numberOfIssues: row[Constants.NumberOfIssuesKey],
                                         birthDayText: row[Constants.birthDayKey])
                    DispatchQueue.main.async { [weak self] in
                        self?.issues.append(newIssue)
                    }
                    print(row)
                }
            }
        }
    }
}
