//
//  TicketInfoTableViewCell.swift
//  FestFriend02
//  Copyright © 2018 MySoftheaven BD. All rights reserved.
//

import UIKit

class TicketInfoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblCityYear: UILabel!
    @IBOutlet weak var lblTier: UILabel!
    @IBOutlet weak var conditionContainer: UIView!
    @IBOutlet weak var lblCondition: UILabel!
    @IBOutlet weak var lblLastSaleValue: UILabel!
    @IBOutlet weak var lblLastSalecondition: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var imgCondition: UIImageView!
    
    private var details: TicketDetails!
    var delegate: TicketInfoTVCCellDelegate!

    override func awakeFromNib() {
        super.awakeFromNib()
        let tap = UITapGestureRecognizer(target: self, action: #selector(lblConditionTapped(_ :)))
        conditionContainer.addGestureRecognizer(tap)
        
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(lblNameTapped(_:)))
        lblName.addGestureRecognizer(tap1)
        
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(lblNameTapped(_:)))
        lblCityYear.addGestureRecognizer(tap2)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func configureCell(with details: TicketDetails) {
        
        self.details = details
        
//        if let subname = details.festivalSubName {
//            lblCityYear.isHidden = false
//            lblCityYear.text = subname
//        } else {
//            lblCityYear.isHidden = true
//        }
        
        if let city = details.festivalSubName, !city.isEmpty {
            let year = details.festivalYear ?? ""
            lblCityYear.text = "\(city) | \(year)"
        } else {
            lblCityYear.text = details.festivalYear ?? ""
        }
        
        lblName.text = details.festivalShortName ?? ""
        
        //lblName.text = (details.festivalShortName ?? "") + (details.festivalYear ?? "")
        
        if let tier = details.ticketTier {
            lblTier.text = tier
        } else {
            lblTier.text = ""
        }
        
        if let status = details.status {
            if status.elementsEqual("1") {
                lblCondition.text = "Condition: In Original Box"
            } else {
                lblCondition.text = "Condition:  Wristband Only"
            }
        }
        
        if let lastSale = details.lastSale, !lastSale.isEmpty {
            lblLastSaleValue.text = "$\(lastSale)"
            
            if let secondLastSale = details.secondlastSale, !secondLastSale.isEmpty {
                let lastSaleInt = Int(lastSale)!
                let secondLastSaleInt = Int(secondLastSale)!
                
                if lastSaleInt > secondLastSaleInt {
                    lblLastSalecondition.textColor = UIColor.green
                    lblLastSalecondition.text = "+$\(lastSaleInt - secondLastSaleInt) (\(details.lastTwoSaleCombination!))"
                } else {
                    lblLastSalecondition.textColor = UIColor.red
                    lblLastSalecondition.text = "-$\(secondLastSaleInt - lastSaleInt) (\(details.lastTwoSaleCombination!))"
                }
            } else {
                lblLastSalecondition.text = ""
            }
        } else {
            lblLastSaleValue.text = "$--"
            lblLastSalecondition.text = ""
        }
        
        if let description = details.description {
            
            do {
                let descData = description.data(using: String.Encoding.unicode)
                let font = UIFont.systemFont(ofSize: 15.0)
                let attrDesc = try NSAttributedString(data: descData!, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
                let attr = NSMutableAttributedString(attributedString: attrDesc)
                attr.addAttribute(.font, value: font, range: NSRange(location: 0, length: attrDesc.length))
                lblDescription.attributedText = attr
            } catch {
                lblDescription.text = details.description ?? ""
                print(error.localizedDescription)
            }
        }
        
    }
    
    @objc func lblConditionTapped(_ sender: UITapGestureRecognizer) {
        delegate.lblConditionTapped(cell: self)
    }
    
    @objc func lblNameTapped(_ sender: UITapGestureRecognizer) {
        delegate.lblNameYearTapped()
    }
    
    @IBAction func btnViewAllSalesAction(_ sender: UIButton) {
        delegate.viewAllSalesTapped()
    }
    
}
