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

    static let firstNameKey = ("First name").trimmingCharacters(in: .whitespacesAndNewlines)
    static let lastNameKey = ("Sur name").trimmingCharacters(in: .whitespacesAndNewlines)
    static let birthDayKey = ("Date of birth").trimmingCharacters(in: .whitespacesAndNewlines)
    static let NumberOfIssuesKey = ("Issue count").trimmingCharacters(in: .whitespacesAndNewlines)
}
