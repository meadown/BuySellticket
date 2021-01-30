//
//  SearchResponseModel.swift
//  FestFriend02
//  Copyright © 2019 MySoftheaven BD. All rights reserved.
//

import Foundation

class SearchResponse: Codable {
    let status: Bool?
    let msg: String?
    let ticketFestival: [TicketFestival]?
    
    enum CodingKeys: String, CodingKey {
        case status, msg
        case ticketFestival = "ticket_festival"
    }
    
    init(status: Bool?, msg: String?, ticketFestival: [TicketFestival]?) {
        self.status = status
        self.msg = msg
        self.ticketFestival = ticketFestival
    }
}

class TicketFestival: Codable {
    let ticket: String?
    let tickets: [Ticket]?
    let festival: String?
    let festivals: [Festival]?
    
    init(ticket: String?, tickets: [Ticket]?, festival: String?, festivals: [Festival]?) {
        self.ticket = ticket
        self.tickets = tickets
        self.festival = festival
        self.festivals = festivals
    }
}

class Festival: Codable {
    let id: Int?
    let festivalName, festivalShortName, festivalSubName, year: String?
    let country, venue, city, state: String?
    let imageUrl: String?
    
    init(id: Int?, festivalName: String?, festivalShortName: String?, festivalSubName: String?, year: String?, country: String?, venue: String?, city: String?, state: String?, imageUrl: String?) {
        self.id = id
        self.festivalName = festivalName
        self.festivalShortName = festivalShortName
        self.festivalSubName = festivalSubName
        self.year = year
        self.country = country
        self.venue = venue
        self.city = city
        self.state = state
        self.imageUrl = imageUrl
    }
}

class Ticket: Codable {
    let id: Int?
    let festivalName, festivalShortName, festivalSubName, slug: String?
    let ticketTier, year, releaseDate: String?
    let imageUrl: String?
    let faceValue, lowestAsk, highestBid, status: String?
    let createdAt, updatedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id, festivalName, festivalShortName, festivalSubName, slug
        case ticketTier = "ticket_tier"
        case year, releaseDate, imageUrl
        case faceValue = "face_value"
        case lowestAsk, highestBid, status
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    
    init(id: Int?, festivalName: String?, festivalShortName: String?, festivalSubName: String?, slug: String?, ticketTier: String?, year: String?, releaseDate: String?, imageUrl: String?, faceValue: String?, lowestAsk: String?, highestBid: String?, status: String?, createdAt: String?, updatedAt: String?) {
        self.id = id
        self.festivalName = festivalName
        self.festivalShortName = festivalShortName
        self.festivalSubName = festivalSubName
        self.slug = slug
        self.ticketTier = ticketTier
        self.year = year
        self.releaseDate = releaseDate
        self.imageUrl = imageUrl
        self.faceValue = faceValue
        self.lowestAsk = lowestAsk
        self.highestBid = highestBid
        self.status = status
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}

