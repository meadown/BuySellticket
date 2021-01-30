//
//  ticketCellDelegate.swift
//  FestFriend02
//
//  Created by MySoftheaven BD on 1/10/18.
//  Copyright © 2018 MySoftheaven BD. All rights reserved.
//

import Foundation
import UIKit
import SimpleImageViewer

// for home view's see all button
protocol SeeAllTicketDelegate {
    func showButtonTappped(cell: TicketsShowingTableViewCell)
}

// for home view's festival rows selection of item
protocol FestivalCellDelegate  {
    func festivalItemTapped(cell: UITableViewCell, index: IndexPath)
    func bidOrAskedTapped(cell: UITableViewCell, index: IndexPath, flag: Int)
}

// For festival cells views selection
protocol SubFestivalCellDelegate {
    func bidOrAskedViewTapped(cell: UIView, flag: Int)
}

// for home view's recent sales, new lowest asks etc rows selection of item
protocol TicketToTicketDetailsDelegate {
    func ticketItemTapped(cell: UITableViewCell, index: IndexPath)
}

protocol FestivalDetailsDelegate {
    func posterImgClicked(viewer: ImageViewerController)
}

protocol FollowingTVCDelegate {
    func btnUnFollowTapped(cell: UITableViewCell)
}

protocol TicketInfoTVCCellDelegate {
    func viewAllSalesTapped()
    func lblConditionTapped(cell: TicketInfoTableViewCell)
    func lblNameYearTapped()
}

protocol ShipingTVCDelegate {
    func editBtnTapped(cell: UITableViewCell)
}

protocol StateListDelegate {
    func stateChossed(index: Int)
}

protocol ExpirationDaysVCDelegate {
    func expirationDaysChoosed(days: Int)
}

protocol AsksBidsTVCDelegate {
    func deleteTapped(cell: UITableViewCell)
    func editTapped(cell: UITableViewCell)
    func detailsTapped(cell: UITableViewCell)
}

protocol TicketBannerTVCDelegate {
    func btnSelectQuantityTapped(cell: UITableViewCell)
}

protocol QuantityVCDelegate {
    func quantitySelected(quantity: Int)
}

protocol CheckCouponCodeDelegate {
    func validCouponCode(amount: Double)
}


