//
//  StateListResponse.swift
//  FestFriend02
//  Copyright © 2019 MySoftheaven BD. All rights reserved.
//

import Foundation

class StateListResponse: Codable {
    let status: Bool?
    let allStateList: [State]?
    let msg: String?
    
    init(status: Bool?, allStateList: [State]?, msg: String?) {
        self.status = status
        self.allStateList = allStateList
        self.msg = msg
    }
}

class State: Codable {
    let id: Int?
    let name, status, createdAt, updatedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name, status
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    
    init(id: Int?, name: String?, status: String?, createdAt: String?, updatedAt: String?) {
        self.id = id
        self.name = name
        self.status = status
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}

