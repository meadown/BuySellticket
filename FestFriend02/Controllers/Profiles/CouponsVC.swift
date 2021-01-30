//
//  CouponsVC.swift
//  FestFriend02
//
//  Created by Kazi Abdullah Al Mamun on 3/2/19.
//  Copyright © 2019 MySoftheaven BD. All rights reserved.
//

import UIKit

class CouponsVC: UITableViewController {
    
    
    var coupons = [Coupon]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getCoupons()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return coupons.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CouponTVC.self), for: indexPath) as! CouponTVC
        cell.configureCell(with: coupons[indexPath.row])
        return cell
    }

    private func getCoupons() {
        showProgress(on: view)
        
        APICall.getUserCoupons { (response) in
            self.dismissProgress(for: self.view)
            if let response = response {
                if response.status! {
                    if let coupons = response.coupons {
                        self.coupons = coupons
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }

}
