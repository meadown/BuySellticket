//
//  SearchResultTVC.swift
//  FestFriend02
//  Copyright © 2019 MySoftheaven BD. All rights reserved.
//

import UIKit

class SearchResultTVC: UITableViewCell {
    
    @IBOutlet weak var festivalImage: UIImageView!
    @IBOutlet weak var lblShortName: UILabel!
    @IBOutlet weak var lblSubnameYear: UILabel!
    @IBOutlet weak var lblTier: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
