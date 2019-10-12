//
//  CSVResultTableViewController.swift
//  CSVReader
//
//  Created by Femke Offringa on 09/10/2019.
//  Copyright © 2019 Femke Offringa. All rights reserved.
//

import UIKit

class CSVResultTableViewController: UITableViewController, HandleIssuesUpdate {

    var viewModel = CSVViewModel()
    var issues = [Issue]()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        registerIssueCell()
        tableView.refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(refreshIssuesList), for: .valueChanged)

        tableView.tableFooterView = UIView()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if IssuesListIsNotEmpty() {
            return issues.count
        } else {
            return 1
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if IssuesListIsNotEmpty() {
            let cell = tableView.dequeueReusableCell(withIdentifier: "IssueCell", for: indexPath) as? IssueTableViewCell
            cell?.issue = issues[indexPath.row]
            return cell ?? UITableViewCell()
        } else {
            let cell = UITableViewCell()
            cell.textLabel?.textAlignment = .center
            cell.textLabel?.text = "Data could not be loaded"
            return cell
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //just because it looks a bit better
        self.tableView.deselectRow(at: indexPath, animated: true)
    }

    @objc func refreshIssuesList() {
        viewModel.retrieveIssues()
    }

    func IssuesListIsNotEmpty() -> Bool {
        if issues.count > 0 {
            return true
        }
        return false
    }

    func reloadSinceIssuesIsUpdated(issues: [Issue]) {
        self.issues = issues
        tableView.reloadData()
        if tableView.refreshControl?.isRefreshing == true {
            tableView.refreshControl?.endRefreshing()
        }
    }

    func showErrorAlert(errorText: String) {
        let errorAlert = UIAlertController(title: Constants.errorMessageTitle,
                                           message: errorText,
                                           preferredStyle: .alert)
        errorAlert.addAction(UIAlertAction(title: Constants.okbuttonTitle,
                                           style: UIAlertAction.Style.default,
                                           handler: nil))
        self.present(errorAlert, animated: true, completion: nil)
     }

    func registerIssueCell() {
        let nib = UINib(nibName: "IssueTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "IssueCell")
    }

}
