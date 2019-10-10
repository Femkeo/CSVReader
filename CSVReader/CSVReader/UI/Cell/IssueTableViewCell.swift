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

    var issue: Issue?

    override func awakeFromNib() {
        super.awakeFromNib()
        if let firstname = issue?.firstName, let lastname = issue?.lastName {
            self.nameLabel.text = "\(firstname) \(lastname)"
        }
        if let amount = issue?.numberOfIssues {
            self.issuesAmountLabel.text = amount
        }
        if let birthday = issue?.birthDay {
            self.birthdayLabel.text = "\(birthday)"
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
