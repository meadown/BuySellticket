//
//  GetBillingAddressResponse.swift
//  FestFriend02
//  Copyright © 2019 MySoftheaven BD. All rights reserved.
//

import Foundation

class GetBilingAddressResponse: Codable {
    let status: Bool?
    let msg: String?
    let billingAddresses: [BillingAddress]?
    
    init(status: Bool?, msg: String?, billingAddresses: [BillingAddress]?) {
        self.status = status
        self.msg = msg
        self.billingAddresses = billingAddresses
    }
    
    func getActiveBillingAddress() -> BillingAddress? {
        
        if let addresses = billingAddresses {
            
            for address in addresses {
                if address.status!.elementsEqual("1") {
                    return address
                }
            }
            return nil
        } else {
            return nil
        }
    }
}

class BillingAddress: Codable {
    let id: Int?
    let userId, name, streetAddress, aptSuiteUnit: String?
    let countryId, countryName, city, stateRegion: String?
    let zipPostalCode, notes, status, createdAt: String?
    let updatedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case userId = "user_id"
        case name
        case streetAddress = "street_address"
        case aptSuiteUnit = "apt_suite_unit"
        case countryId = "country_id"
        case countryName = "country_name"
        case city
        case stateRegion = "state_region"
        case zipPostalCode = "zip_postal_code"
        case notes, status
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    
    init(id: Int?, userId: String?, name: String?, streetAddress: String?, aptSuiteUnit: String?, countryId: String?, countryName: String?, city: String?, stateRegion: String?, zipPostalCode: String?, notes: String?, status: String?, createdAt: String?, updatedAt: String?) {
        self.id = id
        self.userId = userId
        self.name = name
        self.streetAddress = streetAddress
        self.aptSuiteUnit = aptSuiteUnit
        self.countryId = countryId
        self.countryName = countryName
        self.city = city
        self.stateRegion = stateRegion
        self.zipPostalCode = zipPostalCode
        self.notes = notes
        self.status = status
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
    func formatedAddress() -> String {
        var address = ""
        
        if let street = streetAddress {
            address.append("\(street) ")
        }
        
        if let aptSuiteUnit = aptSuiteUnit {
            address.append(", \(aptSuiteUnit)")
        }
        
        if let city = city {
            address.append("\n\(city)")
        }
        if let state = stateRegion {
            address.append(", \(state)")
        }
        
        if let zip = zipPostalCode{
            address.append(" \(zip) ")
        }
        
        
        return address
    }
}

