//
//  HomeInfo.swift
//  FestFriend02
//
//  Created by MySoftheaven BD on 16/10/18.
//  Copyright © 2018 MySoftheaven BD. All rights reserved.
//

// To parse the JSON, add this file to your project and do:
//
//   let homeViewInfo = try? newJSONDecoder().decode(HomeViewInfo.self, from: jsonData)

import Foundation
import UIKit

struct HomeViewInfo: Codable {
    var status: Bool?
    var featuredFestivals: [FeatureFestival]?
    var upcomingFestivals: [UpcomingFestival]?
    var popularFestivals: [PopularFestival]?
    var recentSales, newLowestAsks, newHighestBids: [NewHighestBid]?
    var releasedCalenders: [ReleaseCalender]?
    var msg: String?
}

class FestivalDetailsResponse: Codable {
    let status: Bool?
    let msg: String?
    let festivalDetails: FestivalDetails?
    
    init(status: Bool?, msg: String?, festivals: FestivalDetails?) {
        self.status = status
        self.msg = msg
        self.festivalDetails = festivals
    }
    
    enum CodingKeys: String, CodingKey {
        case status
        case msg
        case festivalDetails = "festivals"
    }
}

class FestivalDetails: Codable {
    let id: Int?
    let festivalName, festivalShortName, festivalSubName, festivalYear: String?
    let venue, city, state, startDate: String?
    let endDate, startAndEndDate, description: String?
    //let venueAndTravels: JSONNull?
    let totalProduct: Int?
    let headerImage: String?
    let lineUpPoster: String?
    let lowestAsk, highestBid, ticketTier: String?
    let ticketID: TicketID?
    let artist, genre: String?
    let relatedFestival: [RelatedFestival]?
    
    enum CodingKeys: String, CodingKey {
        case id, festivalName, festivalShortName, festivalSubName, festivalYear, venue, city, state
        case startDate = "start_date"
        case endDate = "end_date"
        case startAndEndDate = "start_and_end_date"
        case description
        //case venueAndTravels = "venue_and_travels"
        case totalProduct = "total_product"
        case headerImage = "header_image"
        case lineUpPoster, lowestAsk, highestBid
        case ticketTier = "ticket_tier"
        case ticketID = "ticket_id"
        case artist, genre, relatedFestival
    }
    
    init(id: Int?, festivalName: String?, festivalShortName: String?, festivalSubName: String?, festivalYear: String?, venue: String?, city: String?, state: String?, startDate: String?, endDate: String?, startAndEndDate: String?, description: String?, venueAndTravels: JSONNull?, totalProduct: Int?, headerImage: String?, lineUpPoster: String?, lowestAsk: String?, highestBid: String?, ticketTier: String?, ticketID: TicketID?, artist: String?, genre: String?, relatedFestival: [RelatedFestival]?) {
        self.id = id
        self.festivalName = festivalName
        self.festivalShortName = festivalShortName
        self.festivalSubName = festivalSubName
        self.festivalYear = festivalYear
        self.venue = venue
        self.city = city
        self.state = state
        self.startDate = startDate
        self.endDate = endDate
        self.startAndEndDate = startAndEndDate
        self.description = description
        //self.venueAndTravels = venueAndTravels
        self.totalProduct = totalProduct
        self.headerImage = headerImage
        self.lineUpPoster = lineUpPoster
        self.lowestAsk = lowestAsk
        self.highestBid = highestBid
        self.ticketTier = ticketTier
        self.ticketID = ticketID
        self.artist = artist
        self.genre = genre
        self.relatedFestival = relatedFestival
    }
}

class RelatedFestival: Codable {
    let festivalID: Int?
    let festivalName, festivalShortName, festivalSubName, festivalYear: String?
    let venue, city, state, startDate: String?
    let endDate, description: String?
    let totalProduct: Int?
    let headerImage: String?
    let lineUpPoster: String?
    
    enum CodingKeys: String, CodingKey {
        case festivalID = "festival_id"
        case festivalName, festivalShortName, festivalSubName, festivalYear, venue, city, state
        case startDate = "start_date"
        case endDate = "end_date"
        case description
        case totalProduct = "total_product"
        case headerImage = "header_image"
        case lineUpPoster
    }
    
