//
//  TicketsShowingTableViewCell.swift
//  FestFriend02
//
//  Created by MySoftheaven BD on 1/10/18.
//  Copyright © 2018 MySoftheaven BD. All rights reserved.
//

import UIKit

class TicketsShowingTableViewCell: UITableViewCell {

    @IBOutlet weak var sectionHeaderLabel: UILabel!
    @IBOutlet weak var seeAllButton: UIButton!
    @IBOutlet weak var ticketCollectionView: UICollectionView!
    
    var delegate : SeeAllTicketDelegate?
    var ticketDetailsDelegate : TicketToTicketDetailsDelegate?
    var festivalDelegate: FestivalViewDelegate?
    var festivalCellDelegate: FestivalCellDelegate?
    var mTicketDetailsDelegate: TicketDetailsDelegate?
    
    
    var salesData: [NewHighestBid]?
    var releaseCalendarData: [ReleaseCalender]?
    var festivals: [RelatedFestival]?
    var products: [RelatedProduct]?
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        ticketCollectionView.register(UINib(nibName: String(describing: SeeAllCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: SeeAllCollectionViewCell.self))
        
        ticketCollectionView.delegate = self
        ticketCollectionView.dataSource = self
        

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func showAllButtonPressed(_ sender: Any) {
        
        delegate?.showButtonTappped(cell: self)
    

    }
    
}

extension TicketsShowingTableViewCell : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    public func configureCell(with salesData: [NewHighestBid]?) {
        self.salesData = salesData
        initCollection()
        ticketCollectionView.reloadData()
    }
    
    public func configureCell(with releaseCalendarData: [ReleaseCalender]?) {
        self.releaseCalendarData = releaseCalendarData
        initCollection()
        ticketCollectionView.reloadData()
    }
    
    public func configureCell(with festivals: [RelatedFestival]) {
        self.festivals = festivals
        initCollection()
        ticketCollectionView.reloadData()
    }
    
    public func configureCell(with products: [RelatedProduct]) {
        self.products = products
        initCollection()
        ticketCollectionView.reloadData()
    }
    
    func initCollection (){
        let nib = UINib(nibName: String(describing: SeeAllCollectionViewCell.self), bundle: nil)
        ticketCollectionView.register(nib, forCellWithReuseIdentifier: String(describing: SeeAllCollectionViewCell.self))
        ticketCollectionView.delegate = self
        ticketCollectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let salesData = self.salesData {
            return salesData.count
        } else if let releseCalendarsData = self.releaseCalendarData {
            return releseCalendarsData.count
        } else if let festivals = self.festivals {
            return festivals.count
        } else if let products = products {
            return products.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: SeeAllCollectionViewCell.self), for: indexPath) as! SeeAllCollectionViewCell
        if let saleData = salesData?[indexPath.row] {
            cell.configureCell(with: saleData)
        } else if let release = releaseCalendarData?[indexPath.row] {
            cell.configureCell(with: release)
        } else if let festival = festivals?[indexPath.row] {
            cell.configureCell(with: festival)
        } else if let product = products?[indexPath.row] {
            cell.configureCell(with: product)
        }
        return cell
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       // let width  = collectionView.bounds.width / 2
        let width = (collectionView.bounds.width) / 2 - 10
        let height = collectionView.bounds.height
        print("UICollectionViewLayout")
        return CGSize(width: width, height: height)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        print("minimumLineSpacingForSectionAt")
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if ticketDetailsDelegate != nil {
            ticketDetailsDelegate?.ticketItemTapped(cell: self, index: indexPath)
        } else if let delegate = festivalDelegate {
            delegate.relatedFestClicked(in: indexPath)
        } else if let delegate = festivalCellDelegate {
            delegate.festivalItemTapped(cell: self, index: indexPath)
        } else if let delegate = mTicketDetailsDelegate {
            delegate.relatedProductsTapped(cell: self, indexPath: indexPath)
        }
    }
    
    override func prepareForReuse() {
        delegate = nil
        ticketDetailsDelegate = nil
        festivalDelegate = nil
        festivalCellDelegate = nil
        mTicketDetailsDelegate = nil
        
        
        salesData = nil
        releaseCalendarData = nil
        festivals = nil
        products = nil
    }
    
}
