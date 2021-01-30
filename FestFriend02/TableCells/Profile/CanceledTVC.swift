//
//  CanceledTVC.swift
//  FestFriend02
//  Copyright © 2019 MySoftheaven BD. All rights reserved.
//

import UIKit

class CanceledTVC: UITableViewCell {
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblQuantity: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    
    var isCanceled: Bool!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(with data: UserBid) {
        var name = ""
        
        if let shortName = data.festivalShortName {
            name.append(shortName)
        }
        
        if let year = data.festivalYear {
            name.append(" \(year) - ")
        }
        
        if let subname = data.festivalSubName {
            name.append(subname)
        }
        
        if let tier = data.festivaltire {
            name.append(" \(tier)")
        }
        
        lblName.text = name
        
        if let qty = data.quantity {
            lblQuantity.text = qty
        } else {
            lblQuantity.text = ""
        }
        
        if let amount = data.bidAmount {
            lblAmount.text = "$\(amount)"
        } else {
            lblAmount.text = ""
        }
        
        if let date = data.createdAt {
            lblDate.text = getPurchaseCanceledFormatedDate(dateStr: date)
        } else {
            lblDate.text = ""
        }
        
        
        
        if let status = data.status {
                lblStatus.backgroundColor = UIColor.appGreenColor
                lblStatus.text = "Matched"
        } else {
            lblStatus.backgroundColor = UIColor.appRedColor
            lblStatus.text = "Canceled"
        }
    }
    
    func configureCell(with data: UserAsk) {
        var name = ""
        
        if let shortName = data.festivalShortName {
            name.append(shortName)
        }
        
        if let year = data.festivalYear {
            name.append(" \(year) - ")
        }
        
        if let subname = data.festivalSubName {
            name.append(subname)
        }
        
        if let tier = data.festivaltire {
            name.append(" \(tier)")
        }
        
        lblName.text = name
        
        if let qty = data.quantity {
            lblQuantity.text = qty
        } else {
            lblQuantity.text = ""
        }
        
        if let amount = data.askAmount {
            lblAmount.text = "$\(amount)"
        } else {
            lblAmount.text = ""
        }
        
        if let date = data.createdAt {
            lblDate.text = getPurchaseCanceledFormatedDate(dateStr: date)
        } else {
            lblDate.text = ""
        }
        
        if let status = data.status {
            if status.elementsEqual("2") {
                lblStatus.backgroundColor = UIColor.appRedColor
                lblStatus.text = "Show Label"
            } else {
                lblStatus.backgroundColor = UIColor.appGreenColor
                lblStatus.text = "Generate Label"
            }
        }
    }

}