    init(festivalID: Int?, festivalName: String?, festivalShortName: String?, festivalSubName: String?, festivalYear: String?, venue: String?, city: String?, state: String?, startDate: String?, endDate: String?, description: String?, totalProduct: Int?, headerImage: String?, lineUpPoster: String?) {
        self.festivalID = festivalID
        self.festivalName = festivalName
        self.festivalShortName = festivalShortName
        self.festivalSubName = festivalSubName
        self.festivalYear = festivalYear
        self.venue = venue
        self.city = city
        self.state = state
        self.startDate = startDate
        self.endDate = endDate
        self.description = description
        self.totalProduct = totalProduct
        self.headerImage = headerImage
        self.lineUpPoster = lineUpPoster
    }
}

class Festivals: Codable {
    var status: Bool?
    var featureFestivals: [FeatureFestival]?
    var upcomingFestivals: [UpcomingFestival]?
    var popularFestivals: [PopularFestival]?
    var msg: String?
    
    init(status: Bool?, featureFestivals: [FeatureFestival]?, upcomingFestivals: [UpcomingFestival]?, popularFestivals: [PopularFestival]?, msg: String?) {
        self.status = status
        self.featureFestivals = featureFestivals
        self.upcomingFestivals = upcomingFestivals
        self.popularFestivals = popularFestivals
        self.msg = msg
    }
    
    init(){}
}

class Bids: Codable {
    var status: Bool?
    var soldTickets, newLowestAsks, newHighestBids: [NewHighestBid]?
    var releaseCalender: [ReleaseCalender]?
    var msg: String?
    
    init(status: Bool?, soldTickets: [NewHighestBid]?, newLowestAsks: [NewHighestBid]?, newHighestBids: [NewHighestBid]?, releaseCalender: [ReleaseCalender]?, msg: String?) {
        self.status = status
        self.soldTickets = soldTickets
        self.newLowestAsks = newLowestAsks
        self.newHighestBids = newHighestBids
        self.releaseCalender = releaseCalender
        self.msg = msg
    }

    
    init(){}
}

class FeatureFestival: Codable {
    var id: Int?
    var festivalName, festivalShortName, festivalSubName, festivalYear: String?
    var venue, city, state, startDate: String?
    var endDate, description: String?
    var totalProduct: Int?
    var headerImage, lineUpPoster: String?
    var lowestAsk, highestBid, ticketTier: String?
    var ticketID: Int?
    
    enum CodingKeys: String, CodingKey {
        case id, festivalName, festivalShortName, festivalSubName, festivalYear, venue, city, state
        case startDate = "start_date"
        case endDate = "end_date"
        case description
        case totalProduct = "total_product"
        case headerImage = "header_image"
        case lineUpPoster, lowestAsk, highestBid
        case ticketTier = "ticket_tier"
        case ticketID = "ticket_id"
    }
    
    init(id: Int?, festivalName: String?, festivalShortName: String?, festivalSubName: String?, festivalYear: String?, venue: String?, city: String?, state: String?, startDate: String?, endDate: String?, description: String?, totalProduct: Int?, headerImage: String?, lineUpPoster: String?, lowestAsk: String?, highestBid: String?, ticketTier: String?, ticketID: Int?) {
        self.id = id
        self.festivalName = festivalName
        self.festivalShortName = festivalShortName
        self.festivalSubName = festivalSubName
        self.festivalYear = festivalYear
        self.venue = venue
        self.city = city
        self.state = state
        self.startDate = startDate
        self.endDate = endDate
        self.description = description
        self.totalProduct = totalProduct
        self.headerImage = headerImage
        self.lineUpPoster = lineUpPoster
        self.lowestAsk = lowestAsk
        self.highestBid = highestBid
        self.ticketTier = ticketTier
        self.ticketID = ticketID
    }
}

class PopularFestival: Codable {
    var id, festivalName, festivalShortName, festivalSubName: String?
    var festivalYear, venue, city, state: String?
    var startDate, endDate, description: String?
    var totalProduct: Int?
    var headerImage, lineUpPoster: String?
    var lowestAsk, highestBid, ticketTier: String?
    var ticketID: Int?
    
    enum CodingKeys: String, CodingKey {
        case id, festivalName, festivalShortName, festivalSubName, festivalYear, venue, city, state
        case startDate = "start_date"
        case endDate = "end_date"
        case description
        case totalProduct = "total_product"
        case headerImage = "header_image"
        case lineUpPoster, lowestAsk, highestBid
        case ticketTier = "ticket_tier"
        case ticketID = "ticket_id"
    }
    
