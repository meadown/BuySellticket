//
//  CommonSecondTableViewCell.swift
//  FestFriend02
//
//  Created by MySoftheaven BD on 29/9/18.
//  Copyright © 2018 MySoftheaven BD. All rights reserved.
//

import UIKit

class CommonSecondTableViewCell: UITableViewCell {

    @IBOutlet weak var selctionHeaderLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var delegate : FestivalCellDelegate?
    var popularFestivals : [PopularFestival]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let nib = UINib(nibName: String(describing: generalCollectionViewCell.self), bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "collectionViewCellSecond")
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setPopularFestival(with info: [PopularFestival]?) {
        self.popularFestivals = info
        initCollection()
        self.collectionView.reloadData()
    }
    
    func initCollection (){
        let nib = UINib(nibName: String(describing: generalCollectionViewCell.self), bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "collectionViewCellSecond")
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    
}

extension CommonSecondTableViewCell : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, SubFestivalCellDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let festivals = popularFestivals {
            return festivals.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCellSecond", for: indexPath) as! generalCollectionViewCell
        cell.delegate = self
        
        if self.popularFestivals != nil {
            let festival = self.popularFestivals![indexPath.row]
            
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
                cell.festvalSUBnameAndTicketTier.text = festival.festivalYear ?? ""
            }
            
            if let name = festival.festivalName {
//                cell.festivalNameLabel.text = name.uppercased()
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
        guard let indexPath = collectionView.indexPath(for: cell as! UICollectionViewCell) else { return }
        delegate?.bidOrAskedTapped(cell: self, index: indexPath, flag: flag)
    }
    
}
