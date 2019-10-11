//
//  AboutViewController.swift
//  CSVReader
//
//  Created by Femke Offringa on 11/10/2019.
//  Copyright © 2019 Femke Offringa. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {

    @IBOutlet weak var aboutApplicationText: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.aboutApplicationText.text = Constants.aboutApplicationText
    }

    @IBAction func dismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}
