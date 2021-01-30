//
//  FestivalTicketTableViewCell.swift
//  FestFriend02
//  Copyright © 2019 MySoftheaven BD. All rights reserved.
//

import UIKit

class FestivalTicketTableViewCell: UITableViewCell {
    
    @IBOutlet weak var festImg: UIImageView!
    @IBOutlet weak var lblFestName: UILabel!
    @IBOutlet weak var lblTicketTier: UILabel!
    
    //var festivalTicket: FestivalTicket!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        festImg.image = #imageLiteral(resourceName: "Image")
        lblTicketTier.text = ""
        lblFestName.text = ""
    }
    
    func configureCell(festivalTicket: FestivalTicket) {
        
        if let imgUrl = festivalTicket.imageURL {
            let url = URL(string: imgUrl)
            festImg.sd_setImage(with: url)
        }
        
        if let festName = festivalTicket.festivalShortName {
            
            var name = festName
            
            if let subname = festivalTicket.festivalSubName, !subname.isEmpty {
                name.append(" - \(subname)")
            }
            
            lblFestName.text = name
        } else {
            lblFestName.text = ""
        }
        
        if let tier = festivalTicket.ticketTier {
            lblTicketTier.text = tier
        }
    }

}
