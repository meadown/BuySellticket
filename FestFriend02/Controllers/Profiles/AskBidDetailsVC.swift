//
//  AskBidDetailsVC.swift
//  FestFriend02
//
//  Created by Kazi Abdullah Al Mamun on 16/2/19.
//  Copyright © 2019 MySoftheaven BD. All rights reserved.
//

import UIKit

class AskBidDetailsVC: UIViewController {
    
    @IBOutlet weak var lblHeading: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblQty: UILabel!
    @IBOutlet weak var lblAskBidAmountLabel: UILabel!
    @IBOutlet weak var lblAskBidAmount: UILabel!
    @IBOutlet weak var lblTotalAmount: UILabel!
    @IBOutlet weak var lblCouponDetails: UILabel!
    @IBOutlet weak var lblCouponAmount: UILabel!
    @IBOutlet weak var lblHighestBid: UILabel!
    @IBOutlet weak var lblLowestAsk: UILabel!
    @IBOutlet weak var lblAskBidDateLabel: UILabel!
    @IBOutlet weak var lblAskBidDate: UILabel!
    @IBOutlet weak var lblAskBidExpireLabel: UILabel!
    @IBOutlet weak var lblAskBidExpire: UILabel!
    
    var currentAsk: CurrentAsk?
    var currentBid: CurrentBid?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let currentAsk = currentAsk {
            lblHeading.text = "Ask Details"
            lblAskBidAmountLabel.text = "Ask Amount"
            lblAskBidDateLabel.text = "Ask Date"
            lblAskBidExpireLabel.text = "Ask Expires"
            populateViews(with: currentAsk)
            
        } else if let currentBid = currentBid {
            lblHeading.text = "Bid Details"
            lblAskBidAmountLabel.text = "Bid Amount"
            lblAskBidDateLabel.text = "Bid Date"
            lblAskBidExpireLabel.text = "Bid Expires"
            populateViews(with: currentBid)
        }
    }
    
    private func populateViews(with ask: CurrentAsk) {
        lblName.text = "\(ask.festivalShortName!) \(ask.festivalYear!) - \(ask.festivalSubName!) \(ask.festivaltire!)"
        title = "\(ask.festivalShortName!) \(ask.festivalYear!) - \(ask.festivalSubName!) \(ask.festivaltire!)"
        lblQty.text = ask.quantity!
        lblAskBidAmount.text = "$ \(ask.askAmount!)"
        lblTotalAmount.text = "$ \(ask.totalAmount!)"
        lblCouponDetails.text = ""
        lblCouponAmount.text = ""
        
        if let highestBid = ask.highestBidAll, !highestBid.isEmpty {
            if let qty = ask.highestBidAllQty {
                lblHighestBid.text = "$ \(highestBid) [Qty: \(qty)]"
            } else {
                lblHighestBid.text = "$ \(highestBid) [Qty: --]"
            }
        } else {
            lblHighestBid.text = "$ -- [Qty: --]"
        }
        
        if let lowesAsk = ask.lowestAskAll, !lowesAsk.isEmpty {
            if let qty = ask.lowestAskAllQty {
                lblLowestAsk.text = "$ \(lowesAsk) [Qty: \(qty)]"
            } else {
                lblLowestAsk.text = "$ \(lowesAsk) [Qty: --]"
            }
        } else {
            lblLowestAsk.text = "$ -- [Qty: --]"
        }
        
        if let createdDate = ask.createdAt {
            lblAskBidDate.text = getFormatedCreatedDate(createdDate: createdDate)
        } else {
            lblAskBidDate.text = ""
        }
        
        if let expireDate = ask.expireDate {
            lblAskBidExpire.text = getFormatedExpireDate(expireDate: expireDate)
        } else {
            lblAskBidExpire.text = ""
        }
    }
    
    private func populateViews(with bid: CurrentBid) {
        lblName.text = "\(bid.festivalShortName!) \(bid.festivalYear!) - \(bid.festivalSubName!) \(bid.festivaltire!)"
        title = "\(bid.festivalShortName!) \(bid.festivalYear!) - \(bid.festivalSubName!) \(bid.festivaltire!)"
        lblQty.text = bid.quantity!
        lblAskBidAmount.text = "$ \(bid.bidAmount!)"
        lblTotalAmount.text = "$ \(bid.totalAmount!)"
        lblCouponDetails.text = ""
        lblCouponAmount.text = ""
        
        if let highestBid = bid.highestBidAll, !highestBid.isEmpty {
            if let qty = bid.highestBidAllQty {
                lblHighestBid.text = "$ \(highestBid) [Qty: \(qty)]"
            } else {
                lblHighestBid.text = "$ \(highestBid) [Qty: --]"
            }
        } else {
            lblHighestBid.text = "$ -- [Qty: --]"
        }
        
        if let lowesAsk = bid.lowestAskAll, !lowesAsk.isEmpty {
            if let qty = bid.lowestAskAllQty {
                lblLowestAsk.text = "$ \(lowesAsk) [Qty: \(qty)]"
            } else {
                lblLowestAsk.text = "$ \(lowesAsk) [Qty: --]"
            }
        } else {
            lblLowestAsk.text = "$ -- [Qty: --]"
        }
        
        if let createdDate = bid.createdAt {
            lblAskBidDate.text = getFormatedCreatedDate(createdDate: createdDate)
        } else {
            lblAskBidDate.text = ""
        }
        
        if let expireDate = bid.expireDate {
            lblAskBidExpire.text = getFormatedExpireDate(expireDate: expireDate)
        } else {
            lblAskBidExpire.text = ""
        }
    }
    
    private func getFormatedCreatedDate(createdDate: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: createdDate)
        dateFormatter.dateFormat = "dd-MMM-YYYY"
        return dateFormatter.string(from: date!)
    }
    
    private func getFormatedExpireDate(expireDate: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        let date = dateFormatter.date(from: expireDate)
        dateFormatter.dateFormat = "dd-MMM-YYYY"
        return dateFormatter.string(from: date!)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
