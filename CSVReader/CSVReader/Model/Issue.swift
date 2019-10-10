//
//  Issue.swift
//  CSVReader
//
//  Created by Femke Offringa on 09/10/2019.
//  Copyright © 2019 Femke Offringa. All rights reserved.
//

import Foundation

struct Issue {
    var firstName: String? = ""
    var lastName: String? = ""
    var numberOfIssues: String? = ""
    var birthDay: Date?

    init(firstname: String?, lastname: String?, numberOfIssues: String?, birthDayText: String?) {
        self.firstName = firstname ?? "-"
        self.lastName = lastname ?? "-"
        self.numberOfIssues = numberOfIssues ?? "-"
        self.birthDay = transformBirthday(birthdayInText: birthDayText)
    }

    func transformBirthday(birthdayInText: String?) -> Date? {
        if let birthDay = birthdayInText, birthDay.count > 0 {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            return dateFormatter.date(from: birthDay)
        }
        return nil
    }
}
