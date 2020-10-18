//
//  MortgageCalculator.swift
//  BW4MortgageCalculator
//
//  Created by Waseem Idelbi on 10/14/20.
//

import Foundation

class MortgageController {
    
    // MARK: - Properties
    var savedMortgages: [Mortgage] = []
    
    // MARK: - Initalizer
    
    /// Singleton property
    static let shared = MortgageController()
    
    /// Methods
    func calculateMortgagePayment(principal: Int32, downPayment: Int32, term: Int32, interestRate: Double) -> Int32 {
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
        
        return Int32(payment)
    }
    
    func calculateTotalMortgageCost(mortgage: Mortgage) -> Int32 {
        
        let principal = mortgage.principal
        let term = mortgage.term
        let interestRate = mortgage.interestRate
        let numberOfPayments = mortgage.term * 12
        let downPayment = mortgage.downPayment
        let monthlyPayment = calculateMortgagePayment(principal: principal, downPayment: downPayment, term: term, interestRate: interestRate)
        
        let mortgageTotal = monthlyPayment * numberOfPayments
        return mortgageTotal
    }
    
    // MARK: - CRUD
    
    private var persistentFileURL: URL? {
        let fm = FileManager.default
        guard let directory = fm.urls(for: .documentDirectory, in: .userDomainMask) .first else { return nil}
        return directory.appendingPathComponent("mortgages.json")
    }
    
    func saveToPersistentStore(mortgage: Mortgage) {
        guard let url = persistentFileURL else { return }
        do {
            let dictionary = mortgage.toDictionary()
            let data = try JSONSerialization.data(withJSONObject: dictionary, options: [])
            try data.write(to:url)
            print("Save successful")
        } catch {
            print("Error saving mortgage data: \(error)")
        }
    }
    
    func loadFromPersistentStore() {
        let fm = FileManager.default
        guard let url = persistentFileURL, fm.fileExists(atPath: url.path) else { print("Could not find save data"); return}
        
        do {
            let data = try Data(contentsOf: url)
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            
        } catch {
            print("Error decoding saved data: \(error)")
        }
    }
    
} //End of class
