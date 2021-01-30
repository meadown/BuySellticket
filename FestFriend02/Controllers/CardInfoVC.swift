//
//  CardInfoVC.swift
//  FestFriend02
//
//  Created by brotherhood on 27/2/19.
//  Copyright © 2019 MySoftheaven BD. All rights reserved.
//

import UIKit

class CardInfoVC: UIViewController , StateListDelegate{

    @IBOutlet weak var shipToMyBillingContainer: UIView!
    @IBOutlet weak var shipToMyBillingSwitch: UISwitch!
    @IBOutlet weak var shipToMyBillingContainerBottomConstant: NSLayoutConstraint!
    
    //billing address
    @IBOutlet weak var billingName: SkyFloatingLabelTextField!
    @IBOutlet weak var billingAddress: SkyFloatingLabelTextField!
    @IBOutlet weak var billingAddressTwo: SkyFloatingLabelTextField!
    @IBOutlet weak var billingCity: SkyFloatingLabelTextField!
    @IBOutlet weak var billingState: SkyFloatingLabelTextField!
    @IBOutlet weak var billingZip: SkyFloatingLabelTextField!
    @IBOutlet weak var billingNote: SkyFloatingLabelTextField!
    
    
    //shipping address
    
    @IBOutlet weak var shippingName: SkyFloatingLabelTextField!
    @IBOutlet weak var shippingAddress: SkyFloatingLabelTextField!
    @IBOutlet weak var shippingAddressTwo: SkyFloatingLabelTextField!
    @IBOutlet weak var shippingCity: SkyFloatingLabelTextField!
    @IBOutlet weak var shippingState: SkyFloatingLabelTextField!
    @IBOutlet weak var shippingZip: SkyFloatingLabelTextField!
    @IBOutlet weak var shippingNote: SkyFloatingLabelTextField!
    
    @IBOutlet weak var lblState: UILabel!
    @IBOutlet weak var shippinglblState: UILabel!
    
    @IBOutlet weak var stateContainer: UIView!
    @IBOutlet weak var shippingStateContainer: UIView!
    
    
    var stateList: [State]?
    var selectedState: String?
    var billingStateAction: String?
    var shippingStateAction: String?
    
