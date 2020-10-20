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
    
    // Variable to keep track of current created Mortgage
    var currentMortgage: Mortgage?
    
    // Variables that store UIAlertControllers that are ready to be presented at any time
    var interestAlertController: UIAlertController {
        let alert = UIAlertController(title: "Please adjust the interest rate slider",
                                      message: "Please choose an interest rate option that is greater than 0",
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alert.addAction(action)
        return alert
    }
    

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
        guard chosenInterest != 0 else {
            present(interestAlertController, animated: true)
            return
        }
        let myMortgage = Mortgage(term: term, principal: principal, interestRate: chosenInterest, downPayment: chosenDownPayment, montlyPayment: 0, totalCost: 0)
        self.currentMortgage = myMortgage
        // Calculating a mortgage payment
        let myMortgagePayment = mortgageController.calculateMortgagePayment(principal: myMortgage.principal,
                                                                            downPayment: myMortgage.downPayment,
                                                                            term: myMortgage.term,
                                                                            interestRate: myMortgage.interestRate)
        myMortgage.monthlyPayment = Double(myMortgagePayment)
        
        let totalCost = mortgageController.calculateTotalMortgageCost(mortgage: myMortgage)
        
        myMortgage.totalCost = Double(totalCost)
        
        // Updating and revealing the payment and total labels
        monthlyPaymentLabel.isHidden = false
        totalMortgageLabel.isHidden = false
        monthlyPaymentLabel.text = "$" + "\(myMortgagePayment)" + " per month"
        totalMortgageLabel.text  = "$\(totalCost)"
     }
    
    @IBAction func saveButtonTapped(_ sender: Any){
        guard let mortgage = currentMortgage else { print("No current mortgage to be found"); return}
//        mortgageController.savedMortgages.append(mortgage)
        mortgageController.saveToPersistentStore(mortgage: mortgage)
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

// MARK: - Extension -

extension MortgageCalculatorViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        // After pressing return/enter textfield will harvest info, check if it's empty, and checks if value is a double
        if let number = downPaymentTextField.text, !number.isEmpty, number.isDouble{
            // This formats the string so that the string will only return a number with two decimal places
            let downPayment = Double(downPaymentTextField.text!)
            chosenDownPayment = Int32(downPayment!)
            downPaymentLabel.text = "$" + String(format: "%.2f", downPayment!)
            downPaymentTextField.resignFirstResponder()
        }
        
        if let mortgage = mortgageAmountTextField.text, !mortgage.isEmpty, mortgage.isDouble {
            // This formats the string so that the string will only return a number with two decimal places
            let mortgageAmount = Double(mortgageAmountTextField.text!)
            chosenPrincipal = Int32(mortgageAmount!)
            mortgageAmountLabel.text = "$" + String(format: "%.2f", mortgageAmount!)
            
            if mortgageAmountTextField.isFirstResponder {
                downPaymentTextField.becomeFirstResponder()
            }
            
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

// This extension handles adding a 'done' button to any keyboard that appears when a textField is highlighted
extension UITextField {
    
    @IBInspectable var doneAccessory: Bool {
        
        get {
            return self.doneAccessory
        }
        set (hasDone) {
            if hasDone{
                addDoneButtonOnKeyboard()
            }
        }
    }
    
    func addDoneButtonOnKeyboard() {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction() {
        self.resignFirstResponder()
    }
}
