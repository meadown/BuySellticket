//
//  NotificationStatusModel.swift
//  FestFriend02
//  Copyright © 2019 MySoftheaven BD. All rights reserved.
//

import Foundation

class NotificationStatusResponse: Codable {
    let status: Bool?
    let allNotificationList: AllNotificationList?
    let msg: String?
    
    init(status: Bool?, allNotificationList: AllNotificationList?, msg: String?) {
        self.status = status
        self.allNotificationList = allNotificationList
        self.msg = msg
    }
}

class AllNotificationList: Codable {
    let id: Int?
    let userId, bidNewLowAsk, bidNewHighBid, bidAccepted: String?
    let folNewLowAsk, askNewHighBid, askNewLowAsk, askItemSold: String?
    let pushBidNewLowAsk, pushBidNewHighBid, pushBidAccepted, pushFolNewLowAsk: String?
    let pushAskNewHighBid, pushAskNewLowAsk, pushAskItemSold, createdAt: String?
    let updatedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case userId = "user_id"
        case bidNewLowAsk = "bid_new_low_ask"
        case bidNewHighBid = "bid_new_high_bid"
        case bidAccepted = "bid_accepted"
        case folNewLowAsk = "fol_new_low_ask"
        case askNewHighBid = "ask_new_high_bid"
        case askNewLowAsk = "ask_new_low_ask"
        case askItemSold = "ask_item_sold"
        case pushBidNewLowAsk = "push_bid_new_low_ask"
        case pushBidNewHighBid = "push_bid_new_high_bid"
        case pushBidAccepted = "push_bid_accepted"
        case pushFolNewLowAsk = "push_fol_new_low_ask"
        case pushAskNewHighBid = "push_ask_new_high_bid"
        case pushAskNewLowAsk = "push_ask_new_low_ask"
        case pushAskItemSold = "push_ask_item_sold"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    
    init(id: Int?, userId: String?, bidNewLowAsk: String?, bidNewHighBid: String?, bidAccepted: String?, folNewLowAsk: String?, askNewHighBid: String?, askNewLowAsk: String?, askItemSold: String?, pushBidNewLowAsk: String?, pushBidNewHighBid: String?, pushBidAccepted: String?, pushFolNewLowAsk: String?, pushAskNewHighBid: String?, pushAskNewLowAsk: String?, pushAskItemSold: String?, createdAt: String?, updatedAt: String?) {
        self.id = id
        self.userId = userId
        self.bidNewLowAsk = bidNewLowAsk
        self.bidNewHighBid = bidNewHighBid
        self.bidAccepted = bidAccepted
        self.folNewLowAsk = folNewLowAsk
        self.askNewHighBid = askNewHighBid
        self.askNewLowAsk = askNewLowAsk
        self.askItemSold = askItemSold
        self.pushBidNewLowAsk = pushBidNewLowAsk
        self.pushBidNewHighBid = pushBidNewHighBid
        self.pushBidAccepted = pushBidAccepted
        self.pushFolNewLowAsk = pushFolNewLowAsk
        self.pushAskNewHighBid = pushAskNewHighBid
        self.pushAskNewLowAsk = pushAskNewLowAsk
        self.pushAskItemSold = pushAskItemSold
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}

