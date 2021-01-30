//
//  APISingletonClass.swift
//  FestFriend02
//
//  Created by MySoftheaven BD on 16/10/18.
//  Copyright © 2018 MySoftheaven BD. All rights reserved.
//


import Foundation
import Alamofire
import SwiftyJSON

class APICall {
    
    private static let baseUrl = "http://mysoftheaven.com/lrb/festfriends/api/"
    private static let homeInfoUrl1 = "\(baseUrl)landingInfo"
    private static let homeInfoUrl2 = "\(baseUrl)landingInfo2"
    private static let homeInfoUrl3 = "\(baseUrl)get-ticker-tab"
    private static let festDetailsUrl = "\(baseUrl)get-festival-details/"
    private static let ticketDetailsUrl = "\(baseUrl)get-ticket-details/"
    private static let festivalTicketsUrl = "\(baseUrl)ticket-of-festivals/"
    private static let loginUrl = "\(baseUrl)login"
    private static let signupUrl = "\(baseUrl)registration"
    private static let socialLoginUrl = "\(baseUrl)social-login"
    private static let resetPasswordUrl = "\(baseUrl)password/email"
    private static let favoriteListUrl = "\(baseUrl)get-favorites"
    private static let addFavoriteUrl = "\(baseUrl)add-favorite"
    private static let removeFavoriteUrl = "\(baseUrl)remove-favorite"
    private static let allSalesAsksBidsUrl = "\(baseUrl)get-all-ask-bid-sale"
    private static let allStatesUrl = "\(baseUrl)get-all-states"
    private static let addShipingAddressUrl = "\(baseUrl)add-shipping-address"
    private static let changePassUrl = "\(baseUrl)reset-password"
    private static let postAskUrl = "\(baseUrl)post-ask"
    private static let updateAskUrl = "\(baseUrl)update-ask"
    private static let cancelAskUrl = "\(baseUrl)cancel-ask"
    private static let postBidUrl = "\(baseUrl)post-bid"
    private static let updateBidUrl = "\(baseUrl)update-bid"
    private static let stripDirectPaymnent = "\(baseUrl)stripe-direct-payment"
    private static let stripauthorizePayment = "\(baseUrl)stripe-authorize-payment"
    private static let cancelBidUrl = "\(baseUrl)cancel-bid"
    private static let userDetailsUrl = "\(baseUrl)user-details/"
    private static let userCouponsUrl = "\(baseUrl)get-user-coupons/"
    private static let shipingAddressUrl = "\(baseUrl)get-user-shipping-addresses/"
    private static let editShipingAddressUrl = "\(baseUrl)edit-shipping-address"
    private static let allUserAsksUrl = "\(baseUrl)get-user-asks/"
    private static let updateUserDetailes = "\(baseUrl)update-user-details/"

    private static let allUserBidsUrl = "\(baseUrl)get-user-bids/"
    private static let deleteUserAskUrl = "\(baseUrl)cancel-ask"
    //active-ask-bid
    private static let activeAskBidUrl = "\(baseUrl)active-ask-bid"
    private static let deleteUserBidUrl = "\(baseUrl)cancel-bid"
    private static let searchUrl = "\(baseUrl)search/"
    private static let getUserPayoutUrl = "\(baseUrl)get-user-payout/"
    private static let getNotificationStatusUrl = "\(baseUrl)get-notification-states/"
    private static let changeNotificationStatusUrl = "\(baseUrl)user-noti-status-change/"
    private static let getBillingAddressUrl = "\(baseUrl)get-user-billing-addresses/"
    private static let addPayoutInfoUrl = "\(baseUrl)add-user-payout/"
    private static let checkCouponUrl = "\(baseUrl)check-coupons/"
    private static let fcmDeviceRegisterUrl = "\(baseUrl)user-devices"

    
   // "\(getBillingAddressUrl)\(LocalPersistance.getUserId())"
    
    static private func getRequest<T: Codable>(url: String, complition: @escaping (T?) -> Void) {
        DispatchQueue.main.async {
            Alamofire.request(url).responseJSON { (response) in
                if let error = response.error {
                    print("HomeInfo1: error in network. Try again later")
                    print(error)
                    complition(nil)
                }
                
                
                if let data = response.data {
                    do {
                        
                        print("ResponseD: \(data)")

                        
                        let dataString = String(data: data, encoding: String.defaultCStringEncoding)
                        print("Response: \(dataString!)")
                        
//                        let data2 = dataString!.data(using: .utf8)
                        
//                        let dataObjc = try JSONDecoder().decode(Data.self, from: data)

                        let dataJson = dataString?.data(using: .utf8)!

                        let dataObj = try JSONDecoder().decode(T.self, from: dataJson!)
                        
                        
                        complition(dataObj)
                    } catch {
                        print("GET error main: \(error)")
                         print("GET error: \(error.localizedDescription)")
                    }
                    
                }
            }
        }
    }
    
