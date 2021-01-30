//
//  HomeViewControllerExtension+Table.swift
//  FestFriend02
//
//  Created by MySoftheaven BD on 26/9/18.
//  Copyright © 2018 MySoftheaven BD. All rights reserved.
//

import Foundation
import UIKit


extension HomeViewController : UITableViewDelegate, UITableViewDataSource, SeeAllTicketDelegate, FestivalCellDelegate, TicketToTicketDetailsDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let _ = homeviewInfo {
            return listArray.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            return bannerViewCell(index: indexPath)
        case 1:
            return upcommingFestivalsCell(index: indexPath)
        case 2:
            return popularFestivalsCell(index: indexPath)
        case 3:
            return recentlySoldTicketCell(index: indexPath)
        case 4:
            return newLowestTicketCell(index: indexPath)
        case 5:
            return newHighestBidsCell(index: indexPath)
        case 6:
            return releaseCalendarCell(index: indexPath)
        default:
            return UITableViewCell()
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            let height = ((mainFestFriendTable.frame.size.height) / 2.5) + 16
            return height
        case 1:
            let height = ((mainFestFriendTable.frame.size.height) / 2.5) + 16
            return height
        case 2:
            let height = ((mainFestFriendTable.frame.size.height) / 2.5) + 16
            return height
        case 3:
            //let height = ((mainFestFriendTable.frame.size.height) / 2) - 50
            let height = CGFloat(315.0)
            return height
        case 4:
            //let height = ((mainFestFriendTable.frame.size.height) / 2) - 50
            let height = CGFloat(315.0)
            return height
        case 5:
            //let height = ((mainFestFriendTable.frame.size.height) / 2) - 50
//            let height = CGFloat(10.0)
            let height = CGFloat(315.0)
            return height
            //return UITableViewAutomaticDimension

        case 6:
            let height = CGFloat(315.0)
            return height
        default:
            return UITableViewAutomaticDimension
        }
    }
