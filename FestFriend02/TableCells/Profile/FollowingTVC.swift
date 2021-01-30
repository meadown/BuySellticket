//
//  FollowingTVC.swift
//  FestFriend02
//  Copyright © 2019 MySoftheaven BD. All rights reserved.
//

import UIKit

class FollowingTVC: UITableViewCell {
    
    @IBOutlet weak var imgFestival: UIImageView!
    @IBOutlet weak var lblfestShortName: UILabel!
    @IBOutlet weak var lblfestSubName: UILabel!
    @IBOutlet weak var lblfestTickerTag: UILabel!
    
    var delegate: FollowingTVCDelegate!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        imgFestival.image = nil
        lblfestShortName.text = nil
        lblfestSubName.text = nil
        lblfestTickerTag.text = nil
    }
    
    func configureCell(with festival: FavFestival) {
        
        lblfestShortName.text = festival.festivalShortName!
        lblfestSubName.text = "\(festival.festivalSubName!) | \(festival.festivalYear!)"
        lblfestTickerTag.text = ""
        
        if let imgUrl = festival.image {
            let url = URL(string: imgUrl)
            imgFestival.sd_setImage(with: url)
        }
    }
    
    func configureCell(with ticket: FavTicket) {
        
        lblfestShortName.text = ticket.festivalShortName!
        lblfestSubName.text = "\(ticket.festivalSubName!) | \(ticket.festivalYear!)"
        lblfestTickerTag.text = ticket.ticketTier!
        
        if let imgUrl = ticket.image {
            let url = URL(string: imgUrl)
            imgFestival.sd_setImage(with: url)
        }
    }
    
    @IBAction func btnUnfollowTapped(_ sender: UIButton) {
        delegate.btnUnFollowTapped(cell: self)
    }

}