    static private func postRequest<T: Codable>(url: String, body: [String: AnyObject]?, completion: @escaping (T?) -> Void) {
        request(url, method: .post, parameters: body, encoding: JSONEncoding.default).responseJSON { (response) in
            
            if let error = response.error {
                print(error)
                completion(nil)
            }
            
            if let data = response.data {
                do {
                    let dataString = String(data: data, encoding: String.defaultCStringEncoding)
                    print("Response from API: \(dataString!)")
                    let dataObj = try JSONDecoder().decode(T.self, from: data)
                    completion(dataObj)
                } catch {
                    print("Post Error: \(error.localizedDescription)")
                    completion(nil)
                }
                
            }
        }
    }
    
    static func getAllHomeInformation(complition: @escaping (HomeViewInfo) -> Void ) {
        var homeFestivals = Festivals()
        var homeBids = Bids()
        
        let taskGroup = DispatchGroup()
        
        getFestivals(in: taskGroup) { (festivals) in
            if let festivals = festivals {
                homeFestivals = festivals
            }
        }
        
        getBids(in: taskGroup) { (bids) in
            if let bids = bids {
                homeBids = bids
            }
        }
        
        taskGroup.notify(queue: DispatchQueue.main, work: DispatchWorkItem(block: {
            
            let homeInfo = prepareHomeInfo(from: homeFestivals, and: homeBids)
            print("FeaturedListCount: \(homeInfo.featuredFestivals?.count)")
            complition(homeInfo)
        }))
    }
    
    private static func prepareHomeInfo(from homeFestivals: Festivals, and homeBids: Bids) -> HomeViewInfo{
        
        var homeInfo = HomeViewInfo()
        
        if let featuredFest = homeFestivals.featureFestivals {
            homeInfo.featuredFestivals = featuredFest
        }
        
        print("FeaturedListCount: \(homeInfo.featuredFestivals?.count)")
        
        if let popularFest = homeFestivals.popularFestivals {
            homeInfo.popularFestivals = popularFest
        }
        
        if let upcomingFest = homeFestivals.upcomingFestivals {
            homeInfo.upcomingFestivals = upcomingFest
        }
        
        if let recentSales = homeBids.soldTickets {
            homeInfo.recentSales = recentSales
        }
        
        if let lowestAsks = homeBids.newLowestAsks {
            homeInfo.newLowestAsks = lowestAsks
        }
        
        if let highestBids = homeBids.newHighestBids {
            homeInfo.newHighestBids = highestBids
        }
        
        if let releasedCalander = homeBids.releaseCalender {
            homeInfo.releasedCalenders = releasedCalander
        }
        
        return homeInfo
    }
    
    private static func getFestivals(in taskGroup: DispatchGroup, complition: @escaping (Festivals?) -> Void) {
        
        taskGroup.enter()
        getRequest(url: homeInfoUrl1) { (festivals: Festivals?) in
            if let festivals = festivals {
                complition(festivals)
            } else {
                complition(nil)
            }
            taskGroup.leave()
        }
    }
    
    private static func getBids(in taskGroup: DispatchGroup, complition: @escaping (Bids?) -> Void) {
        
        taskGroup.enter()
        getRequest(url: homeInfoUrl2) { (bids: Bids?) in
            if let bids = bids {
                complition(bids)
            } else {
                complition(nil)
            }
            taskGroup.leave()
        }
    }
    
    static func getTickerTabs(complition: @escaping (TickerTabs?) -> Void) {
        getRequest(url: homeInfoUrl3, complition: complition)
    }
    
    static func getFestDetails(id: Int, complition: @escaping(FestivalDetailsResponse?) -> Void) {
        
        let url = "\(festDetailsUrl)\(id)"
        Alamofire.request(url).responseJSON { (response) in
            if let error = response.error {
                print("HomeInfo3: error in network. Try again later")
                print(error)
                complition(nil)
            }
            
            if let data = response.data {
                do {
                    let dataString = String(data: data, encoding: String.defaultCStringEncoding)
                    print("FestivalDetails: \(dataString!)")
                    let festDetails = try JSONDecoder().decode(FestivalDetailsResponse.self, from: data)
                    complition(festDetails)
                } catch {
                    complition(nil)
                    print("\(error.localizedDescription)")
                }
                
            }
        }
    }
    
