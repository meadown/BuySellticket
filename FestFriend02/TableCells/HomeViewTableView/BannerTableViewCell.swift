//
//  BannerTableViewCell.swift
//  FestFriend02
//
//  Created by MySoftheaven BD on 29/9/18.
//  Copyright © 2018 MySoftheaven BD. All rights reserved.
//

import UIKit
import MarqueeLabel

class BannerTableViewCell: UITableViewCell {

    // Timer
    var x = 1
    var scrollingTimer = Timer()
    @IBOutlet weak var bannerCollectionView: UICollectionView!
    @IBOutlet weak var lblTickerTabs: MarqueeLabel!
    
    
    var featuredFestivals: [FeatureFestival]?
    var tickerTabs: TickerTabs?
    
    var delegate: FestivalCellDelegate!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        let nib = UINib(nibName: String(describing: BannerCollectionViewCell.self), bundle: nil)
        bannerCollectionView.register(nib, forCellWithReuseIdentifier: "BannerCollectionViewCell")
        bannerCollectionView.delegate = self
        bannerCollectionView.dataSource = self
        self.setTimer()
        prepareTickerTabs()
    }
    
    private func prepareTickerTabs() {
        DispatchQueue.main.async {
            APICall.getTickerTabs { (tickerTabs) in
                if let tickerTabs = tickerTabs {
                    self.tickerTabs = tickerTabs
                    self.lblTickerTabs.attributedText = tickerTabs.getTickerString()
                }
            }
        }
    }
    
    func setTimer() {
        scrollingTimer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(BannerTableViewCell.autoScroll), userInfo: nil, repeats: true)
    }
    
    @objc func autoScroll() {
        
        if let featuredFests = featuredFestivals {
            if self.x < featuredFests.count {
                let indexPath = IndexPath(item: x, section: 0)
                self.bannerCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
                self.x = self.x + 1
            } else {
                self.x = 0
                self.bannerCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .centeredHorizontally, animated: true)
            }
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func configureCell(with featuredFestivals: [FeatureFestival]) {
        self.featuredFestivals = featuredFestivals
        bannerCollectionView.reloadData()
        lblTickerTabs.restartLabel()
    }
    
//    @objc func startTimer(theTimer : Timer) {
//        UIView.animate(withDuration: 1.0, delay: 0, options: .curveEaseIn, animations: {
//            self.bannerCollectionView.scrollToItem(at: IndexPath(row: theTimer.userInfo as! Int, section: 0), at: .centeredHorizontally, animated: true)
//        }, completion: nil)
//    }
    
  
    
    
}

extension BannerTableViewCell : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, SubFestivalCellDelegate, UIScrollViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let featuredFests = self.featuredFestivals {
            let rows = featuredFests.count
            return rows
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCollectionViewCell", for: indexPath) as! BannerCollectionViewCell
        let featuredFest = self.featuredFestivals![indexPath.row]
        cell.configureCell(with: featuredFest)
        cell.delegate = self
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate.festivalItemTapped(cell: self, index: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width  = collectionView.bounds.width
        let height = collectionView.bounds.height
        print("UICollectionViewLayout")
        return CGSize(width: width, height: height)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        print("minimumLineSpacingForSectionAt")
        return 0.0
    }
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        if (context.nextFocusedItem != nil) {
            bannerCollectionView.scrollToItem(at: context.nextFocusedItem as! IndexPath, at: .centeredHorizontally, animated: true)
        }
    }
    
    func bidOrAskedViewTapped(cell: UIView, flag: Int) {
        guard let index = bannerCollectionView.indexPath(for: cell as! UICollectionViewCell) else { return }
        delegate.bidOrAskedTapped(cell: self, index: index, flag: flag)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) { scrollingTimer.invalidate() }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        setTimer()
        x = bannerCollectionView.indexPathsForVisibleItems.first!.row
    }
    
}

