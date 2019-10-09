//
//  CSVReader.swift
//  CSVReader
//
//  Created by Femke Offringa on 09/10/2019.
//  Copyright © 2019 Femke Offringa. All rights reserved.
//

import Foundation
import SwiftCSV

class CSVReader{
    
    func findCSVFile(name: String) -> String?{
        guard let csvPath = Bundle.main.path(forResource: name, ofType: "csv") else {
                         print("Could not find CSV file to parse")
                         return nil
                     }
        return csvPath
    }
    //this class will read the CSV file
    func readCSV(path: String) -> [Dictionary<String, String>]?{
        
        do {
            let issuesCsv = try CSV(name: path, loadColumns: true)
            return issuesCsv.namedRows
        }catch{
            print("Could not parse data from CSV File")
            return nil
        }
    }
}
