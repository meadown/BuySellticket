//
//  CouponModel.swift
//  FestFriend02
//  Copyright © 2019 MySoftheaven BD. All rights reserved.
//

import Foundation

class CouponsResponse: Codable {
    let status: Bool?
    let msg: String?
    let coupons: [Coupon]?
    
    init(status: Bool?, msg: String?, coupons: [Coupon]?) {
        self.status = status
        self.msg = msg
        self.coupons = coupons
    }
}

class Coupon: Codable {
    let code, name, amount, canBeUse: String?
    let alreadyUsed, expireDate, status, createdAt: String?
    let updatedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case code, name, amount, canBeUse, alreadyUsed, expireDate, status
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    
    init(code: String?, name: String?, amount: String?, canBeUse: String?, alreadyUsed: String?, expireDate: String?, status: String?, createdAt: String?, updatedAt: String?) {
        self.code = code
        self.name = name
        self.amount = amount
        self.canBeUse = canBeUse
        self.alreadyUsed = alreadyUsed
        self.expireDate = expireDate
        self.status = status
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}