    init(id: String?, festivalName: String?, festivalShortName: String?, festivalSubName: String?, festivalYear: String?, venue: String?, city: String?, state: String?, startDate: String?, endDate: String?, description: String?, totalProduct: Int?, headerImage: String?, lineUpPoster: String?, lowestAsk: String?, highestBid: String?, ticketTier: String?, ticketID: Int?) {
        self.id = id
        self.festivalName = festivalName
        self.festivalShortName = festivalShortName
        self.festivalSubName = festivalSubName
        self.festivalYear = festivalYear
        self.venue = venue
        self.city = city
        self.state = state
        self.startDate = startDate
        self.endDate = endDate
        self.description = description
        self.totalProduct = totalProduct
        self.headerImage = headerImage
        self.lineUpPoster = lineUpPoster
        self.lowestAsk = lowestAsk
        self.highestBid = highestBid
        self.ticketTier = ticketTier
        self.ticketID = ticketID
    }
}

class UpcomingFestival: Codable {
    var id: Int?
    var festivalName, festivalShortName, festivalSubName, festivalYear: String?
    var venue, city, state, startDate: String?
    var endDate, description: String?
    var totalProduct: Int?
    var headerImage, lineUpPoster: String?
    var lowestAsk, highestBid, ticketTier: String?
    var ticketID: TicketID?
    
    enum CodingKeys: String, CodingKey {
        case id, festivalName, festivalShortName, festivalSubName, festivalYear, venue, city, state
        case startDate = "start_date"
        case endDate = "end_date"
        case description
        case totalProduct = "total_product"
        case headerImage = "header_image"
        case lineUpPoster, lowestAsk, highestBid
        case ticketTier = "ticket_tier"
        case ticketID = "ticket_id"
    }
    
    init(id: Int?, festivalName: String?, festivalShortName: String?, festivalSubName: String?, festivalYear: String?, venue: String?, city: String?, state: String?, startDate: String?, endDate: String?, description: String?, totalProduct: Int?, headerImage: String?, lineUpPoster: String?, lowestAsk: String?, highestBid: String?, ticketTier: String?, ticketID: TicketID?) {
        self.id = id
        self.festivalName = festivalName
        self.festivalShortName = festivalShortName
        self.festivalSubName = festivalSubName
        self.festivalYear = festivalYear
        self.venue = venue
        self.city = city
        self.state = state
        self.startDate = startDate
        self.endDate = endDate
        self.description = description
        self.totalProduct = totalProduct
        self.headerImage = headerImage
        self.lineUpPoster = lineUpPoster
        self.lowestAsk = lowestAsk
        self.highestBid = highestBid
        self.ticketTier = ticketTier
        self.ticketID = ticketID
    }
}

enum TicketID: Codable {
    case integer(Int)
    case string(String)
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(TicketID.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for TicketID"))
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
}
}

class NewHighestBid: Codable {
    var bidID, ticketID, festivalID: Int?
    var slug, festivalName, festivalShortName, festivalSubName: String?
    var festivalYear, ticketTier: String?
    var type: TypeEnum?
    var faceValue, description: String?
    var imageURL: String?
    var status, amount, timeDifference, createdAt: String?
    var updatedAt: String?
    var askID: Int?
    var matchedDate: String?
    
    
    enum CodingKeys: String, CodingKey {
        case bidID = "bid_id"
        case ticketID = "ticket_id"
        case festivalID = "festival_id"
        case slug, festivalName, festivalShortName, festivalSubName, festivalYear
        case ticketTier = "ticket_tier"
        case type
        case faceValue = "face_value"
        case description
        case imageURL = "imageUrl"
        case status, amount, timeDifference
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case askID = "ask_id"
        case matchedDate
    }
    
    init(bidID: Int?, ticketID: Int?, festivalID: Int?, slug: String?, festivalName: String?, festivalShortName: String?, festivalSubName: String?, festivalYear: String?, ticketTier: String?, type: TypeEnum?, faceValue: String?, description: String?, imageURL: String?, status: String?, amount: String?, timeDifference: String?, createdAt: String?, updatedAt: String?, askID: Int?, matchedDate: String?) {
        self.bidID = bidID
        self.ticketID = ticketID
        self.festivalID = festivalID
        self.slug = slug
        self.festivalName = festivalName
        self.festivalShortName = festivalShortName
        self.festivalSubName = festivalSubName
        self.festivalYear = festivalYear
        self.ticketTier = ticketTier
        self.type = type
        self.faceValue = faceValue
        self.description = description
        self.imageURL = imageURL
        self.status = status
        self.amount = amount
        self.timeDifference = timeDifference
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.askID = askID
        self.matchedDate = matchedDate
    }
}

