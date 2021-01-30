//
//  CouponTVC.swift
//  FestFriend02
//  Copyright © 2019 MySoftheaven BD. All rights reserved.
//

import UIKit

class CouponTVC: UITableViewCell {
    
    @IBOutlet weak var lblCode: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var lblExpireDate: UILabel!
    @IBOutlet weak var lblCanBeUsed: UILabel!
    @IBOutlet weak var lblAlreadyUsed: UILabel!
    @IBOutlet weak var lblRemaining: UILabel!
    @IBOutlet weak var lblIsActive: UILabel!
    @IBOutlet weak var container: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        lblIsActive.layer.cornerRadius = 3
        lblIsActive.layer.borderWidth = 1
        
        container.layer.cornerRadius = 5
        container.layer.shadowOpacity = 0.5
        container.layer.shadowOffset = CGSize(width: 3, height: 3)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func configureCell(with coupon: Coupon) {
        lblCode.text = coupon.code!
        lblAmount.text = coupon.amount!
        lblExpireDate.text = coupon.expireDate!
        lblCanBeUsed.text = coupon.canBeUse!
        lblAlreadyUsed.text = coupon.alreadyUsed!
        
        if let canBeuse = coupon.canBeUse, !canBeuse.isEmpty, let used = coupon.alreadyUsed, !used.isEmpty {
            lblRemaining.text = "\(Int(canBeuse)! - Int(used)!)"
        } else {
            lblRemaining.text = ""
        }
        
        if let status = coupon.status {
            if status.elementsEqual("1") {
                lblIsActive.textColor = UIColor.appGreenColor
                lblIsActive.text = "Active"
            } else {
                lblIsActive.textColor = UIColor.appRedColor
                lblIsActive.text = "InActive"
            }
        } else {
            lblIsActive.text = ""
        }
        
    }
    
    private func getFormatedDateStr(date: String) -> String {
        let defaultFormat = "YYYY-MM-dd HH:mm:ss"
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = defaultFormat
        let date = dateFormat.date(from: date)
        dateFormat.dateFormat = "YYYY-MM-dd"
        return dateFormat.string(from: date!)
    }

}
