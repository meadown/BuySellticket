//
//  AskBidResponse.swift
//  FestFriend02
//
//  Created by Biswajit Banik on 18/1/20.
//  Copyright © 2020 MySoftheaven BD. All rights reserved.
//

import Foundation

class AskBidResponse: Codable {
    let status: Bool?
    let flag: Int?
    let msg: String?
    
    init(status: Bool? ,flag: Int?,msg: String? ) {
        self.status = status
        self.flag = flag
        self.msg = msg
        
    }
}