    static func getTicketDetails(id: Int, complition: @escaping(TicketDetailsResponse?) -> Void) {
        
        let url = "\(ticketDetailsUrl)\(id)"
        Alamofire.request(url).responseJSON { (response) in
            if let error = response.error {
                print("TicketDetails: error in network. Try again later")
                print(error)
                complition(nil)
            }
            
            if let data = response.data {
                do {
                    let dataString = String(data: data, encoding: String.defaultCStringEncoding)
                    print("FestivalDetails: \(dataString!)")
                    let festDetails = try JSONDecoder().decode(TicketDetailsResponse.self, from: data)
                    complition(festDetails)
                } catch {
                    complition(nil)
                    print("\(error.localizedDescription)")
                }
                
            }
        }
    }
    
    static func getFestivalTickets(id: Int, completion: @escaping (FestivalTicketsResponse?) -> Void) {
        let url = "\(festivalTicketsUrl)\(id)"
        getRequest(url: url, complition: completion)
    }
    
    static func requestLogin(params: [String: AnyObject], completion: @escaping(LoginResponse?) -> Void) {
        postRequest(url: loginUrl, body: params, completion: completion)
    }
    
    static func requestSignup(params: [String: AnyObject], completion: @escaping(LoginResponse?) -> Void) {
        postRequest(url: signupUrl, body: params, completion: completion)
    }
    
    static func requestSocialLogin(params: [String: AnyObject], completion: @escaping(LoginResponse?) -> Void) {
        postRequest(url: socialLoginUrl, body: params, completion: completion)
    }
    
    static func requestResetPassword(params: [String: AnyObject], completion: @escaping(LoginResponse?) -> Void) {
        postRequest(url: resetPasswordUrl, body: params, completion: completion)
    }
    
    static func getFavoriteList(completion: @escaping(FavouriteLis?) -> Void) {
        let params = ["user_id": LocalPersistance.getUserId()] as! [String: AnyObject]
        postRequest(url: favoriteListUrl, body: params, completion: completion)
    }
    
    static func removeFavorite(params: [String: AnyObject], completion: @escaping(LoginResponse?) -> Void) {
        postRequest(url: removeFavoriteUrl, body: params, completion: completion)
    }
    
    static func getAllSalesAsksBids(ticketId: Int, quantity: Int, completion: @escaping(ViewSalesBidsAsksResponse?) -> Void) {
        let url = "\(allSalesAsksBidsUrl)/\(ticketId)/\(quantity)"
        print("GetAllSalesAskBidsUrl: \(url)")
        getRequest(url: url, complition: completion)
    }
    
    static func getAllStates(completion: @escaping(StateListResponse?) -> Void) {
        getRequest(url: allStatesUrl, complition: completion)
    }
    
    static func addShipingBillingAddress(urlEnd: String, param: [String: AnyObject], completion: @escaping(AddShipingAddressResponse?) -> Void) {
        let url = "\(baseUrl)\(urlEnd)"
        postRequest(url: url, body: param, completion: completion)
    }
    
    static func changePassword(params: [String: AnyObject], completion: @escaping(LoginResponse?) -> Void) {
        postRequest(url: changePassUrl, body: params, completion: completion)
    }
    
    static func postAsk(param: [String: AnyObject], completion: @escaping(LoginResponse?) -> Void) {
        postRequest(url: postAskUrl, body: param, completion: completion)
    }
    
    static func updateAsk(param: [String: AnyObject], completion: @escaping(LoginResponse?) -> Void) {
        postRequest(url: updateAskUrl, body: param, completion: completion)
    }
    
    static func postBid(param: [String: AnyObject], completion: @escaping(BidResponse?) -> Void) {
        postRequest(url: postBidUrl, body: param, completion: completion)
    }
    
    static func updateBid(param: [String: AnyObject], completion: @escaping(LoginResponse?) -> Void) {
        postRequest(url: updateBidUrl, body: param, completion: completion)
    }
    static func stripDirectBuy(param: [String: AnyObject], completion: @escaping(LoginResponse?) -> Void) {
        postRequest(url: stripDirectPaymnent, body: param, completion: completion)
    }
    static func stripAuthorize(param: [String: AnyObject], completion: @escaping(LoginResponse?) -> Void) {
        postRequest(url: stripauthorizePayment, body: param, completion: completion)
    }
    
