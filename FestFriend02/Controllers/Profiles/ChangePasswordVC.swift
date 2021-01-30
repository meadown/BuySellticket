//
//  ChangePasswordVC.swift
//  FestFriend02
//
//  Created by Kazi Abdullah Al Mamun on 3/2/19.
//  Copyright © 2019 MySoftheaven BD. All rights reserved.
//

import UIKit

class ChangePasswordVC: UIViewController {
    
    @IBOutlet weak var txtCurrentPass: UITextField!
    @IBOutlet weak var txtNewPass: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        txtCurrentPass.layer.borderWidth = 1.0
        txtCurrentPass.layer.borderColor = #colorLiteral(red: 0.6117647059, green: 0.6117647059, blue: 0.6117647059, alpha: 1)
        txtCurrentPass.layer.cornerRadius = 5.0
        txtCurrentPass.setLeftPaddingPoints(5)
        txtNewPass.layer.borderWidth = 1.0
        txtNewPass.layer.borderColor = #colorLiteral(red: 0.6117647059, green: 0.6117647059, blue: 0.6117647059, alpha: 1)
        txtNewPass.layer.cornerRadius = 5.0
        txtCurrentPass.placeholderColor(color: #colorLiteral(red: 0.6195452213, green: 0.6196519136, blue: 0.619531095, alpha: 1))
        txtNewPass.placeholderColor(color: #colorLiteral(red: 0.6195452213, green: 0.6196519136, blue: 0.619531095, alpha: 1))
        txtNewPass.setLeftPaddingPoints(5)


        // Do any additional setup after loading the view.
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func btnChangePassTapped(_ sender: UIButton) {
        view.endEditing(true)
        
        var param = [String: AnyObject]()
        param["user_id"] = LocalPersistance.getUserId() as! AnyObject
        
        guard let currentPass = txtCurrentPass.text, !currentPass.isEmpty else {
            showDialog(title: "Change Password", message: "Please provide current password, which you use to log in.")
            txtCurrentPass.becomeFirstResponder()
            return
        }
        param["current_password"] = currentPass as! AnyObject
        
        guard let newPass = txtNewPass.text, !newPass.isEmpty else {
            showDialog(title: "Change Password", message: "Please provide your new password.")
            return
        }
        param["new_password"] = newPass as! AnyObject
        param["confirm_password"] = newPass as! AnyObject
        
        showProgress(on: view)
        APICall.changePassword(params: param) { (response) in
            self.dismissProgress(for: self.view)
            if let response = response {
                if response.status! {
                    let alert = UIAlertController(title: "Change Password", message: "Password has been successfully changed.", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "Ok", style: .default, handler: { (action) in
                        LocalPersistance.clearUserDetails()
                        self.navigationController?.popToRootViewController(animated: true)
                    })
                    alert.addAction(okAction)
                    self.present(alert, animated: true)
                } else {
                    self.showDialog(title: "Change Password", message: "Password change failed.")
                }
            } else {
                self.showDialog(title: "Change Password", message: "Password change failed.")
            }
        }
    }

}
extension UITextField {
    func placeholderColor(color: UIColor) {
        let attributeString = [
            NSAttributedStringKey.foregroundColor: color.withAlphaComponent(0.6),
            NSAttributedStringKey.font: self.font!
            ] as [NSAttributedStringKey : Any]
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder!, attributes: attributeString)
    }
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}
