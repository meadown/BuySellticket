//
//  FestivalTicket.swift
//  FestFriend02
//  Copyright © 2019 MySoftheaven BD. All rights reserved.
//

import Foundation

class FestivalTicketsResponse: Codable {
    
    typealias sectionTuple = (sectionHeader: String, sectionData: [FestivalTicket])
    let status: Bool?
    let allTicketList: AllTicketList?
    let msg: String?
    
    init(status: Bool?, allTicketList: AllTicketList?, msg: String?) {
        self.status = status
        self.allTicketList = allTicketList
        self.msg = msg
    }
    
    func getSections() -> [Int: sectionTuple] {
        var sections: [Int: sectionTuple] = [Int: sectionTuple]()
        var counter = 0
        
        if let festival = allTicketList?.festivalTicket, festival.count > 0 {
            let festivalData = ("FESTIVAL TICKETS", festival)
            sections[counter] = festivalData
            counter = counter + 1
        }
        
        if let travel = allTicketList?.travel, travel.count > 0 {
            let travelData = ("TRAVEL & TRANSPORTATION", travel)
            sections[counter] = travelData
            counter = counter + 1
        }
        
        if let campign = allTicketList?.camping, campign.count > 0 {
            let caimpaingData = ("CAMPING", campign)
            sections[counter] = caimpaingData
        }
        
        return sections
    }
}

class AllTicketList: Codable {
    let travel, camping, festivalTicket: [FestivalTicket]?
    
    enum CodingKeys: String, CodingKey {
        case travel = "Travel"
        case camping = "Camping"
        case festivalTicket = "Festival Ticket"
    }
    
    init(travel: [FestivalTicket]?, camping: [FestivalTicket]?, festivalTicket: [FestivalTicket]?) {
        self.travel = travel
        self.camping = camping
        self.festivalTicket = festivalTicket
    }
}

class FestivalTicket: Codable {
    let ticketID: Int?
    let slug, festivalName, festivalShortName, festivalSubName: String?
    let festivalYear, ticketTier, type: String?
    let imageURL: String?
    let status, lowestAsk, highestBid, createdAt: String?
    let updatedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case ticketID = "ticket_id"
        case slug, festivalName, festivalShortName, festivalSubName, festivalYear
        case ticketTier = "ticket_tier"
        case type
        case imageURL = "imageUrl"
        case status, lowestAsk, highestBid
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    
    init(ticketID: Int?, slug: String?, festivalName: String?, festivalShortName: String?, festivalSubName: String?, festivalYear: String?, ticketTier: String?, type: String?, imageURL: String?, status: String?, lowestAsk: String?, highestBid: String?, createdAt: String?, updatedAt: String?) {
        self.ticketID = ticketID
        self.slug = slug
        self.festivalName = festivalName
        self.festivalShortName = festivalShortName
        self.festivalSubName = festivalSubName
        self.festivalYear = festivalYear
        self.ticketTier = ticketTier
        self.type = type
        self.imageURL = imageURL
        self.status = status
        self.lowestAsk = lowestAsk
        self.highestBid = highestBid
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}


class FavouriteLis: Codable {
    var favTickets: [FavTicket]?
    var favFestivals: [FavFestival]?
    
    static let festivalLabel = "Favorite Festivals"
    static let ticketLabel = "Favorite Tickets"
    
    init(favTickets: [FavTicket]?, favFestivals: [FavFestival]?) {
        self.favTickets = favTickets
        self.favFestivals = favFestivals
    }
    
    func getSections() -> [String] {
        var sections = [String]()
        
        if let tickets = favTickets, tickets.count > 0 {
            sections.append("Favorite Tickets")
        }
        
        if let festivals = favFestivals, festivals.count > 0 {
            sections.append("Favorite Festivals")
        }
        
        return sections
    }
}

class FavFestival: Codable {
    let festivalID, festivalName, festivalShortName, festivalSubName: String?
    let festivalYear: String?
    let image: String?
    let status, addedToFavorite: String?
    
    
    enum CodingKeys: String, CodingKey {
        case festivalID = "festival_id"
        case festivalName, festivalShortName, festivalSubName, festivalYear, image, status
        case addedToFavorite = "added_to_favorite"
    }
    
