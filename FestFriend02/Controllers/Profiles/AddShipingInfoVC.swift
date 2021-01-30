//
//  AddShipingInfoVC.swift
//  FestFriend02
//
//  Created by Kazi Abdullah Al Mamun on 3/2/19.
//  Copyright © 2019 MySoftheaven BD. All rights reserved.
//

import UIKit

class AddShipingInfoVC: UIViewController, StateListDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtStreet: UITextField!
    @IBOutlet weak var txtAptSuite: UITextField!
    @IBOutlet weak var txtCity: UITextField!
    @IBOutlet weak var txtZip: UITextField!
    @IBOutlet weak var txtNotes: UITextField!
    
    @IBOutlet weak var lblState: UILabel!
    
    @IBOutlet weak var stateContainer: UIView!
    
    var stateList: [State]?
    var selectedState: String?
    var addressToEdit: ShippingAddress1?
    var billingAddressToEdit: BillingAddress?
    var isBilling = false
    
    var vcTitle: String {
        get {
            if isBilling {
                return "Billing Info"
            } else {
                return "Shipping Info"
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        getAllStates()
        
        title = vcTitle
        self.navigationItem.backBarButtonItem?.title = ""

        
        let tap = UITapGestureRecognizer(target: self, action: #selector(stateContainerAction(_:)))
        stateContainer.addGestureRecognizer(tap)
        
        if let address = addressToEdit, !isBilling {
            txtName.text = address.name!
            txtStreet.text = address.streetAddress!
            txtCity.text = address.city!
            txtZip.text = address.zipPostalCode!
            
            if let notes = address.notes {
                txtNotes.text = notes
            }
            
            if let apt = address.aptSuiteUnit {
                txtAptSuite.text = apt
            }
            lblState.text = address.stateRegion!
            selectedState = address.stateRegion
        } else if let address = billingAddressToEdit, isBilling {
            txtName.text = address.name!
            txtStreet.text = address.streetAddress!
            txtCity.text = address.city!
            txtZip.text = address.zipPostalCode!
            
            if let notes = address.notes {
                txtNotes.text = notes
            }
            
            if let apt = address.aptSuiteUnit {
                txtAptSuite.text = apt
            }
            lblState.text = address.stateRegion!
            selectedState = address.stateRegion
        }
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier!.elementsEqual("toStateList") {
            let destVc = segue.destination as! StateListVC
            destVc.stateList = stateList!
            destVc.delegate = self
        }
    }
    
    @IBAction func submitBtnAction(_ sender: UIButton) {
        addAddressRequest()
    }
    
    @objc func stateContainerAction(_ sender: UITapGestureRecognizer) {
        if let stateList = stateList, stateList.count > 0 {
            performSegue(withIdentifier: "toStateList", sender: self)
        } else {
            showDialog(title: "States", message: "No state found")
        }
    }
    
    func stateChossed(index: Int) {
        let state = stateList![index]
        lblState.text = state.name!
        selectedState = state.name!
    }
    
    fileprivate func AlertAction(title : String , message : String) {
        let alert = UIAlertController(title: title, message: message , preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
             self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    private func addAddressRequest() {
        
        var param = [String: AnyObject]()
        param["user_id"] = LocalPersistance.getUserId() as? AnyObject
        param["country_id"] = 3 as? AnyObject
        
        guard let name = txtName.text, !name.isEmpty else {
            showDialog(title: "Add Address", message: "Please write your name for address")
            txtName.becomeFirstResponder()
            return
        }
        param["name"] = name as? AnyObject
        
        guard let street = txtStreet.text, !street.isEmpty else {
            showDialog(title: "Add Address", message: "Street address is required.")
            txtStreet.becomeFirstResponder()
            return
        }
        param["street_address"] = street as? AnyObject
        
        guard let city = txtCity.text, !city.isEmpty else {
            showDialog(title: "Add Address", message: "City is required")
            txtCity.becomeFirstResponder()
            return
        }
        param["city"] = city as? AnyObject
        
        guard let zip = txtZip.text, !zip.isEmpty else {
            showDialog(title: "Add Address", message: "Zip/Postal code is required")
            txtZip.becomeFirstResponder()
            return
        }
        param["zip_postal_code"] = zip as! AnyObject
        
        guard let state = self.selectedState else {
            showDialog(title: "Add Address", message: "Please chose a state")
            return
        }
        param["state_region"] = state as! AnyObject
        
        if let suite = txtAptSuite.text, !suite.isEmpty {
            param["apt_suite_unit"] = suite as! AnyObject
        }
        
        if let notes = txtNotes.text, !notes.isEmpty {
            param["notes"] = notes as! AnyObject
        }
        
        showProgress(on: view)
        
        if let address = addressToEdit {
            param["shipping_id"] = address.id! as! AnyObject
            APICall.editShipingBillingAddress(urlEnd: "edit-shipping-address",param: param) { (response) in
                self.dismissProgress(for: self.view)
                if let response = response {
                    if response.status! {
                        self.AlertAction(title: "Edit Address", message: "Address successfully edited.")
                    } else {
                        self.AlertAction(title: "Add Address", message: "Something went wrong.")
                    }
                }
            }
            
        } else if let address = billingAddressToEdit {
            param["shipping_id"] = address.id! as! AnyObject
            APICall.editShipingBillingAddress(urlEnd: "edit-billing-address",param: param) { (response) in
                self.dismissProgress(for: self.view)
                if let response = response {
                    if response.status! {
                        self.AlertAction(title: "Edit Address", message: "Address successfully edited.")
                    } else {
                        self.AlertAction(title: "Add Address", message: "Something went wrong.")
                    }
                }
            }
        } else {
            
            var urlEnd = ""
            
            if isBilling {
                urlEnd = "add-billing-address"
            } else {
                urlEnd = "add-shipping-address"
            }
            APICall.addShipingBillingAddress(urlEnd: urlEnd,param: param) { (response) in
                self.dismissProgress(for: self.view)
                if let response = response {
                    if response.status! {
                        self.AlertAction(title: "Add Address", message: "Address successfully edited.")

                    } else {
                        self.AlertAction(title: "Add Address", message: "Something went wrong.")
                    }
                }
            }
        }
    }
}
