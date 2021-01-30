//
//  ConfirmViewController.swift
//  FestFriend02
//
//  Created by Biswajit Banik on 3/8/19.
//  Copyright © 2019 MySoftheaven BD. All rights reserved.
//

import UIKit

class ConfirmViewController: UIViewController {
    
    @IBOutlet weak var lblHeading: UILabel!
    @IBOutlet weak var lblHeadingDetails: UILabel!
    @IBOutlet weak var lblFestivalShortName: UILabel!
    @IBOutlet weak var lblFestivalSubNameYear: UILabel!
    @IBOutlet weak var lblTier: UILabel!
    @IBOutlet weak var lblQuantity: UILabel!
    @IBOutlet weak var imgHeader: UIImageView!
    @IBOutlet weak var btnConfirmAskBid: UIButton!
    
    @IBOutlet weak var noteOne: UILabel!
    @IBOutlet weak var noteTwo: UILabel!
    @IBOutlet weak var noteThree: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.populateData()
         self.navigationItem.setHidesBackButton(true, animated:true);
        // Do any additional setup after loading the view.
    }
    var bidAskModel: BidAskModel!

    private func populateData() {
        
        let titleAttributes = [
            NSAttributedStringKey.font: UIFont.systemFont(ofSize: 15 , weight: UIFont.Weight.heavy),
            NSAttributedStringKey.foregroundColor: UIColor.black
        ]
        self.navigationController?.navigationBar.titleTextAttributes = titleAttributes
//        self.setMultilineTitle(title: "\(bidAskModel.shortName!) \(bidAskModel.year!) - \(bidAskModel.subname!)\n\(bidAskModel.tier!)")
        //self.title = "\(bidAskModel.shortName!) \(bidAskModel.year!) - \(bidAskModel.subname!) \(bidAskModel.tier!)"
        
        if let imgStr = bidAskModel.headerImgUrl {
            let url = URL(string: imgStr)
            imgHeader.sd_setImage(with: url)
        }
        
        
        
        //lblHeadingDetails.text = "Your Ask for $\(bidAskModel.totalAmount) live"
        
        lblFestivalShortName.text = bidAskModel.shortName != nil ? bidAskModel.shortName! : ""
        
        if let subName = bidAskModel.subname {
            if let year = bidAskModel.year {
                lblFestivalSubNameYear.text = "\(subName) | \(year)"
            } else {
                lblFestivalSubNameYear.text = subName
            }
        } else {
            lblFestivalSubNameYear.text = ""
        }
        
        lblTier.text = bidAskModel.tier != nil ? bidAskModel.tier! : ""
        lblQuantity.text = "Quantity: \(bidAskModel.quantity)"
        
        
        if bidAskModel.isBid! {
            btnConfirmAskBid.backgroundColor = UIColor.appGreenColor
            if bidAskModel.isAskBidStr == "Bid" {
                self.setMultilineTitle(title: "Bid Placed")
                let formattedString = NSMutableAttributedString()
                formattedString
                    .normal("Your Bid for")
                    .bold(" $\(Int(bidAskModel.value)) ")
                    .normal("is live")
                
                let bullet = "•  "
                       
                       var strings = [String]()
                       strings.append("Once a Seller accepts your Bid, the transaction will be processed immediately, and your designated payment method will be charged. (Note: your selected payment method on file will have an authorization hold while your bid is active, but no funds will be taken until you have been matched with a Seller).")
                       strings.append("You can edit, update, or cancel your Bid at any time prior to being accepted by a Seller.")
                       strings.append("All tickets facilitated through the FestFriends platform are protected by our Buyer Protection. We will always do everything we can to get you a legitimate ticket.")
                strings = strings.map { return  bullet + $0 }
                       
                       var attributes = [NSAttributedStringKey: Any]()
                       attributes[.font] = UIFont.preferredFont(forTextStyle: .body)
                      // attributes[.foregroundColor] = UIColor.darkGray
                       
                       let paragraphStyle = NSMutableParagraphStyle()
                       paragraphStyle.headIndent = (bullet as NSString).size(withAttributes: attributes).width
                       attributes[.paragraphStyle] = paragraphStyle

                       let string = strings.joined(separator: "\n\n")
                       noteOne.attributedText = NSAttributedString(string: string, attributes: attributes)

                lblHeadingDetails.attributedText = formattedString
            } else {
                self.setMultilineTitle(title: "Purchase Completed")
                let formattedString = NSMutableAttributedString()
                formattedString
                    .normal("You have purchased this item for ")
                    .bold("$\(bidAskModel.totalAmount)")
               
                let bullet = "•  "
                                      
                var strings = [String]()
                strings.append("Your seller will be required to mail us the wristband tickets for authentication. Once we’ve completed this process, we will then mail the ticket(s) to you. ")
                strings.append("You will receive more information via email regarding the status of your order, including tracking information.")
                strings.append("All tickets facilitated through the FestFriends platform are protected by our Buyer Protection. We will always do everything we can to get you a legitimate ticket.")
                strings = strings.map { return bullet + $0 }
                                      
                var attributes = [NSAttributedStringKey: Any]()
                attributes[.font] = UIFont.preferredFont(forTextStyle: .body)
            // attributes[.foregroundColor] = UIColor.darkGray
                                      
                let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.headIndent = (bullet as NSString).size(withAttributes: attributes).width
                attributes[.paragraphStyle] = paragraphStyle

                let string = strings.joined(separator: "\n\n")
                noteOne.attributedText = NSAttributedString(string: string, attributes: attributes)
                
            
                lblHeadingDetails.attributedText = formattedString
            }
            
        } else {
            lblHeading.text = "Success!"
            if bidAskModel.isAskBidStr == "Sell" {
                self.setMultilineTitle(title: "Sell Completed")
                let formattedString = NSMutableAttributedString()
                formattedString
                    .normal("You have sold this item for ")
                    .bold(" $\(bidAskModel.totalAmount)")
                
                
                
                let bullet = "•  "
                                                     
                               var strings = [String]()
                               strings.append("You are now entered in a binding agreement to sell the designated item at the price you indicated. You must ship the tickets to FestFriends within the specified timeframe.")
                               strings.append("You will receive shipping information with instructions on how to send us the ticket in the mail. Depending on the timing of the transaction, you may be required to ship immediately, or later. You will be paid out via the bank account you elected, upon receipt and authentication of the wristband(s) by a FestFriends team member.")
                               strings.append("There is a minimum 15% penalty for failure to ship within the timeframe indicated, or for a ticket received that is not authentic, the correct type/type/quantity, or in any way different than listed. We also reserve the right to charge for any costs we incur in the event that we need to provide a replacement to the buyer.")
                               strings = strings.map { return bullet + $0 }
                                                     
                               var attributes = [NSAttributedStringKey: Any]()
                               attributes[.font] = UIFont.preferredFont(forTextStyle: .body)
                           // attributes[.foregroundColor] = UIColor.darkGray
                                                     
                               let paragraphStyle = NSMutableParagraphStyle()
                               paragraphStyle.headIndent = (bullet as NSString).size(withAttributes: attributes).width
                               attributes[.paragraphStyle] = paragraphStyle

                               let string = strings.joined(separator: "\n\n")
                               noteOne.attributedText = NSAttributedString(string: string, attributes: attributes)
                               
                lblHeadingDetails.attributedText = formattedString
                
            } else {
                self.setMultilineTitle(title: "Ask Placed")
                let formattedString = NSMutableAttributedString()
                formattedString
                    .normal("Your Ask for")
                    .bold(" $\(Int(bidAskModel.value)) ")
                    .normal("is live")
                lblHeadingDetails.attributedText = formattedString
                
                
                let bullet = "•  "
                                                     
                               var strings = [String]()
                               strings.append("Once a Buyer accepts your Ask, you are obligated to complete the transaction by providing the designated ticket. You will be paid out via the bank account you elected, upon receipt and authentication of the wristband(s) by a FestFriends team member. ")
                               strings.append("You can edit, update, or cancel your Ask at any time prior to being accepted by a Buyer.")
                               strings.append("There is a minimum 15% penalty for failure to ship within the timeframe indicated, or for a ticket received that is not authentic, the correct type/type/quantity, or in any way different than listed. We also reserve the right to charge for any costs we incur in the event that we need to provide a replacement to the buyer.")
                               strings = strings.map { return bullet + $0 }
                                                     
                               var attributes = [NSAttributedStringKey: Any]()
                               attributes[.font] = UIFont.preferredFont(forTextStyle: .body)
                           // attributes[.foregroundColor] = UIColor.darkGray
                                                     
                               let paragraphStyle = NSMutableParagraphStyle()
                               paragraphStyle.headIndent = (bullet as NSString).size(withAttributes: attributes).width
                               attributes[.paragraphStyle] = paragraphStyle

                               let string = strings.joined(separator: "\n\n")
                               noteOne.attributedText = NSAttributedString(string: string, attributes: attributes)
            }
            
            btnConfirmAskBid.backgroundColor = UIColor.appRedColor
        }
        btnConfirmAskBid.setTitle("OK", for: .normal)
        
    }
    
    
    
    @IBAction func btnConfirmAskBidAction(_ sender: Any) {
        
        
        var festDetailsVC: TicketDetailsViewController?
        
        for vc in (navigationController?.viewControllers)! {
            if vc is TicketDetailsViewController {
                festDetailsVC = vc as! TicketDetailsViewController
                break
            }
        }
        
        navigationController?.popToViewController(festDetailsVC!, animated: true)
    }
    

}
extension NSMutableAttributedString {
    @discardableResult func bold(_ text: String) -> NSMutableAttributedString {
        let attrs: [NSAttributedStringKey: Any] = [.font: UIFont.boldSystemFont(ofSize: 20)]
        let boldString = NSMutableAttributedString(string:text, attributes: attrs)
        append(boldString)
        
        return self
    }
    
