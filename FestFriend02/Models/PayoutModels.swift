//
//  PayoutModels.swift
//  FestFriend02
//  Copyright © 2019 MySoftheaven BD. All rights reserved.
//

import Foundation

class GetPayoutResponse: Codable {
    let status: Bool?
    let msg: String?
    let payout: Payout?
    
    init(status: Bool?, msg: String?, payout: Payout?) {
        self.status = status
        self.msg = msg
        self.payout = payout
    }
    
    enum CodingKeys: String, CodingKey {
        case status, msg
        case payout = "result"
    }
}

class Payout: Codable {
    let id: Int?
    let userId, cardNumber, cvv: String?
    let cardBrand: JSONNull?
    let cardExpMonth, cardExpYear, bankFirstName, bankLastName: String?
    let bankAccountName, bankRoutingNumber, bankAccountNumber, status: String?
    let paypalEmail, paymentMethod, createdAt, updatedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case userId = "user_id"
        case cardNumber = "card_number"
        case cvv
        case cardBrand = "card_brand"
        case cardExpMonth = "card_exp_month"
        case cardExpYear = "card_exp_year"
        case bankFirstName = "bank_first_name"
        case bankLastName = "bank_last_name"
        case bankAccountName = "bank_account_name"
        case bankRoutingNumber = "bank_routing_number"
        case bankAccountNumber = "bank_account_number"
        case status
        case paypalEmail = "paypal_email"
        case paymentMethod = "payment_method"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    
    init(id: Int?, userId: String?, cardNumber: String?, cvv: String?, cardBrand: JSONNull?, cardExpMonth: String?, cardExpYear: String?, bankFirstName: String?, bankLastName: String?, bankAccountName: String?, bankRoutingNumber: String?, bankAccountNumber: String?, status: String?, paypalEmail: String?, paymentMethod: String?, createdAt: String?, updatedAt: String?) {
        self.id = id
        self.userId = userId
        self.cardNumber = cardNumber
        self.cvv = cvv
        self.cardBrand = cardBrand
        self.cardExpMonth = cardExpMonth
        self.cardExpYear = cardExpYear
        self.bankFirstName = bankFirstName
        self.bankLastName = bankLastName
        self.bankAccountName = bankAccountName
        self.bankRoutingNumber = bankRoutingNumber
        self.bankAccountNumber = bankAccountNumber
        self.status = status
        self.paypalEmail = paypalEmail
        self.paymentMethod = paymentMethod
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
    func getFormatedCardNumber() -> String {
        if let cardNumber = cardNumber, !cardNumber.isEmpty {
            let cardPrefix = cardNumber.suffix(4)
            var number = ""
            
//            for _ in 0 ..< cardNumber.count - 4 {
//                number.append("*")
//            }
            number.append("Card ending in \(cardPrefix)")
            return number
        } else {
            return ""
        }
    }
    //Mark:- return last 4 digit of card
    func getlastfourofCardNumber() -> String {
            if let cardNumber = cardNumber, !cardNumber.isEmpty {
                let cardPrefix = cardNumber.suffix(4)
                var number = ""
                
    //            for _ in 0 ..< cardNumber.count - 4 {
    //                number.append("*")
    //            }
                number.append(contentsOf: cardPrefix)
                return number
            } else {
                return ""
            }
        }
    
    //Mark:- return last disgits of accounts
    func getFormatedAccountNumber() -> String {
        if let cardNumber = bankAccountNumber, !cardNumber.isEmpty {
            let cardPrefix = cardNumber.suffix(4)
            var number = ""
            
//            for _ in 0 ..< cardNumber.count - 4 {
//                number.append("*")
//            }
            number.append("Account ending in \(cardPrefix)")
            return number
        } else {
            return ""
        }
    }
}
