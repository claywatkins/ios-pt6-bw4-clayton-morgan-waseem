//
//  MortgageDetailViewController.swift
//  BW4MortgageCalculator
//
//  Created by Clayton Watkins on 10/14/20.
//

import UIKit

class MortgageDetailViewController: UIViewController {
    
    //MARK: - Properties and IBOutlets -
    
    // Properties
    let mortgageController = MortgageController.shared
    var mortgage: Mortgage?
    
    // IBOutlets
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var nicknameTextField: UITextField!
    @IBOutlet weak var totalCostLabel: UILabel!
    @IBOutlet weak var monthlyPaymentLabel: UILabel!
    @IBOutlet weak var principalLabel: UILabel!
    @IBOutlet weak var downPaymentLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var termLabel: UILabel!
    
    //MARK: - Methods and IBActions -
    
    // Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    func updateViews() {
        guard let mortgage = mortgage else { return }
        guard let nickname = mortgage.name else { return }
        title = nickname
        nicknameTextField.text = mortgage.name!
        totalCostLabel.text = "\(mortgage.totalCost)"
        monthlyPaymentLabel.text = "\(mortgage.monthlyPayment)"
        principalLabel.text = "\(mortgage.principal)"
        downPaymentLabel.text = "\(mortgage.downPayment)"
        rateLabel.text = "\(mortgage.interestRate)"
        termLabel.text = "\(mortgage.term)"
    }
    
    // IBActions
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        print("Add logic to update the name of saved mortgage in the model controller and call it in the detailViewController")
    }
    
    @IBAction func nicknameTextFieldValueChanged(_ sender: UITextField) {
        
        if title != nicknameTextField.text {
            saveButton.isEnabled = true
        }
        
        if title == nicknameTextField.text {
            saveButton.isEnabled = false
        }
        
    }
    
} //End of class
