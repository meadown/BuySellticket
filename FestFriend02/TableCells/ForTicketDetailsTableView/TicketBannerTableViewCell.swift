//
//  TicketBannerTableViewCell.swift
//  FestFriend02
//  Copyright © 2018 MySoftheaven BD. All rights reserved.
//

import UIKit

class TicketBannerTableViewCell: UITableViewCell {

    @IBOutlet weak var ticketImageView: UIImageView!{
        didSet {
            let tintView = UIView()
            tintView.backgroundColor = UIColor(white: 0, alpha: 0) //change to your liking
            tintView.frame = CGRect(x: 0, y: 0, width: ticketImageView.frame.width, height: ticketImageView.frame.height)
            tintView.layer.cornerRadius = 0.0
            tintView.layer.masksToBounds = true
            tintView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            ticketImageView.autoresizesSubviews = true
            ticketImageView.addSubview(tintView)
        }
    }
    @IBOutlet weak var selectQunatityButtton: UIButton!{
        didSet{
            selectQunatityButtton.layer.cornerRadius = 5.0
            selectQunatityButtton.layer.masksToBounds = true
        }
    }
    
    var delegate: TicketBannerTVCDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnSelectQuantityAction(_ sender: UIButton) {
        delegate.btnSelectQuantityTapped(cell: self)
    }
    
}
