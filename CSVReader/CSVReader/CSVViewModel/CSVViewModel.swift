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
            self.backgroundDispatchQueue.async {
                self.safeLocalUsers(issues: self.issues)
            }
        }
    }
    var noErrorHasOccuredYet = true
    let userDefaults = UserDefaults.standard

    weak var delegate: HandleIssuesUpdate?

    init() {
        if userAlreadyInMomory() {
            addLocalUsers()
        } else {
            retrieveIssues()
        }
    }

    func userAlreadyInMomory() -> Bool {
        return userDefaults.data(forKey: Constants.localIssues) != nil
    }

    func addLocalUsers() {
        issues = retrieveLocalUsers()
    }

    func retrieveLocalUsers() -> [Issue] {
        do {
            guard let savedIssues = userDefaults.data(forKey: Constants.localIssues) else { return [Issue]() }
            if let issueData = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedIssues) {
                let localIssues = try JSONDecoder().decode([Issue].self, from: issueData as? Data ?? Data())
                return localIssues
            }
        } catch let error {
            print("Could not retrieve local issues because of error: \(error)")
        }
        return [Issue]()
    }

    func safeLocalUsers(issues: [Issue]) {
        do {
            let newIssues = try JSONEncoder().encode(issues)
            let data: Data? = try NSKeyedArchiver.archivedData(withRootObject: newIssues, requiringSecureCoding: false)
            userDefaults.set(data, forKey: Constants.localIssues)
            userDefaults.synchronize()
        } catch let error {
            print("Could not safe local issues because of error: \(error)")
        }
    }

    func retrieveIssues() {
        noErrorHasOccuredYet = true
        issues = [Issue]()
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
