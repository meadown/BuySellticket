//
//  NotificationStatusModel.swift
//  FestFriend02
//  Copyright © 2019 MySoftheaven BD. All rights reserved.
//

import Foundation

class FcmDeviceRegistrationResponse: Codable {
    let status: Bool?
    let msg: String?
    
    init(status: Bool?, msg: String?) {
        self.status = status
        self.msg = msg
    }
}


