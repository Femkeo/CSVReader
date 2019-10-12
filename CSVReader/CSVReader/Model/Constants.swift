//
//  Constants.swift
//  CSVReader
//
//  Created by Femke Offringa on 10/10/2019.
//  Copyright © 2019 Femke Offringa. All rights reserved.
//

import Foundation

struct Constants {
    static let csvFileName = "issues"
    static let localIssues = "locallySavedIssues"

    static let firstNameKey = ("First name").trimmingCharacters(in: .whitespacesAndNewlines)
    static let lastNameKey = ("Sur name").trimmingCharacters(in: .whitespacesAndNewlines)
    static let birthDayKey = ("Date of birth").trimmingCharacters(in: .whitespacesAndNewlines)
    static let numberOfIssuesKey = ("Issue count").trimmingCharacters(in: .whitespacesAndNewlines)

    static let emptyIssueErrorMessage = "One or more rows will not be shown, since all the entries are empty"
    static let errorMessageTitle = "Something went wrong"
    static let okbuttonTitle = "OK"

    static let aboutApplicationText = """
    # CSVReader
    A Swift project to read and show the data extracted from CSV files

    # Overview
    This app is made to show the contents of a .csv file, provided by the application.
    The contents are shown in a tableView and will describe:
    • a certain amount of issues a person has
    • that persons name
    • that persons birthday

    # Technical Details
    This Application makes use of a third party library called SwiftCSV.
    • language: Swift 5
    • Build in: Xcode 11.0
    • Deployment target: 12.4

    # Code Details
    To ensure clean code, this application makes use of the third party library called SwiftLint,
    • https://github.com/realm/SwiftLint

    This application is build using the MVVM pattern to ensure seperation of concerns.
    This app has been provided with unit tests to ensure quality.

    There are still some comments and print statements in the application. Since this is a small example application,
    I found it sufficiant. Normally this would be removed and replaced with correct logging.
    """
}
