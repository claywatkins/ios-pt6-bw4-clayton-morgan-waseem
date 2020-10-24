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
    var numberFormatter: NumberFormatter {
        let nF = NumberFormatter()
        nF.numberStyle = .decimal
        return nF
    }
    
    // let numberFormatter = NumberFormatter()
//    numberFormatter.numberStyle = .decimal
//    let formattedMonthlyPayment = numberFormatter.string(from: NSNumber(value: myMortgage.monthlyPayment))!
    
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
        let formattedTotalCost = numberFormatter.string(from: NSNumber(value: mortgage.totalCost))!
        totalCostLabel.text = "$" + formattedTotalCost
        let formattedMontlyPayment = numberFormatter.string(from: NSNumber(value: mortgage.monthlyPayment))!
        monthlyPaymentLabel.text = "$" +  formattedMontlyPayment
        let formattedPrincipal = numberFormatter.string(from: NSNumber(value: mortgage.principal))!
        principalLabel.text = "$" + formattedPrincipal
        let formattedDownPayment = numberFormatter.string(from: NSNumber(value: mortgage.downPayment))!
        downPaymentLabel.text = "$" + formattedDownPayment
        rateLabel.text = "\(mortgage.interestRate)%"
        termLabel.text = "\(mortgage.term) years"
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
