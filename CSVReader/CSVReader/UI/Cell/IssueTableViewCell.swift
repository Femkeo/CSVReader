//
//  IssueTableViewCell.swift
//  CSVReader
//
//  Created by Femke Offringa on 09/10/2019.
//  Copyright © 2019 Femke Offringa. All rights reserved.
//

import UIKit

class IssueTableViewCell: UITableViewCell {

    @IBOutlet weak var issuesAmountLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!

    var issue: Issue? {
        didSet {
            self.fillInputViews()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        fillInputViews()
        self.frame.size.height = 100
    }

    func fillInputViews() {
        if let firstname = issue?.firstName, let lastname = issue?.lastName {
            nameLabel.text = "\(firstname) \(lastname)"
        }
        if let amount = issue?.numberOfIssues {
            issuesAmountLabel?.text = amount
        }
        if let birthday = issue?.birthDay {
            birthdayLabel?.text = "\(birthday)"
        }
    }
}
