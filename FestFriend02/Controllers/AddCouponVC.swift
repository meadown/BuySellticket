//
//  AddCouponVC.swift
//  FestFriend02
//  Copyright © 2019 MySoftheaven BD. All rights reserved.
//

import UIKit

class AddCouponVC: UIViewController {
    
    @IBOutlet weak var txtCouponCode: UITextField!
    @IBOutlet weak var lblStatus: UILabel!

    var delegate: CheckCouponCodeDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func btnAddAction(_ sender: UIButton) {
        
        guard let code = txtCouponCode.text, !code.isEmpty else {
            showDialog(title: "Add Coupon", message: "Please provide a coupon code!")
            return
        }
        
        let param = ["user_id": LocalPersistance.getUserId(),
                     "couponCode": code] as! [String: AnyObject]
        
        showProgress(on: view)
        
        APICall.checkCoupon(param: param) { (response) in
            self.dismissProgress(for: self.view)
            
            if let response = response {
                if response.status! {
                    if let amount = response.amount, !amount.isEmpty {
                        let amountDouble = Double(amount)
                        self.delegate.validCouponCode(amount: amountDouble!)
                    } else {
                        self.delegate.validCouponCode(amount: 0.0)
                    }
                    self.dismiss(animated: true)
                } else {
                    self.lblStatus.text = "Invalid Coupon Code!"
                }
            } else {
                self.lblStatus.text = "Invalid Coupon Code!"
            }
        }
        
    }
    
    @IBAction func btnCancelAction(_ sender: UIButton) {
        dismiss(animated: true)
    }

}
