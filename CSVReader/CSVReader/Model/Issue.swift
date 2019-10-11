//
//  Issue.swift
//  CSVReader
//
//  Created by Femke Offringa on 09/10/2019.
//  Copyright © 2019 Femke Offringa. All rights reserved.
//

import Foundation

struct Issue: Equatable {
    var firstName: String? = ""
    var lastName: String? = ""
    var numberOfIssues: String? = ""
    var birthDay: String?

    init(firstname: String?, lastname: String?, numberOfIssues: String?, birthDayText: String?) {
        self.firstName = firstname ?? ""
        self.lastName = lastname ?? ""
        self.numberOfIssues = numberOfIssues ?? ""
        self.birthDay = transformBirthday(birthdayInText: birthDayText)
    }

    func transformBirthday(birthdayInText: String?) -> String {
        if let birthDay = birthdayInText, birthDay.count > 0 {
            let dateFormatter = setInitialDateFormatter()
            if let birthDate = dateFormatter.date(from: birthDay) {
                dateFormatter.dateFormat = "dd-MM-yyyy"
                return dateFormatter.string(from: birthDate)
            }
        }
        return ""
    }

    func setInitialDateFormatter() -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        return dateFormatter
    }
}
