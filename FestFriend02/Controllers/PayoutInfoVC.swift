//
//  PayoutInfoVC.swift
//  FestFriend02
//  Copyright © 2019 MySoftheaven BD. All rights reserved.
//

import UIKit

class PayoutInfoVC: UIViewController {
    
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtAccountName: UITextField!
    @IBOutlet weak var txtRoutingNumber: UITextField!
    @IBOutlet weak var txtAccountNumber: UITextField!
    @IBOutlet weak var txtConfirmAccountNumber: UITextField!
    
    
    @IBOutlet weak var btnBankAccount: UIButton!
    @IBOutlet weak var btnSavings: UIButton!
    @IBOutlet weak var btnCheckings: UIButton!
    @IBOutlet weak var btnCheckTermsAndCondition: CheckboxButton!
    
    @IBOutlet weak var bankTypeContainer: UIView!
    @IBOutlet weak var accountTypeContainer: UIView!
    @IBOutlet weak var bankAccountInfoContainer: UIView!
    
    var payout: Payout?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        
        if let info = payout {
            populateViews(info: info)
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    

    
    private func setupViews() {
        
        bankTypeContainer.layer.borderWidth = 1
        bankTypeContainer.layer.borderColor = UIColor.gray.cgColor
        
        accountTypeContainer.layer.borderWidth = 1
        accountTypeContainer.layer.borderColor = UIColor.appBlueColor.cgColor
        
        bankAccountBtnSelectedState()
        savingsBtnSelectedState()
    }
    
    private func populateViews(info: Payout) {
        
        if let fName = info.bankFirstName {
            txtFirstName.text = fName
        }
        
        if let lName = info.bankLastName {
            txtLastName.text = lName
        }
        
        if let accName = info.bankAccountName {
            txtAccountName.text = accName
        }
        
        if let routingNum = info.bankRoutingNumber {
            txtRoutingNumber.text = routingNum
        }
        
        if let accNum = info.bankAccountNumber {
            txtAccountNumber.text = accNum
            txtConfirmAccountNumber.text = accNum
        }
        
    }
    
    


    private func bankAccountBtnSelectedState() {
        btnBankAccount.backgroundColor = UIColor.appRedColor
        btnBankAccount.tintColor = UIColor.white
        btnBankAccount.setTitleColor(UIColor.white, for: .normal)
       
    }
    
    private func bankAccountBtnDeselectedState() {
        btnBankAccount.backgroundColor = UIColor.white
        btnBankAccount.tintColor = UIColor.black
        btnBankAccount.setTitleColor(UIColor.black, for: .normal)
    }
    
  

    private func savingsBtnSelectedState() {
        btnSavings.backgroundColor = UIColor.appBlueColor
        btnSavings.tintColor = UIColor.white
        btnSavings.setTitleColor(UIColor.white, for: .normal)
       
    }
    
    private func savingsBtnDeselectedState() {
        btnSavings.backgroundColor = UIColor.white
        btnSavings.tintColor = UIColor.black
        btnSavings.setTitleColor(UIColor.black, for: .normal)
    }
    
    private func checkingBtnSelectedState() {
        btnCheckings.backgroundColor = UIColor.appBlueColor
        btnCheckings.tintColor = UIColor.white
        btnCheckings.setTitleColor(UIColor.white, for: .normal)
        
    }
    
    private func checkingBtnDeselectedState() {
        btnCheckings.backgroundColor = UIColor.white
        btnCheckings.tintColor = UIColor.black
        btnCheckings.setTitleColor(UIColor.black, for: .normal)
    }
    

   
   

    @IBAction func btnBankAccountAction(_ sender: UIButton) {
        bankAccountBtnSelectedState()
        bankAccountInfoContainer.isHidden = false
    }
    

    
    @IBAction func btnSavingsAction(_ sender: UIButton) {
        savingsBtnSelectedState()
        checkingBtnDeselectedState()
        
    }
    @IBAction func btnCheckingsAction(_ sender: Any) {
        checkingBtnSelectedState()
        savingsBtnDeselectedState()
    }
    
    @IBAction func btnSaveAction() {

        var param: [String: AnyObject] = ["user_id": LocalPersistance.getUserId() as! AnyObject]
        var innerObj = [String: AnyObject]()
        
        guard let fName = txtFirstName.text, !fName.isEmpty else {
            showDialog(title: "", message: "First name is required.")
            return
        }
        innerObj["bank_first_name"] = fName as! AnyObject
        
        guard let lName = txtLastName.text, !lName.isEmpty else {
            showDialog(title: "", message: "Last name is required.")
            return
        }
        innerObj["bank_last_name"] = lName as! AnyObject
        
        guard let accName = txtAccountName.text, !accName.isEmpty else {
            showDialog(title: "", message: "Account name is required.")
            return
        }
        innerObj["bank_account_name"] = accName as! AnyObject
        
        guard let routingNum = txtRoutingNumber.text, !routingNum.isEmpty else {
            showDialog(title: "", message: "Routing number is required.")
            return
        }
        innerObj["bank_routing_number"] = routingNum as! AnyObject
        
        guard let accNum = txtAccountNumber.text, !accNum.isEmpty else {
            showDialog(title: "", message: "Account number is required.")
            return
        }
        innerObj["bank_account_number"] = accNum as! AnyObject
        
        guard let reAccNum = txtConfirmAccountNumber.text, !reAccNum.isEmpty else {
            showDialog(title: "", message: "Please confirm Account number")
            return
        }
        
        if !accNum.elementsEqual(reAccNum) {
            showDialog(title: "", message: "Account numbers do not match.")
            return
        }
        
        if btnCheckTermsAndCondition.isChecked {
            showProgress(on: self.view)

            param["bank_account_info"] = innerObj as! AnyObject
            APICall.addPayoutInfo(param: param) { (response) in
                if let response = response {
                  //  self.dismissProgress(for: self.view)
                    if response.status! {
                        print("Successfully Edited")
                    }
                }
                self.dismissProgress(for: self.view)
                let alert = UIAlertController(title: "", message: "Successfully Edited", preferredStyle: .alert)

               // alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))

                self.present(alert, animated: true)
            }
        } else {
            showDialog(title: "", message: "Please agree to the Terms and Conditions.")
        }
        
        
    }
}
