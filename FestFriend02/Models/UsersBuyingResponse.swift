//
//  UsersBidResponse.swift
//  FestFriend02
//  Copyright © 2019 MySoftheaven BD. All rights reserved.
//

import Foundation

class UserBuyingResponse: Codable {
    let status: Bool?
    let currentBids: [CurrentBid]?
    let purchasedBids, canceledBids: [UserBid]?
    let msg: String?
    
    init(status: Bool?, currentBids: [CurrentBid]?, purchasedBids: [UserBid]?, canceledBids: [UserBid]?, msg: String?) {
        self.status = status
        self.currentBids = currentBids
        self.purchasedBids = purchasedBids
        self.canceledBids = canceledBids
        self.msg = msg
    }
    
    public func isBidedPreviously(id ticketId: Int) -> Bool {
        
         //Mark:- check if have any active BID
        if let currentBids = currentBids, currentBids.count > 0 {
            let bid = currentBids.filter {  $0.ticketId! == "\(ticketId)" }
            if bid.count == 1 {
                return true
            } else {
                return false
            }
        }
        
      /*
          //Mark:- check if have any previos buy
         if let purchaseBid = purchasedBids, purchaseBid.count > 0 {
            let bid = purchaseBid.filter {  $0.ticketId! == "\(ticketId)" }
            if bid.count == 1 {
                return true
            } else {
                return false
            }
        }
        
          //Mark:- check if have any cancel BId
        if let canceledBids = canceledBids, canceledBids.count > 0 {
            let bid = canceledBids.filter {  $0.ticketId! == "\(ticketId)" }
            if bid.count == 1 {
                return true
            } else {
                return false
            }
        }*/
        
        return false
    }
}

class UserBid: Codable {
    let bidId: Int?
    let ticketId, userId: String?
    let festivalName: String?
    let festivalShortName: String?
    let festivalSubName: String?
    let festivalYear: String?
    let festivaltire: String?
    let bidAmount, totalAmount, quantity, expireIn: String?
    let expireDate, inOriginalBox, lowestAsk, lowestAskQty: String?
    let highestBid, highestBidQty, lastSaleAmount, lastSaleQty: String?
    let createdAt, updatedAt: String?
    let matchedDate: String?
    let status: String?
    
    enum CodingKeys: String, CodingKey {
        case bidId = "bid_id"
        case ticketId = "ticket_id"
        case userId = "user_id"
        case festivalName, festivalShortName, festivalSubName, festivalYear, festivaltire, bidAmount, totalAmount, quantity, expireIn, expireDate, inOriginalBox, lowestAsk, lowestAskQty, highestBid, highestBidQty, lastSaleAmount, lastSaleQty
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case matchedDate, status
    }
    
    init(bidId: Int?, ticketId: String?, userId: String?, festivalName: String?, festivalShortName: String?, festivalSubName: String?, festivalYear: String?, festivaltire: String?, bidAmount: String?, totalAmount: String?, quantity: String?, expireIn: String?, expireDate: String?, inOriginalBox: String?, lowestAsk: String?, lowestAskQty: String?, highestBid: String?, highestBidQty: String?, lastSaleAmount: String?, lastSaleQty: String?, createdAt: String?, updatedAt: String?, matchedDate: String?, status: String?) {
        self.bidId = bidId
        self.ticketId = ticketId
        self.userId = userId
        self.festivalName = festivalName
        self.festivalShortName = festivalShortName
        self.festivalSubName = festivalSubName
        self.festivalYear = festivalYear
        self.festivaltire = festivaltire
        self.bidAmount = bidAmount
        self.totalAmount = totalAmount
        self.quantity = quantity
        self.expireIn = expireIn
        self.expireDate = expireDate
        self.inOriginalBox = inOriginalBox
        self.lowestAsk = lowestAsk
        self.lowestAskQty = lowestAskQty
        self.highestBid = highestBid
        self.highestBidQty = highestBidQty
        self.lastSaleAmount = lastSaleAmount
        self.lastSaleQty = lastSaleQty
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.matchedDate = matchedDate
        self.status = status
    }
}

class CurrentBid: Codable {
    let bidId: Int?
    let ticketId, userId: String?
    let festivalName: String?
    let festivalShortName: String?
    let festivalSubName: String?
    let festivalYear: String?
    let festivaltire: String?
    let bidAmount, totalAmount: String?
    let shippingAmount: Double?
    let quantity, expireIn, expireDate, inOriginalBox: String?
    let imageUrl: String?
    let lowestAskThisQty, lowestAskAll, lowestAskAllQty, highestBidThisQty: String?
    let highestBidAll, highestBidAllQty, lastSaleAmount, lastSaleQty: String?
    let createdAt, updatedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case bidId = "bid_id"
        case ticketId = "ticket_id"
        case userId = "user_id"
        case festivalName, festivalShortName, festivalSubName, festivalYear, festivaltire, bidAmount, totalAmount, shippingAmount, quantity, expireIn, expireDate, inOriginalBox, imageUrl, lowestAskThisQty, lowestAskAll, lowestAskAllQty, highestBidThisQty, highestBidAll, highestBidAllQty, lastSaleAmount, lastSaleQty
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    
    init(bidId: Int?, ticketId: String?, userId: String?, festivalName: String?, festivalShortName: String?, festivalSubName: String?, festivalYear: String?, festivaltire: String?, bidAmount: String?, totalAmount: String?, shippingAmount: Double?, quantity: String?, expireIn: String?, expireDate: String?, inOriginalBox: String?, imageUrl: String?, lowestAskThisQty: String?, lowestAskAll: String?, lowestAskAllQty: String?, highestBidThisQty: String?, highestBidAll: String?, highestBidAllQty: String?, lastSaleAmount: String?, lastSaleQty: String?, createdAt: String?, updatedAt: String?) {
        self.bidId = bidId
        self.ticketId = ticketId
        self.userId = userId
        self.festivalName = festivalName
        self.festivalShortName = festivalShortName
        self.festivalSubName = festivalSubName
        self.festivalYear = festivalYear
        self.festivaltire = festivaltire
        self.bidAmount = bidAmount
        self.totalAmount = totalAmount
        self.shippingAmount = shippingAmount
        self.quantity = quantity
        self.expireIn = expireIn
        self.expireDate = expireDate
        self.inOriginalBox = inOriginalBox
        self.imageUrl = imageUrl
        self.lowestAskThisQty = lowestAskThisQty
        self.lowestAskAll = lowestAskAll
        self.lowestAskAllQty = lowestAskAllQty
        self.highestBidThisQty = highestBidThisQty
        self.highestBidAll = highestBidAll
        self.highestBidAllQty = highestBidAllQty
        self.lastSaleAmount = lastSaleAmount
        self.lastSaleQty = lastSaleQty
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}
