//
//  CommonCollectionViewCell.swift
//  FestFriend02
//
//  Created by MySoftheaven BD on 26/9/18.
//  Copyright © 2018 MySoftheaven BD. All rights reserved.
//

import UIKit
import SDWebImage

class CommonTableViewCell: UITableViewCell {

    @IBOutlet weak var sectionHeaderLabel: UILabel!
    @IBOutlet weak var generalCollectionView: UICollectionView!
    
    var delegate : FestivalCellDelegate?
    var upcommingFestivals : [UpcomingFestival]?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let nib = UINib(nibName: String(describing: generalCollectionViewCell.self), bundle: nil)
        generalCollectionView.register(nib, forCellWithReuseIdentifier: "collectionViewCell")
        generalCollectionView.delegate = self
        generalCollectionView.dataSource = self
    }
    
    func setUpcommingFestivals(with info: [UpcomingFestival]?) {
        self.upcommingFestivals = info
        self.initCollection()
        self.generalCollectionView.reloadData()
    }
    
    func initCollection()
    {
        self.generalCollectionView.dataSource = self
        self.generalCollectionView.delegate = self
        let nib = UINib(nibName: String(describing: generalCollectionViewCell.self), bundle: nil)
        generalCollectionView.register(nib, forCellWithReuseIdentifier: "collectionViewCell")
    }

}

extension CommonTableViewCell : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, SubFestivalCellDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let festivals = upcommingFestivals {
            return festivals.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! generalCollectionViewCell
        cell.delegate = self
        
        if self.upcommingFestivals != nil {
            let festival = self.upcommingFestivals![indexPath.row]
            
            if let imgUrlStr = festival.headerImage {
                let imgUrl = URL(string: imgUrlStr)
                cell.ticketImageView.sd_setImage(with: imgUrl)
            }
            
//            if let subName = festival.festivalSubName, let tier = festival.ticketTier {
//                cell.festvalSUBnameAndTicketTier.text = "\(subName)⎜\(tier)"
//            }
            
            if let subName = festival.festivalSubName, !subName.isEmpty {
                let year = festival.festivalYear ?? ""
                cell.festvalSUBnameAndTicketTier.text = "\(subName)⎜\(year)"
            } else {
                let year = festival.festivalYear ?? ""
                cell.festvalSUBnameAndTicketTier.text = "\(year)"
            }
            
            if let name = festival.festivalName {
                //cell.festivalNameLabel.text = name.uppercased()
                cell.festivalNameLabel.text = name
            }
            
            if let lowestAsk = festival.lowestAsk {
                cell.lowestAskLabel.text = "$\(lowestAsk)"
            }
            
            if let bid = festival.highestBid {
                cell.highestBidLabel.text = "$\(bid)"
            }
        }
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.festivalItemTapped(cell: self, index: indexPath)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width  = collectionView.bounds.width - 45
        let height = collectionView.bounds.height
        print("UICollectionViewLayout")
        return CGSize(width: width, height: height)

    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        print("minimumLineSpacingForSectionAt")
        return 12.0
    }
    
    func bidOrAskedViewTapped(cell: UIView, flag: Int) {
        guard let indexPath = generalCollectionView.indexPath(for: cell as! UICollectionViewCell) else { return }
        delegate?.bidOrAskedTapped(cell: self, index: indexPath, flag: flag)
    }
    
    
}
