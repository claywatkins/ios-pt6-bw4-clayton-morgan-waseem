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
    var mortgage: Mortgage? {
        didSet {
            updateViews()
        }
    }
    let initialNickname = ""
    
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
//        initialNickname = mortgage.nickname
    }
    
    func updateViews() {
        guard let mortgage = mortgage else { return }
//        title = mortgage.nickname
//        nicknameTextField.text = mortgage.nickname
        totalCostLabel.text = "\(mortgage.totalCost)"
        monthlyPaymentLabel.text = "\(mortgage.monthlyPayment)"
        principalLabel.text = "\(mortgage.principal)"
        downPaymentLabel.text = "\(mortgage.downPayment)"
        rateLabel.text = "\(mortgage.interestRate)"
        termLabel.text = "\(mortgage.term)"
    }
    
    // IBActions
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        
    }
    
    @IBAction func nicknameTextFieldValueChanged(_ sender: UITextField) {
        saveButton.isEnabled = true
    }
    
} //End of class
