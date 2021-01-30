//
//  LocalPersistance.swift
//  FestFriend02
//
//

import Foundation

class LocalPersistance {
    
    static let userIdKey = "userId"
    static let usersNameKey = "name"
    static let userEmailKey = "email"
    static let fcm_token = "fcm_token"
    static let device_id = "device_id"
    static let stripe_id_token = "stripe_id_token"
    static let CardNumberLast4 = " "



    
    private static let defaults = UserDefaults.standard
    
    static func getUserId() -> Int {
        let id = defaults.integer(forKey: userIdKey)
        return id
    }
    
    static func setUserId(id: Int) {
        defaults.set(id, forKey: userIdKey)
    }
    
    static func setUserName(name: String) {
        defaults.set(name, forKey: usersNameKey)
    }
    
    static func getUserName() -> String? {
        return defaults.string(forKey: usersNameKey)
    }
    
    static func setUseEmail(email: String) {
        defaults.set(email, forKey: userEmailKey)
    }
    
    static func getUserEmail() -> String? {
        return defaults.string(forKey: userEmailKey)
    }
    
    static func setFcmToken(token: String) {
        defaults.set(token, forKey: fcm_token)
    }
    
    static func getFcmToken() -> String? {
        return defaults.string(forKey: fcm_token)
    }
    
    static func setDeviceId(id: String) {
        defaults.set(id, forKey: device_id)
    }
    
    static func getDeviceId() -> String? {
        return defaults.string(forKey: device_id)
    }
    
    static func setStripeIdToken(id: String) {
        defaults.set(id, forKey: stripe_id_token)
    }
    
    static func getStripeIdToken() -> String? {
        return defaults.string(forKey: stripe_id_token)
    }
    
    static func setCardNumberLast4(card: String) {
        defaults.set(card, forKey: CardNumberLast4)
    }
    
    static func getCardNumberLast4() -> String? {
        return defaults.string(forKey: CardNumberLast4)
    }
    
    static func setUserDetails(userDetails: UserDetails) {
        setUserId(id: userDetails.userID!)
        setUserName(name: userDetails.name!)
        setUseEmail(email: userDetails.email!)
    }
    
    static func clearUserDetails() {
        defaults.removeObject(forKey: userIdKey)
        defaults.removeObject(forKey: usersNameKey)
        defaults.removeObject(forKey: userEmailKey)
    }
    
}
