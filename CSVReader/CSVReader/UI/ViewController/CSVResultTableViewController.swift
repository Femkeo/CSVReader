//
//  CSVResultTableViewController.swift
//  CSVReader
//
//  Created by Femke Offringa on 09/10/2019.
//  Copyright © 2019 Femke Offringa. All rights reserved.
//

import UIKit

class CSVResultTableViewController: UITableViewController {

    let viewModel = CSVViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.retrieveIssues()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.issues.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IssueCell") as? IssueTableViewCell
        cell?.issue = viewModel.issues[indexPath.row]

        return cell ?? UITableViewCell()
    }

}