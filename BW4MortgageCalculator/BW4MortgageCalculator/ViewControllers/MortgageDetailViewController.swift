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
        nicknameTextField.addDoneButtonOnKeyboard()
    }
    
    private func updateViews() {
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
        guard let mortgage = mortgage, let newNickname = nicknameTextField.text else { return }
        mortgageController.updateMortgageFromPersistentStore(mortgage: mortgage, nickname: newNickname)
        saveButton.isEnabled = false
        updateViews()
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
