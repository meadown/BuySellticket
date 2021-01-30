//
//  SeeAllCollectionViewCell.swift
//  FestFriend02
//
//  Created by MySoftheaven BD on 6/10/18.
//  Copyright © 2018 MySoftheaven BD. All rights reserved.
//

import UIKit

class SeeAllCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var ticketImageView: UIImageView!{
        didSet{
            let tintView = UIView()
            tintView.backgroundColor = UIColor(white: 0, alpha: 0) //change to your liking
            tintView.frame = CGRect(x: 0, y: 0, width: ticketImageView.frame.width, height: ticketImageView.frame.height)
            tintView.layer.cornerRadius = 5.0
            tintView.layer.masksToBounds = true
            tintView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            ticketImageView.autoresizesSubviews = true
            ticketImageView.layer.masksToBounds = true
            ticketImageView.layer.cornerRadius = 5.0

            ticketImageView.addSubview(tintView)
            
//            let tintView = UIView()
//            tintView.backgroundColor = UIColor(white: 0, alpha: 0) //change to your liking
//            tintView.frame = CGRect(x: 0, y: 0, width: ticketImageView.frame.width, height: ticketImageView.frame.height)
//            tintView.layer.cornerRadius = 5.0
//            tintView.layer.masksToBounds = true
//            tintView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//            ticketImageView.autoresizesSubviews = true
//            ticketImageView.layer.cornerRadius = 5.0
//            ticketImageView.addSubview(tintView)
            

            
            
        }
    }
    @IBOutlet weak var lblFestivalName: UILabel!
    @IBOutlet weak var lblPlaceYear: UILabel!
    @IBOutlet weak var lblTicketTier: UILabel!
    @IBOutlet weak var lblValue: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    
    var saleData: NewHighestBid?
    var releaseCalendarData: ReleaseCalender?
    var festival: RelatedFestival?
    var product: RelatedProduct?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public func configureCell(with saleData: NewHighestBid) {
        self.saleData = saleData
        
        if let imgStr = saleData.imageURL {
            let imgUrl = URL(string: imgStr)
            ticketImageView.sd_setImage(with: imgUrl)
        }
        
        if let name = saleData.festivalShortName {
            lblFestivalName.text = name
        }
        
        if let place = saleData.festivalSubName, !place.isEmpty {
            let year = saleData.festivalYear ?? ""
            lblPlaceYear.text = "\(place) | \(year)"
        } else {
            let year = saleData.festivalYear ?? ""
            lblPlaceYear.text = "\(year)"
        }
        
        if let tier = saleData.ticketTier {
            lblTicketTier.text = tier
        }
        
        if let value = saleData.amount {
            lblValue.text = "$\(value)"
        } else {
            lblValue.text = ""
        }
        
        if let time = saleData.timeDifference {
            lblTime.text = time
        } else {
            lblTime.text = ""
        }
    }
    
    public func configureCell(with releaseCalendarData: ReleaseCalender) {
        self.releaseCalendarData = releaseCalendarData
        
        if let imgStr = releaseCalendarData.headerImage {
            let imgUrl = URL(string: imgStr)
            ticketImageView.sd_setImage(with: imgUrl)
        }
        
        if let name = releaseCalendarData.festivalShortName {
            lblFestivalName.text = name
        }
        
        if let place = releaseCalendarData.festivalSubName, let year = releaseCalendarData.festivalYear {
            
            if place == "" {
                lblPlaceYear.text = "\(year)"

            } else  {
                lblPlaceYear.text = "\(place) | \(year)"

            }
        }
        
        if let releaseDate = releaseCalendarData.relarceDate {
            let dateFormate = getBidAskExpiraryFormatedDate(dateStr: releaseDate)
            lblTicketTier.text = dateFormate
        }
        
        lblValue.isHidden = true
        lblTime.isHidden = true
    }
    func getBidAskExpiraryFormatedDate(dateStr: String) -> String {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd"
        let date = formatter.date(from: dateStr)
        formatter.dateFormat = "MM/dd/YY"
        return formatter.string(from: date!)
    }

    public func configureCell(with festival: RelatedFestival) {
        self.festival = festival
        
        if let imgStr = festival.headerImage {
            let imgUrl = URL(string: imgStr)
            ticketImageView.sd_setImage(with: imgUrl)
        }
        
        if let name = festival.festivalShortName {
            lblFestivalName.text = name
        }
        
        if let place = festival.festivalSubName, !place.isEmpty {
            let year = festival.festivalYear ?? ""
            lblPlaceYear.text = "\(place) | \(year)"
        } else {
            let year = festival.festivalYear ?? ""
            lblPlaceYear.text = year
        }
        
        lblTicketTier.isHidden = true
        lblValue.isHidden = true
        lblTime.isHidden = true
    }
    
    public func configureCell(with festival: RelatedProduct) {
        self.product = festival
        
        if let imgStr = festival.imageURL {
            let imgUrl = URL(string: imgStr)
            ticketImageView.sd_setImage(with: imgUrl)
        }
        
        if let name = festival.festivalShortName {
            lblFestivalName.text = name
        }
        
        if let place = festival.festivalSubName, !place.isEmpty {
            let year = festival.festivalYear ?? ""
            lblPlaceYear.text = "\(place) | \(year)"
        } else {
            let year = festival.festivalYear ?? ""
            lblPlaceYear.text = year
        }
        
        if let tier = festival.ticketTier {
            lblTicketTier.text = tier
        }
        
        lblValue.isHidden = true
        lblTime.isHidden = true
    }

}
