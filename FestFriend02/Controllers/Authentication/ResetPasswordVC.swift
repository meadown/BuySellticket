//
//  ResetPasswordVC.swift
//  FestFriend02

//  Copyright © 2019 MySoftheaven BD. All rights reserved.
//

import UIKit

class ResetPasswordVC: UIViewController {
    
    @IBOutlet weak var txtEmail: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnSendAction(_ sender: UIButton) {
        
        view.endEditing(true)
        guard let email = txtEmail.text, !email.isEmpty, isValidEmail(email: email) else {
            showDialog(title: "Reset Password", message: "Please provide a valid email address!")
            return
        }
        
        let params = ["email": email] as! [String: AnyObject]
        showProgress(on: view)
        APICall.requestResetPassword(params: params) { (response) in
            
            self.dismissProgress(for: self.view)
            if let response = response {
                if response.status! {
                    self.showDialog(title: "Reset Password", message: "An email with instructions has been sent to your email address.")
                } else {
                    self.showDialog(title: "Reset Password", message: response.msg!)
                }
            } else {
                self.showDialog(title: "Reset Password", message: "Something happened, please try again letter")
            }
        }
    }

}