enum TypeEnum: String, Codable {
    case type = "Travel"
    case camping = "Camping"
    case festivalTicket = "Festival Ticket"
}

class ReleaseCalender: Codable {
    var slug: String?
    var id: Int?
    var festivalName, festivalShortName, festivalSubName, festivalYear: String?
    var ticketTier: String?
    var headerImage, lineUpPoster: String?
    var status, relarceDate, createdAt, updatedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case slug/*, id*/, festivalName, festivalShortName, festivalSubName, festivalYear
        case id = "festival_id"
        case ticketTier = "ticket_tier"
        case headerImage = "header_image"
        case lineUpPoster, status
        case relarceDate = "relarce_date"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    
    init(slug: String?, id: Int?, festivalName: String?, festivalShortName: String?, festivalSubName: String?, festivalYear: String?, ticketTier: String?, headerImage: String?, lineUpPoster: String?, status: String?, relarceDate: String?, createdAt: String?, updatedAt: String?) {
        self.slug = slug
        self.id = id
        self.festivalName = festivalName
        self.festivalShortName = festivalShortName
        self.festivalSubName = festivalSubName
        self.festivalYear = festivalYear
        self.ticketTier = ticketTier
        self.headerImage = headerImage
        self.lineUpPoster = lineUpPoster
        self.status = status
        self.relarceDate = relarceDate
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}

// MARK: Encode/decode helpers

class JSONNull: Codable, Hashable {
    
    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }
    
    public var hashValue: Int {
        return 0
    }
    
    public init() {}
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
}
    
}

class TickerTabs: Codable {
    let status: Bool?
    let tickerTab: [TickerTab]?
    let msg: String?
    
    init(status: Bool?, tickerTab: [TickerTab]?, msg: String?) {
        self.status = status
        self.tickerTab = tickerTab
        self.msg = msg
    }
    
    public func getTickerString() -> NSAttributedString {
        
        let tabStr = NSMutableAttributedString()
        
        for tabs in tickerTab! {
            
            let attributedStr = NSMutableAttributedString(string: "\(tabs.tickerSymbol!)  $\(tabs.lastPrice!) ")
            
            let imageAttachment = NSTextAttachment()
            
            let font = UIFont.systemFont(ofSize: 15)
            
            var image: UIImage?
            if tabs.flug! {
                image = UIImage(named: "up_arrow.png")
            } else {
                image = UIImage(named: "down_arrow.png")
            }
            
            imageAttachment.image = image
            
            let mid = font.descender + font.capHeight
            imageAttachment.bounds = CGRect(x: 0, y: font.descender - image!.size.height / 2 + mid + 2, width: image!.size.width, height: image!.size.height)
            
            let attributedImage = NSAttributedString(attachment: imageAttachment)
            attributedStr.append(attributedImage)
            
            let attributedSpace = NSAttributedString(string: "    ")
            attributedStr.append(attributedSpace)
            
            tabStr.append(attributedStr)
        }
        
        return tabStr
    }
}

class TickerTab: Codable {
    let askID: Int?
    let ticketID, festivalShortName, festivalName, tickerSymbol: String?
    let quantity, lastPrice, secondLastPrice: String?
    let flug: Bool?
    
    enum CodingKeys: String, CodingKey {
        case askID = "ask_id"
        case ticketID = "ticket_id"
        case festivalShortName, festivalName, tickerSymbol, quantity, lastPrice, secondLastPrice, flug
    }
    
    init(askID: Int?, ticketID: String?, festivalShortName: String?, festivalName: String?, tickerSymbol: String?, quantity: String?, lastPrice: String?, secondLastPrice: String?, flug: Bool?) {
        self.askID = askID
        self.ticketID = ticketID
        self.festivalShortName = festivalShortName
        self.festivalName = festivalName
        self.tickerSymbol = tickerSymbol
        self.quantity = quantity
        self.lastPrice = lastPrice
        self.secondLastPrice = secondLastPrice
        self.flug = flug
    }
}

