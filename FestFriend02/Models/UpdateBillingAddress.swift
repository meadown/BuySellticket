//
//  UpdateBillingAddress.swift
//  FestFriend02
//
//  Created by Biswajit Banik on 11/12/19.
//  Copyright © 2019 MySoftheaven BD. All rights reserved.
//

import Foundation


class UpdateBillingAddress: Codable {
    let status: Bool?
    let msg: String?
    let shippingAddress: UpdateBilling?
    
    init(status: Bool?, msg: String?, shippingAddress: UpdateBilling?) {
        self.status = status
        self.msg = msg
        self.shippingAddress = shippingAddress
    }
}

class UpdateBilling: Codable {
    let userID: Int?
    let name, streetAddress, aptSuiteUnit: String?
    let countryID: Int?
    let city, stateRegion, zipPostalCode, notes: String?
    let status: Int?
    let updatedAt, createdAt: String?
    let id: Int?
    let countryName: String?
    
    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case name
        case streetAddress = "street_address"
        case aptSuiteUnit = "apt_suite_unit"
        case countryID = "country_id"
        case city
        case stateRegion = "state_region"
        case zipPostalCode = "zip_postal_code"
        case notes, status
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        case id
        case countryName = "country_name"
    }
    
    init(userID: Int?, name: String?, streetAddress: String?, aptSuiteUnit: String?, countryID: Int?, city: String?, stateRegion: String?, zipPostalCode: String?, notes: String?, status: Int?, updatedAt: String?, createdAt: String?, id: Int?, countryName: String?) {
        self.userID = userID
        self.name = name
        self.streetAddress = streetAddress
        self.aptSuiteUnit = aptSuiteUnit
        self.countryID = countryID
        self.city = city
        self.stateRegion = stateRegion
        self.zipPostalCode = zipPostalCode
        self.notes = notes
        self.status = status
        self.updatedAt = updatedAt
        self.createdAt = createdAt
        self.id = id
        self.countryName = countryName
    }
}
