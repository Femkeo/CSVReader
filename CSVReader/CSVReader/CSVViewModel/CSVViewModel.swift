//
//  CSVViewModel.swift
//  CSVReader
//
//  Created by Femke Offringa on 09/10/2019.
//  Copyright © 2019 Femke Offringa. All rights reserved.
//

import Foundation

protocol HandleIssuesUpdate: class {
    func reloadSinceIssuesIsUpdated(issues: [Issue])
    func showErrorAlert(errorText: String)
}

class CSVViewModel {
    let reader = CSVReader()
    var mainDispatchQueue = DispatchQueue.main
    var backgroundDispatchQueue = DispatchQueue.global(qos: .default)
    var issues = [Issue]() {
        didSet {
            self.mainDispatchQueue.async {
                self.delegate?.reloadSinceIssuesIsUpdated(issues: self.issues)
            }
        }
    }
    var noErrorHasOccuredYet = true

    weak var delegate: HandleIssuesUpdate?

    init() {
        self.retrieveIssues()
    }

    func retrieveIssues() {
        backgroundDispatchQueue.async { [weak self] in
            guard let self = self else { return }
            guard let csvFilePath = self.reader.findCSVFile(name: Constants.csvFileName) else { return }
            guard let csvRows = self.reader.readCSV(path: csvFilePath) else { return }
            for row in csvRows {
                if let newIssue = self.getIssueIfNotEmpty(csvRow: row) {
                    self.issues.append(newIssue)
                } else {
                    self.handleErrorMessage()
                }
            }
        }
    }

    func getIssueIfNotEmpty(csvRow: [String: String]) -> Issue? {
        let newIssue = Issue(firstname: csvRow[Constants.firstNameKey],
                             lastname: csvRow[Constants.lastNameKey],
                             numberOfIssues: csvRow[Constants.numberOfIssuesKey],
                             birthDayText: csvRow[Constants.birthDayKey])
        if self.newIssueIsNotEmpty(issue: newIssue) {
            return newIssue
        }
        return nil
    }

    func handleErrorMessage() {
        if self.noErrorHasOccuredYet {
            mainDispatchQueue.sync { [weak self] in
                self?.delegate?.showErrorAlert(errorText:
                    Constants.emptyIssueErrorMessage)
                self?.noErrorHasOccuredYet = false
            }
        }
    }

    func newIssueIsNotEmpty(issue: Issue) -> Bool {
        let emptyIssue = Issue(firstname: "", lastname: "", numberOfIssues: "", birthDayText: "")
        return issue != emptyIssue
    }
}
