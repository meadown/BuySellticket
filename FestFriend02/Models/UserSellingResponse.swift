//
//  UserSellingResponse.swift
//  FestFriend02
//  Copyright © 2019 MySoftheaven BD. All rights reserved.
//

import Foundation

class UserSellingResponse: Codable {
    let status: Bool?
    let currentAsks: [CurrentAsk]?
    let soldAsks, canceledAsks: [UserAsk]?
    let msg: String?
    
    init(status: Bool?, currentAsks: [CurrentAsk]?, soldAsks: [UserAsk]?, canceledAsks: [UserAsk]?, msg: String?) {
        self.status = status
        self.currentAsks = currentAsks
        self.soldAsks = soldAsks
        self.canceledAsks = canceledAsks
        self.msg = msg
    }
    
    public func isAskedPreviously(id ticketId: Int) -> Bool {
        //Mark:- check if have any active ask
        if let currentAsks = currentAsks, currentAsks.count > 0 {
            let bid = currentAsks.filter {  $0.ticketId! == "\(ticketId)" }
            if bid.count == 1 {
                return true
            } else {
                return false
            }
        }
       /*
        //Mark:- check if have any previous sold ticket
        if let soldAsks = soldAsks, soldAsks.count > 0 {
            let bid = soldAsks.filter {  $0.ticketId! == "\(ticketId)" }
            if bid.count == 1 {
                return true
            } else {
                return false
            }
        }
        
          //Mark:- check if have any cancel ask
        if let canceledAsks = canceledAsks, canceledAsks.count > 0 {
            let bid = canceledAsks.filter {  $0.ticketId! == "\(ticketId)" }
            if bid.count == 1 {
                return true
            } else {
                return false
            }
        }
        */
        return false
    }
}

class UserAsk: Codable {
    let askId: Int?
    let ticketId, userId: String?
    let festivalName: String?
    let festivalShortName: String?
    let festivalSubName: String?
    let festivalYear: String?
    let festivaltire: String?
    let askAmount, totalAmount, quantity, expireIn: String?
    let expireDate, inOriginalBox, lowestAsk, lowestAskQty: String?
    let highestBid, highestBidQty, lastSaleAmount, lastSaleQty: String?
    let createdAt, updatedAt: String?
    let shippingLevel: String?
    let matchedDate, status: String?
    
    enum CodingKeys: String, CodingKey {
        case askId = "ask_id"
        case ticketId = "ticket_id"
        case userId = "user_id"
        case festivalName, festivalShortName, festivalSubName, festivalYear, festivaltire, askAmount, totalAmount, quantity, expireIn, expireDate, inOriginalBox, lowestAsk, lowestAskQty, highestBid, highestBidQty, lastSaleAmount, lastSaleQty
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case shippingLevel, matchedDate, status
    }
    
    init(askId: Int?, ticketId: String?, userId: String?, festivalName: String?, festivalShortName: String?, festivalSubName: String?, festivalYear: String?, festivaltire: String?, askAmount: String?, totalAmount: String?, quantity: String?, expireIn: String?, expireDate: String?, inOriginalBox: String?, lowestAsk: String?, lowestAskQty: String?, highestBid: String?, highestBidQty: String?, lastSaleAmount: String?, lastSaleQty: String?, createdAt: String?, updatedAt: String?, shippingLevel: String?, matchedDate: String?, status: String?) {
        self.askId = askId
        self.ticketId = ticketId
        self.userId = userId
        self.festivalName = festivalName
        self.festivalShortName = festivalShortName
        self.festivalSubName = festivalSubName
        self.festivalYear = festivalYear
        self.festivaltire = festivaltire
        self.askAmount = askAmount
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
        self.shippingLevel = shippingLevel
        self.matchedDate = matchedDate
        self.status = status
    }
}

class CurrentAsk: Codable {
    let askId: Int?
    let ticketId, userId: String?
    let festivalName: String?
    let festivalShortName: String?
    let festivalSubName: String?
    let festivalYear: String?
    let festivaltire: String?
    let askAmount, totalAmount: String?
    let shippingAmount: Double?
    let quantity, expireIn, expireDate, inOriginalBox: String?
    let imageUrl: String?
    let lowestAskThisQty, lowestAskAll, lowestAskAllQty, highestBidThisQty: String?
    let highestBidAll, highestBidAllQty, lastSaleAmount, lastSaleQty: String?
    let createdAt, updatedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case askId = "ask_id"
        case ticketId = "ticket_id"
        case userId = "user_id"
        case festivalName, festivalShortName, festivalSubName, festivalYear, festivaltire, askAmount, totalAmount, shippingAmount, quantity, expireIn, expireDate, inOriginalBox, imageUrl, lowestAskThisQty, lowestAskAll, lowestAskAllQty, highestBidThisQty, highestBidAll, highestBidAllQty, lastSaleAmount, lastSaleQty
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    
    init(askId: Int?, ticketId: String?, userId: String?, festivalName: String?, festivalShortName: String?, festivalSubName: String?, festivalYear: String?, festivaltire: String?, askAmount: String?, totalAmount: String?, shippingAmount: Double?, quantity: String?, expireIn: String?, expireDate: String?, inOriginalBox: String?, imageUrl: String?, lowestAskThisQty: String?, lowestAskAll: String?, lowestAskAllQty: String?, highestBidThisQty: String?, highestBidAll: String?, highestBidAllQty: String?, lastSaleAmount: String?, lastSaleQty: String?, createdAt: String?, updatedAt: String?) {
        self.askId = askId
        self.ticketId = ticketId
        self.userId = userId
        self.festivalName = festivalName
        self.festivalShortName = festivalShortName
        self.festivalSubName = festivalSubName
        self.festivalYear = festivalYear
        self.festivaltire = festivaltire
        self.askAmount = askAmount
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

