//
//  SavedMortgagesTableViewController.swift
//  BW4MortgageCalculator
//
//  Created by Clayton Watkins on 10/14/20.
//

import UIKit

class SavedMortgagesTableViewController: UITableViewController {

    // MARK: - Properties
    let mortgageController = MortgageController.shared
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mortgageController.savedMortgages.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MortgageCell", for: indexPath)
        cell.textLabel?.text = mortgageController.savedMortgages[indexPath.row].name
        cell.detailTextLabel?.text = "Total Mortgage Cost: $\(mortgageController.savedMortgages[indexPath.row].totalCost)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let mortgage = mortgageController.savedMortgages[indexPath.row]
            mortgageController.deleteFromPersistentStore(mortgage: mortgage)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    }
    
}
