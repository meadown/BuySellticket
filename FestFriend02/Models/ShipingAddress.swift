//
//  ShipingAddress.swift
//  FestFriend02
//  Copyright © 2019 MySoftheaven BD. All rights reserved.
//


import Foundation

class ShipingAddressResponse: Codable {
    let status: Bool?
    let msg: String?
    let shippingAddresses: [ShippingAddress1]?
    
    init(status: Bool?, msg: String?, shippingAddresses: [ShippingAddress1]?) {
        self.status = status
        self.msg = msg
        self.shippingAddresses = shippingAddresses
    }
    
    func getActiveShipingAddress() -> ShippingAddress1? {
        
        if let addresses = shippingAddresses {
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

class ShippingAddress1: Codable {
    let id: Int?
    let userID, name, streetAddress, aptSuiteUnit: String?
    let countryID: String?
    let countryName: String?
    let city, stateRegion, zipPostalCode, notes: String?
    let status, createdAt: String?
    let updatedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case name
        case streetAddress = "street_address"
        case aptSuiteUnit = "apt_suite_unit"
        case countryID = "country_id"
        case countryName = "country_name"
        case city
        case stateRegion = "state_region"
        case zipPostalCode = "zip_postal_code"
        case notes, status
        case createdAt = "created_at"
        case updatedAt = "updated_at"
            
    }
    
    init(id: Int?, userID: String?, name: String?, streetAddress: String?, aptSuiteUnit: String?, countryID: String?, countryName: String?, city: String?, stateRegion: String?, zipPostalCode: String?, notes: String?, status: String?, createdAt: String?, updatedAt: String?) {
        self.id = id
        self.userID = userID
        self.name = name
        self.streetAddress = streetAddress
        self.aptSuiteUnit = aptSuiteUnit
        self.countryID = countryID
        self.countryName = countryName
        self.city = city
        self.stateRegion = stateRegion
        self.zipPostalCode = zipPostalCode
        self.notes = notes
        self.status = status
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
    func getFormatedAddress() -> String {
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

enum CountryName: String, Codable {
    case unitedStatesOfAmerica = "United States of America"
}

enum UpdatedAt: String, Codable {
    case the20190204021918 = "2019-02-04 02:19:18"
}

