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
    @IBOutlet weak var mortgageAmountLabel: UILabel!
    @IBOutlet weak var downPaymentLabel: UILabel!
    @IBOutlet weak var downPaymentTextField: UITextField!
    @IBOutlet weak var interestRateLabel: UILabel!
    @IBOutlet weak var interestRateSlider: UISlider!
    @IBOutlet weak var loanTermLabel: UILabel!
    @IBOutlet weak var totalMortgageLabel: UILabel!
    @IBOutlet weak var monthlyPaymentLabel: UILabel!
    
    // MARK: - Properties
    var picker = UIPickerView()
    var toolBar = UIToolbar()
    let loanTerms = [15, 20, 30]
    let mortgageController = MortgageController.shared
    
    // Variables to keep track of user input for later calculation
    var chosenPrincipal: Int32?
    var chosenTerm: Int32?
    var chosenInterest: Double = 0
    var chosenDownPayment: Int32 = 0
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    // MARK: - IBActions
    @IBAction func interestRateSilderChanged(_ sender: UISlider) {
        // Rounding the slider value
        sender.setValue(Float(roundf(interestRateSlider.value * 4.0) / 4.0), animated: true)
        chosenInterest = Double(sender.value)
        updateViews()
    }
    
    @IBAction func selectLoanTermButtonPressed(_ sender: Any) {
        // Programatically presenting a UIPickerView
        picker.delegate = self
        picker.backgroundColor = UIColor.white
        picker.setValue(UIColor.black, forKey: "textColor")
        picker.autoresizingMask = .flexibleWidth
        picker.contentMode = .center
        picker.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
        self.view.addSubview(picker)
        
        toolBar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
        toolBar.items = [UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(onDoneButtonTapped))]
        self.view.addSubview(toolBar)
    }
    
    @IBAction func calculateMortgageButtonPressed(_ sender: Any) {
        // Creating a mortgage
        guard let term = chosenTerm, let principal = chosenPrincipal else { return }
        let myMortgage = Mortgage(term: term, principal: principal, interestRate: chosenInterest, downPayment: chosenDownPayment)
        
        // Calculating a mortgage payment
        let myMortgagePayment = mortgageController.calculateMortgagePayment(principal: myMortgage.principal,
                                                                            downPayment: myMortgage.downPayment,
                                                                            term: myMortgage.term,
                                                                            interestRate: myMortgage.interestRate)
        
        // Updating the payment label
//        monthlyPaymentLabel.text = "$" + String(format: "%.2f", myMortgagePayment) + " per month"
        monthlyPaymentLabel.text = "$" + "\(Int(myMortgagePayment))" + " per month"
    }
    
    // MARK: - Private
    private func updateViews() {
        // Updating interest rate label with slider value and getting the last two decimal places
        let interestRate = String(format: "%.2f", interestRateSlider.value)
        interestRateLabel.text = "%" + interestRate
    }
    
    // Once done with PickerView, Done button removes the picker
    @objc private func onDoneButtonTapped() {
        toolBar.removeFromSuperview()
        picker.removeFromSuperview()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
}

// MARK: - Extension
extension MortgageCalculatorViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        // After pressing return/enter textfield will harvest info, check if it's empty, and checks if value is a double
        if let number = downPaymentTextField.text, !number.isEmpty, number.isDouble{
            // This formats the string so that the string will only return a number with two decimal places
            let downPayment = Double(downPaymentTextField.text!)
            chosenDownPayment = Int32(downPayment!)
            downPaymentLabel.text = "$" + String(format: "%.2f", downPayment!)
            self.downPaymentTextField.resignFirstResponder()
        }
        
        if let mortgage = mortgageAmountTextField.text, !mortgage.isEmpty, mortgage.isDouble {
            // This formats the string so that the string will only return a number with two decimal places
            let mortgageAmount = Double(mortgageAmountTextField.text!)
            chosenPrincipal = Int32(mortgageAmount!)
            mortgageAmountLabel.text = "$" + String(format: "%.2f", mortgageAmount!)
            downPaymentTextField.becomeFirstResponder()
        }
        return true
    }
}

extension MortgageCalculatorViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return loanTerms.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(loanTerms[row])"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let currentTerm = loanTerms[row]
        chosenTerm = Int32(currentTerm)
        loanTermLabel.text = "\(currentTerm) years"
    }
    
}

// Extension to check if string is a double
extension String {
    var isDouble: Bool {
        Double(self) != nil
    }
}