    init(festivalID: String?, festivalName: String?, festivalShortName: String?, festivalSubName: String?, festivalYear: String?, image: String?, status: String?, addedToFavorite: String?) {
        self.festivalID = festivalID
        self.festivalName = festivalName
        self.festivalShortName = festivalShortName
        self.festivalSubName = festivalSubName
        self.festivalYear = festivalYear
        self.image = image
        self.status = status
        self.addedToFavorite = addedToFavorite
    }
}

class FavTicket: Codable {
    let ticketID, festivalName, festivalShortName, festivalSubName: String?
    let festivalYear, ticketTier: String?
    let releaseDate: JSONNull?
    let image: String?
    let status, addedToFavorite: String?
    
    enum CodingKeys: String, CodingKey {
        case ticketID = "ticket_id"
        case festivalName, festivalShortName, festivalSubName, festivalYear
        case ticketTier = "ticket_tier"
        case releaseDate = "release_date"
        case image, status
        case addedToFavorite = "added_to_favorite"
    }
    
    init(ticketID: String?, festivalName: String?, festivalShortName: String?, festivalSubName: String?, festivalYear: String?, ticketTier: String?, releaseDate: JSONNull?, image: String?, status: String?, addedToFavorite: String?) {
        self.ticketID = ticketID
        self.festivalName = festivalName
        self.festivalShortName = festivalShortName
        self.festivalSubName = festivalSubName
        self.festivalYear = festivalYear
        self.ticketTier = ticketTier
        self.releaseDate = releaseDate
        self.image = image
        self.status = status
        self.addedToFavorite = addedToFavorite
    }
}

class ViewSalesBidsAsksResponse: Codable {
    let status: Bool?
    let allAsks: [AskOrSales]?
    let allBids: [Bid]?
    let allSales: [AskOrSales]?
    let msg: String?
    
