//
//  festivalInformationTableViewCell.swift
//  FestFriend02
//  Copyright © 2018 MySoftheaven BD. All rights reserved.
//

import UIKit

class festivalInformationTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblCityYear: UILabel!
    @IBOutlet weak var lblFestName: UILabel!
    @IBOutlet weak var lblAddress: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