    @discardableResult func normal(_ text: String) -> NSMutableAttributedString {
        let normal = NSAttributedString(string: text)
        append(normal)
        
        return self
    }
    
    
    
    /*@objc func updateUI() {

        let bullet = "•  "
        
        var strings = [String]()
        strings.append("Payment will be charged to your iTunes account at confirmation of purchase.")
        strings.append("Your subscription will automatically renew unless auto-renew is turned off at least 24-hours before the end of the current subscription period.")
        strings.append("Your account will be charged for renewal within 24-hours prior to the end of the current subscription period.")
        strings.append("Automatic renewals will cost the same price you were originally charged for the subscription.")
        strings.append("You can manage your subscriptions and turn off auto-renewal by going to your Account Settings on the App Store after purchase.")
        strings.append("Read our terms of service and privacy policy for more information.")
        strings = strings.map { return bullet + $0 }
        
        var attributes = [NSAttributedStringKey: Any]()
        attributes[.font] = UIFont.preferredFont(forTextStyle: .body)
        attributes[.foregroundColor] = UIColor.darkGray
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.headIndent = (bullet as NSString).size(withAttributes: attributes).width
        attributes[.paragraphStyle] = paragraphStyle

        let string = strings.joined(separator: "\n\n")
        noteOne.attributedText = NSAttributedString(string: string, attributes: attributes)
    }
    */
    
    
}