    static func getUserDetails(completion: @escaping(UserDetailsResponse?) -> Void) {
        getRequest(url: "\(userDetailsUrl)\(LocalPersistance.getUserId())", complition: completion)
    }
    
    static func getUserCoupons(completion: @escaping(CouponsResponse?) -> Void) {
        getRequest(url:"\(userCouponsUrl)\(LocalPersistance.getUserId())" , complition: completion)
    }
    
    static func getShipingAddresses(completion: @escaping(ShipingAddressResponse?) -> Void) {
        getRequest(url: "\(shipingAddressUrl)\(LocalPersistance.getUserId())", complition: completion)
    }
    
    static func editShipingBillingAddress(urlEnd: String, param: [String: AnyObject], completion: @escaping(AddShipingAddressResponse?) -> Void) {
        let url = "\(baseUrl)\(urlEnd)"
        postRequest(url: url, body: param, completion: completion)
    }
    
    static func updateUserAddress(param: [String: AnyObject], completion: @escaping(UpdateBillingAddress?) -> Void) {
        postRequest(url:"\(updateUserDetailes)\(LocalPersistance.getUserId())", body: param, completion: completion)
    }
    
    static func getAllUserBids(completion: @escaping(UserBuyingResponse?) -> Void) {
        getRequest(url:  "\(allUserBidsUrl)\(LocalPersistance.getUserId())" , complition: completion)
    }
    
    static func getAllUserAsks(completion: @escaping(UserSellingResponse?) -> Void) {
        getRequest(url: "\(allUserAsksUrl)\(LocalPersistance.getUserId())", complition: completion)
    }
    //active-ask-bid
    static func deleteUserAsk(param: [String: AnyObject], completion: @escaping(LoginResponse?) -> Void) {
        postRequest(url: deleteUserAskUrl, body: param, completion: completion)
    }
    
    static func activeAskBid(param: [String: AnyObject], completion: @escaping(AskBidResponse?) -> Void) {
        postRequest(url: activeAskBidUrl, body: param, completion: completion)
    }
    static func deleteUserBid(param: [String: AnyObject], completion: @escaping(LoginResponse?) -> Void) {
        postRequest(url: deleteUserBidUrl, body: param, completion: completion)
    }
    
    static func addFavorite(param: [String: AnyObject], completion: @escaping(LoginResponse?) -> Void) {
        postRequest(url: addFavoriteUrl, body: param, completion: completion)
    }
    
    static func search(for text: String, completion: @escaping(SearchResponse?) -> Void) {
        let url = "\(searchUrl)\(text)"
        getRequest(url: url, complition: completion)
    }
    
    static func getUserPayout(completion: @escaping (GetPayoutResponse?) -> Void) {
        getRequest(url: "\(getUserPayoutUrl)\(LocalPersistance.getUserId())", complition: completion)
    }
    
    static func getNotoficationStatus(completion: @escaping(NotificationStatusResponse?) -> Void) {
        getRequest(url: "\(getNotificationStatusUrl)\(LocalPersistance.getUserId())", complition: completion)
    }
    
    static func changeNotiStatus(statusValue: String, status: Int, completion: @escaping(LoginResponse?) -> Void) {
        let url = "\(changeNotificationStatusUrl)\(LocalPersistance.getUserId())/\(statusValue)/\(status)"
        getRequest(url: url, complition: completion)
    }
    
    static func getBillingAddress(completion: @escaping(GetBilingAddressResponse?) -> Void) {
        getRequest(url: "\(getBillingAddressUrl)\(LocalPersistance.getUserId())", complition: completion)
    }
    
    static func addPayoutInfo(param: [String: AnyObject], completion: @escaping(LoginResponse?) -> Void) {
        postRequest(url: addPayoutInfoUrl, body: param, completion: completion)
    }
    
    static func checkCoupon(param: [String: AnyObject], completion: @escaping(CheckCouponsResponse?) -> Void) {
        postRequest(url: checkCouponUrl, body: param, completion: completion)
    }
    
    static func fcmDeviceRegister(param: [String: AnyObject], completion: @escaping(FcmDeviceRegistrationResponse?) -> Void) {
        postRequest(url: fcmDeviceRegisterUrl, body: param, completion: completion)
    }
    
    
}



