//
//  MortgageCalculatorViewController.swift
//  BW4MortgageCalculator
//
//  Created by Clayton Watkins on 10/13/20.
//

import UIKit

class MortgageCalculatorViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var mortgageAmountTextField: UITextField!
    @IBOutlet weak var downPaymentLabel: UILabel!
    @IBOutlet weak var interestRateLabel: UILabel!
    @IBOutlet weak var totalMortgageLabel: UILabel!
    @IBOutlet weak var monthlyPaymentLabel: UILabel!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - IBActions
    @IBAction func downPaymentSliderChanged(_ sender: Any) {
    }
    
    @IBAction func interestRateSilderChanged(_ sender: Any) {
    }
    
    @IBAction func selectLoanTermButtonPressed(_ sender: Any) {
    }
    
    @IBAction func calculateMortgageButtonPressed(_ sender: Any) {
    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   
    }
}
