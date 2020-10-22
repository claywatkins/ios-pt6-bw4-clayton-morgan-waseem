//
//  LoginViewController.swift
//  BW4MortgageCalculator
//
//  Created by Clayton Watkins on 10/22/20.
//

import UIKit

class LoginViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    
    // MARK: - Properties
    let defaults = UserDefaults.standard
    let mortgageController = MortgageController.shared
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - IBAction
    @IBAction func loginButtonTapped(_ sender: Any) {
        
    }
}