class TicketDetailsResponse: Codable {
    let status: Bool?
    let ticketDetails: TicketDetails?
    let msg: String?
    
    init(status: Bool?, ticketDetails: TicketDetails?, msg: String?) {
        self.status = status
        self.ticketDetails = ticketDetails
        self.msg = msg
    }
}

class TicketDetails: Codable {
    let id: Int?
    let slug: String?
    let festivalID: Int?
    let festivalName, festivalShortName, festivalSubName, festivalYear: String?
    let ticketTier, description, type: String?
    let imageURL: String?
    let status, lowestAsk, highestBid, lastSale: String?
    let secondlastSale, lastTwoSaleCombination, conditionLowestAsk, conditionHighestBid: String?
    let conditionLastSale, createdAt, updatedAt,shippingcutoff ,bidasksalescutoff,releaseDate: String?
    let shippingAmount: Double?
    let relatedProducts: [RelatedProduct]?
    
    
    
    enum CodingKeys: String, CodingKey {
        case id, slug, festivalID, festivalName, festivalShortName, festivalSubName, festivalYear
        case ticketTier = "ticket_tier"
        case description, type
        case imageURL = "imageUrl"
        case status, lowestAsk, highestBid, lastSale, secondlastSale, lastTwoSaleCombination, conditionLowestAsk, conditionHighestBid, conditionLastSale, releaseDate
        case createdAt = "created_at"
        case shippingcutoff = "shippingCutoff"
        case updatedAt = "updated_at"
        case bidasksalescutoff = "bid_ask_sales_cutoff"
        case shippingAmount, relatedProducts
    }
    
    init(id: Int?, slug: String?, festivalID: Int?, festivalName: String?, festivalShortName: String?, festivalSubName: String?, festivalYear: String?, ticketTier: String?, description: String?, type: String?, imageURL: String?, status: String?, lowestAsk: String?, highestBid: String?, lastSale: String?, secondlastSale: String?, lastTwoSaleCombination: String?, conditionLowestAsk: String?, conditionHighestBid: String?, conditionLastSale: String?, createdAt: String?,shippingcutoff: String, bidasksalescutoff: String?,updatedAt: String?, releaseDate: String?, shippingAmount: Double?, relatedProducts: [RelatedProduct]?) {
        self.id = id
        self.slug = slug
        self.festivalID = festivalID
        self.festivalName = festivalName
        self.festivalShortName = festivalShortName
        self.festivalSubName = festivalSubName
        self.festivalYear = festivalYear
        self.ticketTier = ticketTier
        self.description = description
        self.type = type
        self.imageURL = imageURL
        self.status = status
        self.lowestAsk = lowestAsk
        self.highestBid = highestBid
        self.lastSale = lastSale
        self.secondlastSale = secondlastSale
        self.lastTwoSaleCombination = lastTwoSaleCombination
        self.conditionLowestAsk = conditionLowestAsk
        self.conditionHighestBid = conditionHighestBid
        self.conditionLastSale = conditionLastSale
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.shippingAmount = shippingAmount
        self.relatedProducts = relatedProducts
        self.releaseDate = releaseDate
        self.shippingcutoff = shippingcutoff
        self.bidasksalescutoff = bidasksalescutoff
        
    }
}

class RelatedProduct: Codable {
    let ticketID: Int?
    let festivalShortName, festivalName, festivalSubName, festivalYear: String?
    let ticketTier, type: String?
    let amount: JSONNull?
    let timeDifference: String?
    let imageURL: String?
    
    enum CodingKeys: String, CodingKey {
        case ticketID = "ticket_id"
        case festivalShortName, festivalName, festivalSubName, festivalYear
        case ticketTier = "ticket_tier"
        case type, amount, timeDifference
        case imageURL = "imageUrl"
    }
    
    init(ticketID: Int?, festivalShortName: String?, festivalName: String?, festivalSubName: String?, festivalYear: String?, ticketTier: String?, type: String?, amount: JSONNull?, timeDifference: String?, imageURL: String?) {
        self.ticketID = ticketID
        self.festivalShortName = festivalShortName
        self.festivalName = festivalName
        self.festivalSubName = festivalSubName
        self.festivalYear = festivalYear
        self.ticketTier = ticketTier
        self.type = type
        self.amount = amount
        self.timeDifference = timeDifference
        self.imageURL = imageURL
    }
}
