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
    func showErrorAlert(errorText: String)
}

class CSVViewModel {
    let reader = CSVReader()
    var dispatchQueue = DispatchQueue.main
    var issues = [Issue]() {
        didSet {
            self.dispatchQueue.async {
                self.delegate?.reloadSinceIssuesIsUpdated()
            }
        }
    }
    var noErrorHasOccuredYet = true

    weak var delegate: HandleIssuesUpdate?

    init(delegate: HandleIssuesUpdate?, dispatchQueue: DispatchQueue?) {
        self.delegate = delegate
        self.dispatchQueue = dispatchQueue ?? DispatchQueue.main
        self.retrieveIssues()
    }

    func retrieveIssues() {
        if let csvFilePath = reader.findCSVFile(name: Constants.csvFileName) {
            if let csvRows = reader.readCSV(path: csvFilePath) {
                for row in csvRows {
                    let newIssue = Issue(firstname: row[Constants.firstNameKey],
                                         lastname: row[Constants.lastNameKey],
                                         numberOfIssues: row[Constants.numberOfIssuesKey],
                                         birthDayText: row[Constants.birthDayKey])
                    dispatchQueue.async { [weak self] in
                        if let self = self {
                            if self.newIssueIsNotEmpty(issue: newIssue) {
                                self.issues.append(newIssue)
                            } else if self.noErrorHasOccuredYet {
                                self.delegate?.showErrorAlert(errorText:
                                    Constants.emptyIssueErrorMessage)
                                self.noErrorHasOccuredYet = false
                            }
                        }
                    }
                    print(row)
                }
            }
        }
    }

    func newIssueIsNotEmpty(issue: Issue) -> Bool {
        let nilIssue = Issue(firstname: nil, lastname: nil, numberOfIssues: nil, birthDayText: nil)
        let safetyIssue = Issue(firstname: "-", lastname: "-", numberOfIssues: "-", birthDayText: "")
        let emptyIssue = Issue(firstname: "", lastname: "", numberOfIssues: "", birthDayText: "")
        if issue == nilIssue || issue == emptyIssue || issue == safetyIssue {
            return false
        }
        return true
    }
}
