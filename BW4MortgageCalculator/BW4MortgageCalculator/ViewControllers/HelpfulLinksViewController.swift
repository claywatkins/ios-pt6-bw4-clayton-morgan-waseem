//
//  HelpfulLinksViewController.swift
//  BW4MortgageCalculator
//
//  Created by Waseem Idelbi on 10/16/20.
//

import UIKit
import SafariServices

class HelpfulLinksViewController: UIViewController {

    //MARK: - Properties -
    
    // This url is for an article, it's a First-Time Homebuyer's Guide
    let buyerGuideURL = URL(string: "https://www.investopedia.com/updates/first-time-home-buyer/")!
    // This url is for a Quiz: Am I Ready To Buy A House?
    let quizURL = URL(string: "https://www.fortunebuilders.com/am-i-ready-to-buy-a-house/")!
    // This url is for a YouTube video: 10 Cheapest States to Buy a Home in America
    let videoURL = URL(string: "https://www.youtube.com/watch?v=h2kHXlj2PXU&ab_channel=WorldAccordingToBriggs")!
    // This url is for .....
    
    // This url is for .....
    
    // This url is for .....
    
    
    //MARK: - IBActions -
    
    @IBAction func guideButtonTapped(_ sender: UIButton) {
        let safariVC = SFSafariViewController(url: buyerGuideURL)
        present(safariVC, animated: true)
    }
    
    @IBAction func quizButtonTapped(_ sender: UIButton) {
        let safariVC = SFSafariViewController(url: quizURL)
        present(safariVC, animated: true)
    }
    
    @IBAction func videoButtonTapped(_ sender: UIButton) {
        let safariVC = SFSafariViewController(url: videoURL)
        present(safariVC, animated: true)
    }
    
}
