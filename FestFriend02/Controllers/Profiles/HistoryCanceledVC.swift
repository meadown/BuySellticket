//
//  HistoryCanceledVC.swift
//  FestFriend02
//
//  Created by Kazi Abdullah Al Mamun on 6/2/19.
//  Copyright © 2019 MySoftheaven BD. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class HistoryCanceledVC: UIViewController, IndicatorInfoProvider {
    
    @IBOutlet weak var lblDateLabel: UILabel!
    @IBOutlet weak var lblAmountLabel: UILabel!
    
    @IBOutlet weak var tableview: UITableView!
    
    var isBuying = false
    var isCanceled = false
    
    var userBids: [UserBid]?
    var userAsks: [UserAsk]?

    override func viewDidLoad() {
        super.viewDidLoad()

        if isBuying {
            if isCanceled {
                lblDateLabel.text = "CANCELED DATE"
                lblAmountLabel.text = "BID AMNT"
            } else {
                lblDateLabel.text = "PURCHASE DATE"
                lblAmountLabel.text = "PRICE"
            }
        } else {
            if isCanceled {
                lblDateLabel.text = "CANCELED DATE"
                lblAmountLabel.text = "ASK AMNT"
            } else {
                lblDateLabel.text = "SOLD DATE"
                lblAmountLabel.text = "PRICE"
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        if isBuying {
            if isCanceled {
                return "Canceled"
            } else {
                return "Purchase History"
            }
        } else {
            if isCanceled {
                return "Canceled"
            } else {
                return "Sales History"
            }
        }
    }

}


extension HistoryCanceledVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isBuying {
            if userBids == nil || userBids!.count == 0 {
                return 0
            } else {
                return userBids!.count
            }
        } else {
            if userAsks == nil || userAsks!.count == 0 {
                return 0
            } else {
                return userAsks!.count
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "canceledCell", for: indexPath) as! CanceledTVC
        cell.isCanceled = isCanceled
        
        if isBuying {
            let bid = userBids![indexPath.row]
            cell.configureCell(with: bid)
        } else {
            let ask = userAsks![indexPath.row]
            cell.configureCell(with: ask)
        }
        
        return cell
    }
}
