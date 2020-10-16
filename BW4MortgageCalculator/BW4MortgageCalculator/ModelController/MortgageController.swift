//
//  MortgageCalculator.swift
//  BW4MortgageCalculator
//
//  Created by Waseem Idelbi on 10/14/20.
//

import Foundation

class MortgageController {
    
    /// Singleton property
    static let shared = MortgageController()
    
    /// Methods
    func calculateMortgagePayment(principal: Int32, downPayment: Int32, term: Int32, interestRate: Double) -> Double {
        //  convert the interest rate entered by user to percentage
        let interestRate100 = interestRate / 100
        //  taking the term [in years] * 12 to find number of monthly payments
        //  30 * 12 = 360
        let totalPayments: Double = Double(term) * 12
        //  the mortgage calculator uses i / 12 in places; will establish as a constant
        let i12 = interestRate100 / 12
        //  sought to break the mortgage formula into a numerator & demoninator
        let numerator1 = pow(Double(1 + i12), totalPayments)
        //  halve the numerator into parts
        let numerator2 = i12 * numerator1
        //  subtract down payment from the principal amount of the mortgage
        let principalAfterDownPayment = principal - downPayment
        //  bring numerators together into one constant
        let numerator = Double(principalAfterDownPayment) * numerator2
        //  find the denominator
        let denominator = (pow(Double(1 + i12), totalPayments)) - 1
        //  calculate the payment amount
        let payment = numerator / denominator
        return Double(payment)
    }
    
} //End of struct
