//
//  BidResponse.swift
//  FestFriend02
//
//  Created by Biswajit Banik on 5/1/20.
//  Copyright © 2020 MySoftheaven BD. All rights reserved.
//

import Foundation

class BidResponse: Codable {
    let status: Bool?
    let bidId: Int?
    let msg: String?
    
    init(status: Bool? ,bidId: Int?,msg: String? ) {
        self.status = status
        self.bidId = bidId
        self.msg = msg
        
    }
}
