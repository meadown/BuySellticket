//
//  NewAskCollectionViewCell.swift
//  FestFriend02
//
//  Created by MySoftheaven BD on 5/9/18.
//  Copyright © 2018 MySoftheaven BD. All rights reserved.
//

import UIKit

class generalCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var festivalNameLabel: UILabel!
    @IBOutlet weak var ticketImageView: UIImageView!
    //@IBOutlet weak var containerView: UIView!
    @IBOutlet weak var festvalSUBnameAndTicketTier: UILabel!
    @IBOutlet weak var lowestAskLabel: UILabel!
    @IBOutlet weak var highestBidLabel: UILabel!
    @IBOutlet weak var sellOrAskContainerView: UIStackView!
    @IBOutlet weak var buyOrBidContainarView: UIStackView!
    
    var delegate: SubFestivalCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        containerView.layer.cornerRadius = 5.0
//        containerView.layer.masksToBounds = true
        ticketImageView.layer.cornerRadius = 5.0
        ticketImageView.layer.masksToBounds = true
        
        let tintView = UIView()
        tintView.backgroundColor = UIColor(white: 0, alpha: 0.2) //change to your liking
        tintView.frame = CGRect(x: 0, y: 0, width: ticketImageView.frame.width, height: ticketImageView.frame.height)
        tintView.layer.cornerRadius = 5.0
        tintView.layer.masksToBounds = true
        tintView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        ticketImageView.autoresizesSubviews = true
        ticketImageView.addSubview(tintView)
        print("this is collection view")
        addTapGestureToContainers()
       
    }
    
    private func addTapGestureToContainers() {
        let buyBidTapGesture = UITapGestureRecognizer(target: self, action: #selector(buyBidContainerAction(_:)))
        buyOrBidContainarView.addGestureRecognizer(buyBidTapGesture)
        
        let sellAskTapGesture = UITapGestureRecognizer(target: self, action: #selector(sellAskContainerAction(_:)))
        sellOrAskContainerView.addGestureRecognizer(sellAskTapGesture)
    }
    
    @objc func buyBidContainerAction(_ sender: UITapGestureRecognizer) {
        if let delegate = delegate {
            delegate.bidOrAskedViewTapped(cell: self, flag: 0)
        }
    }
    
    @objc func sellAskContainerAction(_ sender: UITapGestureRecognizer) {
        if let delegate = delegate {
            delegate.bidOrAskedViewTapped(cell: self, flag: 1)
        }
    }
    

}