//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 10    }
    
    func bannerViewCell(index: IndexPath) -> BannerTableViewCell {
        let bannerViewCell = mainFestFriendTable.dequeueReusableCell(withIdentifier: "BannerTableViewCell", for: index) as! BannerTableViewCell
        bannerViewCell.selectionStyle = .none
        bannerViewCell.delegate = self
        if let festivals = self.homeviewInfo?.featuredFestivals {
             bannerViewCell.configureCell(with: festivals)
        }
        
        return bannerViewCell
    }
    
    
    func upcommingFestivalsCell(index: IndexPath) -> CommonTableViewCell {
        let upcomingFestivalcell = mainFestFriendTable.dequeueReusableCell(withIdentifier: "commonCellID", for: index) as! CommonTableViewCell
        upcomingFestivalcell.selectionStyle = .none
        upcomingFestivalcell.delegate = self
        upcomingFestivalcell.setUpcommingFestivals(with: self.homeviewInfo?.upcomingFestivals)
        upcomingFestivalcell.sectionHeaderLabel.text = self.listArray[index.row]
        return upcomingFestivalcell
    }
    
    func popularFestivalsCell(index: IndexPath) -> CommonSecondTableViewCell {
        let popularFestivalCell = mainFestFriendTable.dequeueReusableCell(withIdentifier: "commonSecondCellID", for: index) as! CommonSecondTableViewCell
        popularFestivalCell.selectionStyle = .none
        popularFestivalCell.delegate = self
        popularFestivalCell.selctionHeaderLabel.text = self.listArray[index.row]
        popularFestivalCell.setPopularFestival(with: self.homeviewInfo?.popularFestivals)
        return popularFestivalCell
    }
    
    func recentlySoldTicketCell(index: IndexPath) -> TicketsShowingTableViewCell {
        let recentlySoldTicketCell = mainFestFriendTable.dequeueReusableCell(withIdentifier: String(describing: TicketsShowingTableViewCell.self), for: index) as! TicketsShowingTableViewCell
        recentlySoldTicketCell.selectionStyle = .none
        recentlySoldTicketCell.delegate = self
        recentlySoldTicketCell.ticketDetailsDelegate = self
        recentlySoldTicketCell.sectionHeaderLabel.text = self.listArray[index.row]
        recentlySoldTicketCell.configureCell(with: homeviewInfo?.recentSales)
        return recentlySoldTicketCell
    }
    
    func newLowestTicketCell(index: IndexPath) -> TicketsShowingTableViewCell {
        let newLowestTicketCell = mainFestFriendTable.dequeueReusableCell(withIdentifier: String(describing: TicketsShowingTableViewCell.self), for: index) as! TicketsShowingTableViewCell
        newLowestTicketCell.selectionStyle = .none
        newLowestTicketCell.delegate = self
        newLowestTicketCell.ticketDetailsDelegate = self
        newLowestTicketCell.sectionHeaderLabel.text = self.listArray[index.row]
        newLowestTicketCell.configureCell(with: homeviewInfo?.newLowestAsks)
        return newLowestTicketCell
    }
    
    func newHighestBidsCell(index: IndexPath) -> TicketsShowingTableViewCell {
        let newHighestBidsCell = mainFestFriendTable.dequeueReusableCell(withIdentifier: String(describing: TicketsShowingTableViewCell.self), for: index) as! TicketsShowingTableViewCell
        newHighestBidsCell.selectionStyle = .none
        newHighestBidsCell.delegate = self
        newHighestBidsCell.ticketDetailsDelegate = self
        newHighestBidsCell.sectionHeaderLabel.text = self.listArray[index.row]
        newHighestBidsCell.configureCell(with: homeviewInfo?.newHighestBids)
        return newHighestBidsCell
    }
    
    func releaseCalendarCell(index: IndexPath) -> TicketsShowingTableViewCell {
        let releaseCalendarCell = mainFestFriendTable.dequeueReusableCell(withIdentifier: String(describing: TicketsShowingTableViewCell.self), for: index) as! TicketsShowingTableViewCell
        releaseCalendarCell.selectionStyle = .none
        releaseCalendarCell.delegate = self
        releaseCalendarCell.festivalCellDelegate = self
        releaseCalendarCell.sectionHeaderLabel.text = self.listArray[index.row]
        releaseCalendarCell.configureCell(with: homeviewInfo?.releasedCalenders)
        return releaseCalendarCell
    }
    
    func showButtonTappped(cell: TicketsShowingTableViewCell) {
        guard let index = mainFestFriendTable.indexPath(for: cell)?.row else {
            return
        }
        print(index)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let showAllVC = storyboard.instantiateViewController(withIdentifier: String(describing: SeeAllViewController.self)) as! SeeAllViewController
        showAllVC.festType = listArray[index]
        
        switch index {
        case 3:
            showAllVC.festBidData = homeviewInfo?.recentSales
        case 4:
            showAllVC.festBidData = homeviewInfo?.newLowestAsks
        case 5:
            showAllVC.festBidData = homeviewInfo?.newHighestBids
            showAllVC.ticketFlag = 1
        case 6:
            showAllVC.festReleaseCalanderData = homeviewInfo?.releasedCalenders
            showAllVC.ticketFlag = 1
        default:
            print("Do nothing")
        }
        self.navigationController?.pushViewController(showAllVC, animated: true)
        
    }
    
    func festivalItemTapped(cell: UITableViewCell, index: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let festivalVC = storyboard.instantiateViewController(withIdentifier: String(describing: FestivalViewController.self)) as! FestivalViewController
        
        let mainCellIndex = mainFestFriendTable.indexPath(for: cell)
        
        switch mainCellIndex?.row {
        case 0:
            festivalVC.festivalId = homeviewInfo?.featuredFestivals![index.row].id
        case 1:
            festivalVC.festivalId = homeviewInfo?.upcomingFestivals![index.row].id
        case 2:
            festivalVC.festivalId = Int(homeviewInfo!.popularFestivals![index.row].id!)
        case 6:
            festivalVC.festivalId = homeviewInfo!.releasedCalenders![index.row].id!
        default:
            print("I am non used")
        }
        self.navigationController?.pushViewController(festivalVC, animated: true)
    }
    
    func bidOrAskedTapped(cell: UITableViewCell, index: IndexPath, flag: Int) {
        guard let mainCellIndex = mainFestFriendTable.indexPath(for: cell) else {
            return
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let ticketDetailsVC = storyboard.instantiateViewController(withIdentifier: String(describing: TicketDetailsViewController.self)) as! TicketDetailsViewController
        
        switch mainCellIndex.row {
        case 0:
            ticketDetailsVC.ticketId = homeviewInfo!.featuredFestivals![index.row].ticketID!
            ticketDetailsVC.typeFlag = flag
            self.navigationController?.pushViewController(ticketDetailsVC, animated: true)
        case 1:
            if case TicketID.integer(let id) = homeviewInfo!.upcomingFestivals![index.row].ticketID! {
                ticketDetailsVC.ticketId = id
                ticketDetailsVC.typeFlag = flag
                self.navigationController?.pushViewController(ticketDetailsVC, animated: true)
            }
        case 2:
            ticketDetailsVC.ticketId = homeviewInfo!.popularFestivals![index.row].ticketID!
            ticketDetailsVC.typeFlag = flag
            self.navigationController?.pushViewController(ticketDetailsVC, animated: true)
        default:
            print("")
        }
    }
    
    func ticketItemTapped(cell: UITableViewCell, index: IndexPath) {
        print("ticket item tapped")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let ticketDetailsVC = storyboard.instantiateViewController(withIdentifier: String(describing: TicketDetailsViewController.self)) as! TicketDetailsViewController
        
        guard let mainRow = mainFestFriendTable.indexPath(for: cell)?.row else { return }
        
        switch mainRow {
        case 3:
            if let ticketId = homeviewInfo?.recentSales?[index.row].ticketID {
                ticketDetailsVC.ticketId = ticketId
                ticketDetailsVC.typeFlag = 0
                self.navigationController?.pushViewController(ticketDetailsVC, animated: true)
            }
        case 4:
            if let ticketId = homeviewInfo?.newLowestAsks?[index.row].ticketID {
                ticketDetailsVC.ticketId = ticketId
                ticketDetailsVC.typeFlag = 0
                self.navigationController?.pushViewController(ticketDetailsVC, animated: true)
            }
        case 5:
            if let ticketId = homeviewInfo?.newHighestBids?[index.row].ticketID {
                ticketDetailsVC.ticketId = ticketId
                ticketDetailsVC.typeFlag = 1
                self.navigationController?.pushViewController(ticketDetailsVC, animated: true)
            }
        default:
            print("")
        }
    }
  
}
