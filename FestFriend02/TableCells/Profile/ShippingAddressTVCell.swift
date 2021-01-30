//
//  ShippingAddressTVCell.swift
//  FestFriend02
//  Copyright © 2019 MySoftheaven BD. All rights reserved.
//

import UIKit

class ShippingAddressTVCell: UITableViewCell {
    
    @IBOutlet weak var lblAddressSerial: UILabel!
    @IBOutlet weak var lblAddressHeader: UILabel!
    @IBOutlet weak var lblStreetAddress: UILabel!
    @IBOutlet weak var lblAptSuitUnit: UILabel!
    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var lblState: UILabel!
    @IBOutlet weak var lblZipPostal: UILabel!
    @IBOutlet weak var lblCountry: UILabel!
    @IBOutlet weak var lblNotes: UILabel!
    @IBOutlet weak var lblIsActive: UILabel!
    @IBOutlet weak var container: UIView!
    
    var delegate: ShipingTVCDelegate!

    override func awakeFromNib() {
        super.awakeFromNib()
        lblIsActive.layer.cornerRadius = 3
        lblIsActive.layer.borderWidth = 1
        lblIsActive.layer.borderColor = UIColor.gray.cgColor
        
        container.layer.cornerRadius = 5
        container.layer.shadowOpacity = 0.5
        container.layer.shadowOffset = CGSize(width: 3, height: 3)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnEditAddressAction(_ sender: UIButton) {
        delegate.editBtnTapped(cell: self)
    }
    
    public func configureCell(with address: ShippingAddress1, index: Int) {
        lblAddressSerial.text = "Shiping Info #\(index + 1)"
        lblAddressHeader.text = address.name!
        lblStreetAddress.text = address.streetAddress!
        
        if let suite = address.aptSuiteUnit {
            lblAptSuitUnit.text = suite
        } else {
            lblAptSuitUnit.text = ""
        }
        lblCity.text = address.city!
        lblState.text = address.stateRegion!
        lblZipPostal.text = address.zipPostalCode!
        lblCountry.text = address.countryName!
        
        if let notes = address.notes {
            lblNotes.text = notes
        } else {
            lblNotes.text = ""
        }
        
        
        if let status = address.status, !status.isEmpty {
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

}
