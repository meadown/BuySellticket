//
//  BannerCollectionViewCell.swift
//  FestFriend02
//
//  Created by MySoftheaven BD on 29/9/18.
//  Copyright © 2018 MySoftheaven BD. All rights reserved.
//

import UIKit

class BannerCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var lblBidValue: UILabel!
    @IBOutlet weak var lblSellAskValue: UILabel!
    @IBOutlet weak var sellOrAskContainerView: UIStackView!
    @IBOutlet weak var buyOrBidContainarView: UIStackView!
    @IBOutlet weak var festivalNameLabel: UILabel!
    @IBOutlet weak var festvalSUBnameAndTicketTier: UILabel!
    
    var featuredFestival: FeatureFestival?
    var delegate: SubFestivalCellDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let tintView = UIView()
        tintView.backgroundColor = UIColor(white: 0, alpha: 0.2) //change to your liking
        tintView.frame = CGRect(x: 0, y: 0, width: bannerImageView.frame.width, height: bannerImageView.frame.height)
        //tintView.layer.cornerRadius = 5.0
        tintView.layer.masksToBounds = true
        tintView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        bannerImageView.autoresizesSubviews = true
        bannerImageView.addSubview(tintView)
    }
    
    public func configureCell(with festival: FeatureFestival) {
        featuredFestival = festival
        
        if let subName = featuredFestival?.festivalSubName, !subName.isEmpty {
            let year = featuredFestival?.festivalYear ?? ""
            festvalSUBnameAndTicketTier.text = "\(subName)⎜\(year)"
        } else {
            let year = featuredFestival?.festivalYear ?? ""
            festvalSUBnameAndTicketTier.text = "\(year)"
        }
        
        if let name = featuredFestival?.festivalName {
            //cell.festivalNameLabel.text = name.uppercased()
            festivalNameLabel.text = name
        }
        
        if let bidValue = festival.highestBid {
            lblSellAskValue.text = preparePriceText(bidValue)
        }
        
        if let selValue = festival.lowestAsk {
            lblBidValue.text = preparePriceText(selValue)
        }
        
        if let imageStr = featuredFestival?.headerImage {
            let imgUrl = URL(string: imageStr)
            DispatchQueue.main.async {
                self.bannerImageView.sd_setImage(with: imgUrl)
            }
        }
        
        addTapGestureToContainers()
    }
    
    private func preparePriceText(_ value: String) -> String {
        return "$ \(value)"
    }
    
    private func addTapGestureToContainers() {
        let buyBidTapGesture = UITapGestureRecognizer(target: self, action: #selector(buyBidContainerAction(_:)))
        buyOrBidContainarView.addGestureRecognizer(buyBidTapGesture)
        
        let sellAskTapGesture = UITapGestureRecognizer(target: self, action: #selector(sellAskContainerAction(_:)))
        sellOrAskContainerView.addGestureRecognizer(sellAskTapGesture)
    }
    
    @objc func buyBidContainerAction(_ sender: UITapGestureRecognizer) {
        delegate.bidOrAskedViewTapped(cell: self, flag: 0)
    }
    
    @objc func sellAskContainerAction(_ sender: UITapGestureRecognizer) {
        delegate.bidOrAskedViewTapped(cell: self, flag: 1)
    }

}