    init(status: Bool?, allAsks: [AskOrSales]?, allBids: [Bid]?, allSales: [AskOrSales]?, msg: String?) {
        self.status = status
        self.allAsks = allAsks
        self.allBids = allBids
        self.allSales = allSales
        self.msg = msg
    }
}

class AskOrSales: Codable {
    let id: Int?
    let ticketID, userID, amount, totalAmount: String?
    let quantity, expireIn, expireDate: String?
    let matchedDate, matchedBidID: String?
    let directSell, inOriginalBox, status, postFrom: String?
    let createdAt, updatedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case ticketID = "ticket_id"
        case userID = "user_id"
        case amount, totalAmount, quantity, expireIn, expireDate, matchedDate
        case matchedBidID = "matchedBidId"
        case directSell, inOriginalBox, status, postFrom
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    
    init(id: Int?, ticketID: String?, userID: String?, amount: String?, totalAmount: String?, quantity: String?, expireIn: String?, expireDate: String?, matchedDate: String?, matchedBidID: String?, directSell: String?, inOriginalBox: String?, status: String?, postFrom: String?, createdAt: String?, updatedAt: String?) {
        self.id = id
        self.ticketID = ticketID
        self.userID = userID
        self.amount = amount
        self.totalAmount = totalAmount
        self.quantity = quantity
        self.expireIn = expireIn
        self.expireDate = expireDate
        self.matchedDate = matchedDate
        self.matchedBidID = matchedBidID
        self.directSell = directSell
        self.inOriginalBox = inOriginalBox
        self.status = status
        self.postFrom = postFrom
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}

class Bid: Codable {
    let id: Int?
    let ticketID, userID, transactionID, amount: String?
    let totalAmount, shippingCost, quantity, expireIn: String?
    let expireDate: String?
    let matchedDate, matchedAskID, userCouponID: String?
    let directBuy, inOriginalBox, status, transactionStatus: String?
    let postFrom, createdAt, updatedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case ticketID = "ticket_id"
        case userID = "user_id"
        case transactionID = "transaction_id"
        case amount, totalAmount, shippingCost, quantity, expireIn, expireDate, matchedDate
        case matchedAskID = "matchedAskId"
        case userCouponID = "user_coupon_id"
        case directBuy, inOriginalBox, status
        case transactionStatus = "transaction_status"
        case postFrom
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    
    init(id: Int?, ticketID: String?, userID: String?, transactionID: String?, amount: String?, totalAmount: String?, shippingCost: String?, quantity: String?, expireIn: String?, expireDate: String?, matchedDate: String?, matchedAskID: String?, userCouponID: String?, directBuy: String?, inOriginalBox: String?, status: String?, transactionStatus: String?, postFrom: String?, createdAt: String?, updatedAt: String?) {
        self.id = id
        self.ticketID = ticketID
        self.userID = userID
        self.transactionID = transactionID
        self.amount = amount
        self.totalAmount = totalAmount
        self.shippingCost = shippingCost
        self.quantity = quantity
        self.expireIn = expireIn
        self.expireDate = expireDate
        self.matchedDate = matchedDate
        self.matchedAskID = matchedAskID
        self.userCouponID = userCouponID
        self.directBuy = directBuy
        self.inOriginalBox = inOriginalBox
        self.status = status
        self.transactionStatus = transactionStatus
        self.postFrom = postFrom
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}

class BidAskModel {
    var isEdit = false
    var isBid: Bool?
    var ticketId: Int?
    var askBidId: Int?
    var headerImgUrl: String?
    var shortName: String?
    var subname: String?
    var year: String?
    var tier: String?
    var highestBid: Int?
    var lowestAsk: Int?
    var couponCode: String?
    var couponAmount = 0.0
    var releaseDate: String?
    var quantity = 1
    var bidAskExpiraryDay = 7// was before 30
    var isInOriginalBox = true
    var directBuy = 0
    var directSell = 0
    var postForm = 0
    var value = 0.0
    var editableValue = 0.0
    var shippingAmount = 0.0
    var cutOffDate: String?
    var bidasksalescutoff : String?
    var address : String?
    var card_no : String?
    var buttonName: String?
    
    var isAskBidStr: String {
        get {
            if isBid! {
                if buttonName == "Place Bid" as String? {
                    return "Bid"
                } else {
                    return "Purchase"
                }
            } else {
                if buttonName == "Sell Now" as String? {
                    return "Sale"
                } else {
                    return "Ask"
                    
                }
                
            }
        }
    }
    
    var totalAmount: Double{
        get {
            if value == 0.0 {
                return 0.0
            } else {
                if isBid! {
                    return (value + shippingAmount) - authenticationAmount() - couponAmount
                } else {
                    return ((value + shippingAmount) - authenticationAmount() - paymentProcessingAmount()).roundToTwoDecimal() - couponAmount
                }
                
            }
        }
    }
    
    var authenticationRate: Int {
        get {
            if isBid! {
                return 0
            } else {
                return 10
            }
        }
    }
    
    var paymentProcessingRate: Double {
        get {
            if isBid! {
                return 0
            } else {
                return 2.9
            }
        }
    }
    
    func authenticationAmount() -> Double {
        let authAmount = value * (Double(authenticationRate) / 100.0)
        return authAmount.roundToTwoDecimal()
    }
    
    func paymentProcessingAmount() -> Double {
        let authAmount = value * (Double(authenticationRate) / 100.0)
        let totalAmount = value - authAmount
        let amount = (totalAmount.roundToTwoDecimal() * (Double(paymentProcessingRate) / 100.0)) + 0.30
        
        return amount.roundToTwoDecimal()
    }
    
    func getTitle() -> String {
        return "\(shortName!) - \(year!)  \(subname!)\n\(tier!)"
    }
}
