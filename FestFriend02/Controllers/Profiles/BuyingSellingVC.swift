//
//  BuyingSellingVC.swift
//  FestFriend02
//  Copyright © 2019 MySoftheaven BD. All rights reserved.
//

import Foundation
import UIKit
import XLPagerTabStrip

class BuyingSellingVC: ButtonBarPagerTabStripViewController {
    
    var isBuying = false
    
    var userBuyingResponse: UserBuyingResponse?
    var userSellingResponse: UserSellingResponse?
    var which_view = " "
    
    override func viewDidLoad() {
        
        settings.style.selectedBarHeight = 2
        
        super.viewDidLoad()
        let titleAttributes = [
            NSAttributedStringKey.font: UIFont.systemFont(ofSize: 15 , weight: UIFont.Weight.bold),
            NSAttributedStringKey.foregroundColor: UIColor.black
        ]
        self.navigationController?.navigationBar.titleTextAttributes = titleAttributes
        
        buttonBarView.selectedBar.backgroundColor = UIColor.appGreenColor
        buttonBarView.backgroundColor = UIColor.white
        settings.style.buttonBarItemTitleColor = UIColor.black
        settings.style.buttonBarItemBackgroundColor = UIColor.white
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if isBuying {
            title = "Buying"
            getAllBids()
        } else {
            title = "Selling"
            getAllAsks()
        }
    }
    
    private func getAllBids() {
        showProgress(on: view)
        APICall.getAllUserBids { (response) in
            self.dismissProgress(for: self.view)
            
            if let response = response {
                if response.status! {
                    self.userBuyingResponse = response
                    self.reloadPagerTabStripView()
                }
            }
        }
    }
    
    private func getAllAsks() {
        showProgress(on: view)
        APICall.getAllUserAsks { (response) in
            self.dismissProgress(for: self.view)
            
            if let response = response {
                if response.status! {
                    self.userSellingResponse = response
                    self.reloadPagerTabStripView()
                }
            }
        }
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        
        let sb = UIStoryboard(name: "Profile", bundle: nil)
        let child1 = sb.instantiateViewController(withIdentifier: "CurrentAsksBidsVC") as! CurrentAsksBidsVC
        child1.isBuying = isBuying
        let child2 = sb.instantiateViewController(withIdentifier: "HistoryCanceledVC") as! HistoryCanceledVC
        child2.isBuying = isBuying
        child2.isCanceled = false
        let child3 = sb.instantiateViewController(withIdentifier: "HistoryCanceledVC") as! HistoryCanceledVC
        child3.isBuying = isBuying
        child3.isCanceled = true
        
        if isBuying {
            
            print("\(isBuying)")
            if let buying = userBuyingResponse {
                if let currentBids = buying.currentBids {
                    child1.currentBids = currentBids
                }
                
                if let purchaseBids = buying.purchasedBids {
                    child2.userBids = purchaseBids
                }
                
                if let canceled = buying.canceledBids {
                    child3.userBids = canceled
                }
            }
        } else {
            if let selling = userSellingResponse {
                if let currentAsk = selling.currentAsks {
                    child1.currentAsks = currentAsk
                }
                
                if let soldAsk = selling.soldAsks {
                    child2.userAsks = soldAsk
                }
                
                if let canceledAsk = selling.canceledAsks {
                    child3.userAsks = canceledAsk
                }
            }
        }
        
        return [child1, child2, child3]
    }
    
//    override func reloadPagerTabStripView() {
//
//    }
    
    
    //Mark:- Any action can be done here while the view contrtollar will be disapper.
       override func viewWillDisappear(_ animated: Bool)
       {
           //Mark:- when going to BuySellVC it will make the tab bar inactive for the vc and active for other 
          if which_view == "BuySellVc"
          {
               self.tabBarController?.tabBar.isHidden = true
        }
          else
          {
             self.tabBarController?.tabBar.isHidden = false
        }
           
           
       } //Mark:- End of vieDisapear function
    
}
