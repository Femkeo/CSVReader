//
//  CSVResultTableViewController.swift
//  CSVReader
//
//  Created by Femke Offringa on 09/10/2019.
//  Copyright © 2019 Femke Offringa. All rights reserved.
//

import UIKit

class CSVResultTableViewController: UITableViewController, HandleIssuesUpdate {

    var viewModel: CSVViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = CSVViewModel(delegate: self)
        registerIssueCell()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.issues.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IssueCell", for: indexPath) as? IssueTableViewCell
        cell?.issue = viewModel?.issues[indexPath.row]

        return cell ?? UITableViewCell()
    }

    func reloadSinceIssuesIsUpdated() {
        self.tableView.reloadData()
    }

    func registerIssueCell() {
        let nib = UINib(nibName: "IssueTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "IssueCell")
    }

}
