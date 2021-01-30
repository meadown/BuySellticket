//
//  CheckCouponsResponse.swift
//  FestFriend02
//  Copyright © 2019 MySoftheaven BD. All rights reserved.
//

import Foundation

class CheckCouponsResponse: Codable {
    let status: Bool?
    let msg, amount: String?
    
    init(status: Bool?, msg: String?, amount: String?) {
        self.status = status
        self.msg = msg
        self.amount = amount
    }
}

