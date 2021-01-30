//
//  festivalbannerTableViewCell.swift
//  FestFriend02
//  Copyright © 2018 MySoftheaven BD. All rights reserved.
//

import UIKit

class festivalbannerTableViewCell: UITableViewCell {

    @IBOutlet weak var festivalImageView: UIImageView! {
        didSet {
            let tintView = UIView()
            tintView.backgroundColor = UIColor(white: 0, alpha: 0.2) //change to your liking
            tintView.frame = CGRect(x: 0, y: 0, width: festivalImageView.frame.width, height: festivalImageView.frame.height)
            //tintView.layer.cornerRadius = 5.0
            tintView.layer.masksToBounds = true
            tintView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            festivalImageView.autoresizesSubviews = true
            //festivalImageView.backgroundColor = UIColor(white: 0, alpha: 0.5) //change to your liking

            festivalImageView.addSubview(tintView)
        }
    }
    @IBOutlet weak var lblBidValue: UILabel!
    @IBOutlet weak var lblAskValue: UILabel!
    @IBOutlet weak var sellOrAskContainerView: UIStackView!
    @IBOutlet weak var buyOrBidContainarView: UIStackView!
    
    var delegate: SubFestivalCellDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        addTapGestureToContainers()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
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
