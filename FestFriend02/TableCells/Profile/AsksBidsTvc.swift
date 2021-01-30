//
//  AsksBidsTvc.swift
//  FestFriend02
//  Copyright © 2019 MySoftheaven BD. All rights reserved.
//

import UIKit

class AsksBidsTvc: UITableViewCell {
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblQty: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    
    var delegate: AsksBidsTVCDelegate!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func configure(with currentAsk: CurrentAsk) {
        var name = ""
        
        if let shortName = currentAsk.festivalShortName {
            name.append(shortName)
        }
        
        if let year = currentAsk.festivalYear {
            name.append(" \(year) - ")
        }
        
        if let subname = currentAsk.festivalSubName {
            name.append(subname)
        }
        
        if let tier = currentAsk.festivaltire {
            name.append(" \(tier)")
        }
        
        lblName.text = name
        
        if let qty = currentAsk.quantity {
            lblQty.text = qty
        } else {
            lblQty.text = ""
        }
        
        if let amount = currentAsk.askAmount {
            lblAmount.text = "$\(amount)"
        } else {
            lblAmount.text = ""
        }
        
        if let expDate = currentAsk.expireDate {
            lblDate.text = getBidAskExpiraryFormatedDate(dateStr: expDate)
        } else {
            lblDate.text = ""
        }
        
    }
    
    func configure(with currentBid: CurrentBid) {
        var name = ""
        
        if let shortName = currentBid.festivalShortName {
            name.append(shortName)
        }
        
        if let year = currentBid.festivalYear {
            name.append(" \(year) - ")
        }
        
        if let subname = currentBid.festivalSubName {
            name.append(subname)
        }
        
        if let tier = currentBid.festivaltire {
            name.append(" \(tier)")
        }
        
        lblName.text = name
        
        if let qty = currentBid.quantity {
            lblQty.text = qty
        } else {
            lblQty.text = ""
        }
        
        if let amount = currentBid.bidAmount {
            lblAmount.text = "$\(amount)"
        } else {
            lblAmount.text = ""
        }
        
        if let expDate = currentBid.expireDate {
            lblDate.text = getBidAskExpiraryFormatedDate(dateStr: expDate)
        } else {
            lblDate.text = ""
        }
    }
    
    
    
    @IBAction func btnMenueAction(_ sender: UIButton) {
        delegate.detailsTapped(cell: self)
    }
    
    @IBAction func btnEditAction(_ sender: UIButton) {
        delegate.editTapped(cell: self)
    }
    
    @IBAction func btnDeleteAction(_ sender: UIButton) {
        delegate.deleteTapped(cell: self)
    }

}