    var shippigAdrressId : Int?
    var billingAddressId : Int?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        shipToMyBillingSwitch.isOn = false
        let tap = UITapGestureRecognizer(target: self, action: #selector(billingstateContainerAction(_:)))
        stateContainer.addGestureRecognizer(tap)
        let tapTwo = UITapGestureRecognizer(target: self, action: #selector(shippingstateContainerAction(_:)))
        shippingStateContainer.addGestureRecognizer(tapTwo)
        getAllStates()
        getBillingAddress()
        getShipingAddress()

    }
    
   
    private func getAllStates() {
        APICall.getAllStates { (response) in
            if let response = response {
                if let stateList = response.allStateList, stateList.count > 0 {
                    self.stateList = stateList
                }
            }
        }
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier!.elementsEqual("toStateList") {
            let destVc = segue.destination as! StateListVC
            destVc.stateList = stateList!
            destVc.delegate = self
        }
    }
    
    @objc func billingstateContainerAction(_ sender: UITapGestureRecognizer) {
        self.billingStateAction = "billingState"
        if let stateList = stateList, stateList.count > 0 {
            performSegue(withIdentifier: "toStateList", sender: self)
        } else {
            showDialog(title: "States", message: "No state found")
        }
    }
    @objc func shippingstateContainerAction(_ sender: UITapGestureRecognizer) {
        self.shippingStateAction = "shippingState"
        if let stateList = stateList, stateList.count > 0 {
            performSegue(withIdentifier: "toStateList", sender: self)
        } else {
            showDialog(title: "States", message: "No state found")
        }
    }
    
    func stateChossed(index: Int) {
        let state = stateList![index]
        if self.billingStateAction == "billingState" {
            lblState.text = state.name!
            selectedState = state.name!
            
        } else if self.shippingStateAction == "shippingState" {
            shippinglblState.text = state.name!
            selectedState = state.name!
        }
    }
    
    @IBAction func shipToMyBillingSwitchAction(_ sender: Any) {
        if shipToMyBillingSwitch.isOn {
            shipToMyBillingContainer.isHidden = true
            //shipToMyBillingContainerBottomConstant.constant = -300
        }else{
            shipToMyBillingContainer.isHidden = false
//            shipToMyBillingContainerBottomConstant.constant = 50
        }
    }
    
    
    
    
    
    //billing Addresss
    private func getBillingAddress() {
        showProgress(on: view)
        APICall.getBillingAddress { (response) in
            self.dismissProgress(for: self.view)
            if let response = response {
                if response.status! {
                    if let address = response.getActiveBillingAddress() {
                       
                        self.billingAddress.text = address.streetAddress
                        self.billingAddressTwo.text = address.aptSuiteUnit
                        self.billingName.text = address.name
                        self.lblState.text = address.stateRegion!
                        self.billingCity.text = address.city
                        self.billingZip.text = address.zipPostalCode
                        self.billingNote.text = address.notes
                        self.billingAddressId = address.id
                        self.selectedState = address.stateRegion

                    } else {
                       
                    }
                    
                } else {
                   
                }
            } else {
                
            }
        }
    }
    
    private func getShipingAddress() {
        showProgress(on: view)
        APICall.getShipingAddresses { (response) in
            self.dismissProgress(for: self.view)
            if let response = response {
                if response.status! {
                    if let address = response.getActiveShipingAddress() {
                        
                        self.shippingAddress.text = address.streetAddress
                        self.shippingAddressTwo.text = address.aptSuiteUnit
                        self.shippingName.text = address.name
                        self.shippinglblState.text = address.stateRegion
                        self.shippingCity.text = address.city
                        self.shippingZip.text = address.zipPostalCode
                        self.shippingNote.text = address.notes
                        self.shippigAdrressId  = address.id
                        self.selectedState = address.stateRegion

                    } else {
                       
                    }
                    
                } else {
                    
                }
            } else {
                
            }
        }
    }
    
    
   
    @IBAction func submitButtonAction(_ sender: Any) {
      //  self.EditBillingAddress()
        self.EditShippingAddress()
    
    }
    private func EditShippingAddress()
    {
        var param = [String: AnyObject]()
               param["user_id"] = LocalPersistance.getUserId() as? AnyObject
               param["country_id"] = 3 as? AnyObject
        
        
        guard let billingNa = shippingName.text, !billingNa.isEmpty else {
                   showDialog(title: "Add Address", message: "Please write your name for address")
                   billingName.becomeFirstResponder()
                   return
               }
               param["name"] = billingNa as? AnyObject
               
               guard let billstreet = shippingAddress.text, !billstreet.isEmpty else {
                   showDialog(title: "Add Address", message: "Street address is required.")
                   billingAddress.becomeFirstResponder()
                   return
               }
               param["street_address"] = billstreet as? AnyObject
               
               guard let billcity = shippingCity.text, !billcity.isEmpty else {
                   showDialog(title: "Add Address", message: "City is required")
                   billingCity.becomeFirstResponder()
                   return
               }
               param["city"] = billcity as? AnyObject
               
               guard let billzip = shippingZip.text, !billzip.isEmpty else {
                   showDialog(title: "Add Address", message: "Zip/Postal code is required")
                   billingZip.becomeFirstResponder()
                   return
               }
               param["zip_postal_code"] = billzip as! AnyObject
               
               guard let state = self.selectedState else {
                   showDialog(title: "Add Address", message: "Please chose a state")
                   return
               }
               param["state_region"] = state as! AnyObject
           
               if let billsuite = shippingAddressTwo.text, !billsuite.isEmpty {
                   param["apt_suite_unit"] = billsuite as! AnyObject
               }
               
               if let billnotes = shippingNote.text, !billnotes.isEmpty {
                   param["notes"] = billnotes as! AnyObject
               }
               
               showProgress(on: view)
        
        if shippigAdrressId != nil
            //MArk:- edit shipping field if all field is not empty in shiiping field.
        {
        param["shipping_id"] = shippigAdrressId as! AnyObject
        APICall.editShipingBillingAddress(urlEnd: "edit-shipping-address",param: param) { (response) in
                       self.dismissProgress(for: self.view)
                       if let response = response {
                           if response.status! {
                               self.showDialog(title: "Edit Address", message: "Address successfully edited.")
                           } else {
                               self.showDialog(title: "Add Address", message: "Something went wrong.")
                           }
                       }
                   }
        }
        else
            //Mark:- add Shiping Address if all shipping field is empty
        {
            APICall.addShipingBillingAddress(urlEnd: "add-shipping-address",param: param) { (response) in
                                  self.dismissProgress(for: self.view)
                                  if let response = response {
                                      if response.status! {
                                          self.showDialog(title: "Edit Address", message: "Address successfully edited.")
                                      } else {
                                          self.showDialog(title: "Add Address", message: "Something went wrong.")
                                      }
                                  }
                              }
            
        }
    }
    
    private func EditBillingAddress() {
        
        var param = [String: AnyObject]()
        param["user_id"] = LocalPersistance.getUserId() as? AnyObject
        param["country_id"] = 3 as? AnyObject
        
        guard let billingNa = billingName.text, !billingNa.isEmpty else {
            showDialog(title: "Add Address", message: "Please write your name for address")
            billingName.becomeFirstResponder()
            return
        }
        param["name"] = billingNa as? AnyObject
        
        guard let billstreet = billingAddress.text, !billstreet.isEmpty else {
            showDialog(title: "Add Address", message: "Street address is required.")
            billingAddress.becomeFirstResponder()
            return
        }
        param["street_address"] = billstreet as? AnyObject
        
        guard let billcity = billingCity.text, !billcity.isEmpty else {
            showDialog(title: "Add Address", message: "City is required")
            billingCity.becomeFirstResponder()
            return
        }
        param["city"] = billcity as? AnyObject
        
        guard let billzip = billingZip.text, !billzip.isEmpty else {
            showDialog(title: "Add Address", message: "Zip/Postal code is required")
            billingZip.becomeFirstResponder()
            return
        }
        param["zip_postal_code"] = billzip as! AnyObject
        
        guard let state = self.selectedState else {
            showDialog(title: "Add Address", message: "Please chose a state")
            return
        }
        param["state_region"] = state as! AnyObject
    
        if let billsuite = billingAddressTwo.text, !billsuite.isEmpty {
            param["apt_suite_unit"] = billsuite as! AnyObject
        }
        
        if let billnotes = billingNote.text, !billnotes.isEmpty {
            param["notes"] = billnotes as! AnyObject
        }
        
        showProgress(on: view)
        
        param["shipping_id"] = billingAddressId as! AnyObject
           APICall.editShipingBillingAddress(urlEnd: "edit-billing-address",param: param) { (response) in
               self.dismissProgress(for: self.view)
                        if let response = response {
                            if response.status! {
                                self.showDialog(title: "Edit Address", message: "Address successfully edited.")
                            } else {
                                self.showDialog(title: "Add Address", message: "Something went wrong.")
                            }
                        }
                    }
              }
    


}
