//
//  SettingsViewController.swift
//  BW4MortgageCalculator
//
//  Created by Clayton Watkins on 10/22/20.
//

import UIKit

class SettingsViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var animationSwitch: UISwitch!
    @IBOutlet weak var logOutButton: UIButton!
    
    // MARK: - Properties
    let mortgageController = MortgageController.shared
    let defaults = UserDefaults.standard
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        logOutButton.layer.cornerRadius = 15
    }
    
    // MARK: - IBActions
    @IBAction func switchFlipped(_ sender: UISwitch) {
        
    }
    
    @IBAction func logOutButtonTapped(_ sender: Any) {
        mortgageController.currentUser = nil
        mortgageController.loggedInBool = false
        UserDefaults.standard.setValue(mortgageController.loggedInBool, forKey: "loggedIn")
        performSegue(withIdentifier: "unwindToLogin", sender: self)
    }
    
    
}
