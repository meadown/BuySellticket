//
//  AuthenticationModels.swift
//  FestFriend02
//  Copyright © 2019 MySoftheaven BD. All rights reserved.
//

import Foundation


class LoginResponse: Codable {
    let status: Bool?
    let userDetails: UserDetails?
    let msg: String?

    
    init(status: Bool?, userDetails: UserDetails?, msg: String?) {
        self.status = status
        self.userDetails = userDetails
        self.msg = msg
        
    }
}



class UserDetails: Codable {
    let userID: Int?
    let name, email: String?
    
    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case name, email
    }
    
    init(userID: Int?, name: String?, email: String?) {
        self.userID = userID
        self.name = name
        self.email = email
    }
}


class UserDetailsResponse: Codable {
    let status: Bool?
    let userDetails: UserDetail?
    let msg: String?
    
    init(status: Bool?, userDetails: UserDetail?, msg: String?) {
        self.status = status
        self.userDetails = userDetails
        self.msg = msg
    }
}

class UserDetail: Codable {
    let id, name, email, country: String?
    let state, city, age: String?
    let image: String?
    let createdAt, updatedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name, email, country, state, city, age, image
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    
    init(id: String?, name: String?, email: String?, country: String?, state: String?, city: String?, age: String?, image: String?, createdAt: String?, updatedAt: String?) {
        self.id = id
        self.name = name
        self.email = email
        self.country = country
        self.state = state
        self.city = city
        self.age = age
        self.image = image
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}

