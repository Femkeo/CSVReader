//
//  CSVResultMochTableViewController.swift
//  CSVReaderTests
//
//  Created by Femke Offringa on 11/10/2019.
//  Copyright © 2019 Femke Offringa. All rights reserved.
//

import UIKit

class CSVResultMockTableViewController: HandleIssuesUpdate {

    var didRecieveUpdateRequestClosure: (([Issue]) -> Void)?
    var didRecieveErrorFeedbackRequestClosure: (() -> Void)?

    func reloadSinceIssuesIsUpdated(issues: [Issue]) {
        didRecieveUpdateRequestClosure?(issues)
    }

    func showErrorAlert(errorText: String) {
        didRecieveErrorFeedbackRequestClosure?()
    }
}
