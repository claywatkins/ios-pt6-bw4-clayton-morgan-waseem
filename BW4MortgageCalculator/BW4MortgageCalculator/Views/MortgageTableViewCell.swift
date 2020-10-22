//
//  MortgageTableViewCell.swift
//  BW4MortgageCalculator
//
//  Created by Clayton Watkins on 10/22/20.
//

import UIKit

class MortgageTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var mortgageName: UILabel!
    
    
    
    // MARK: - Properties
    static let reuseIdentifier = "MortgageCell"
    var mortgage: Mortgage? {
        didSet{
            updateViews()
        }
    }
    
    
    // MARK: - Private Methods
    private func updateViews() {
        guard let mortgage = mortgage else { return }
        mortgageName.text = mortgage.name
    }
    
}
