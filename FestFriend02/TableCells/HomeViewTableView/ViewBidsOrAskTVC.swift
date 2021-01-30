//
//  ViewBidsOrAskTVC.swift
//  FestFriend02
//  Copyright © 2019 MySoftheaven BD. All rights reserved.
//

import UIKit

class ViewBidsOrAskTVC: UITableViewCell {
    
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblQty: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblCondition: UILabel!
    
    let conditions = ["Wristband Only", "In Original Box"]

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func configureCell<T>(with data: T) {
        if let bid = data as? Bid {
            configureCell(with: bid)
        } else if let askOrSale = data as? AskOrSales {
            configureCell(with: askOrSale)
        }
    }
    
    private func configureCell(with askOrSale: AskOrSales) {
        if let date = askOrSale.updatedAt {
            lblDate.text = getFormatedDateStr(from: date)
        } else {
            lblDate.text = ""
        }
        
        if let qty = askOrSale.quantity {
            lblQty.text = qty
        } else {
            lblQty.text = ""
        }
        
        if let price = askOrSale.amount {
            lblPrice.text = "$\(price)"
        } else {
            lblPrice.text = ""
        }
        
//        if let condition = askOrSale.inOriginalBox {
//            let conditionInt = Int(condition)!
//            lblCondition.text = conditions[conditionInt]
//        }
    }
    
    private func configureCell(with bid: Bid) {
        if let date = bid.updatedAt {
            lblDate.text = getFormatedDateStr(from: date)
        } else {
            lblDate.text = ""
        }
        
        if let qty = bid.quantity {
            lblQty.text = qty
        } else {
            lblQty.text = ""
        }
        
        if let price = bid.amount {
            lblPrice.text = "$\(price)"
        } else {
            lblPrice.text = ""
        }
        
//        if let condition = bid.inOriginalBox {
//            let conditionInt = Int(condition)!
//            lblCondition.text = conditions[conditionInt - 1]
//        } else {
//            lblCondition.text = ""
//        }
    }
    
    private func getFormatedDateStr(from date: String) -> String {
        let gotDateFormat = "YYYY-MM-dd HH:mm:ss"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = gotDateFormat
        let gotDate = dateFormatter.date(from: date)
        
        let outPutFormat = "MM/dd/YYYY"
        dateFormatter.dateFormat = outPutFormat
        let outputDate = dateFormatter.string(from: gotDate!)
        return outputDate
    }

}
