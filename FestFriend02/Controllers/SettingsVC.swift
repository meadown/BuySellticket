//
//  SettingsVC.swift
//  FestFriend02
//  Copyright © 2019 MySoftheaven BD. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController {
    
    @IBOutlet weak var biddingNewLowestAskContainer: ExpandableView!
    @IBOutlet weak var biddingNewLowestAskSubContainer: UIStackView!
    @IBOutlet weak var biddingNewHighestBidContainer: ExpandableView!
    @IBOutlet weak var biddingNewHighestBidSubContainer: UIStackView!
    @IBOutlet weak var bidAcceptedContainer: ExpandableView!
    @IBOutlet weak var bidAcceptedSubContainer: UIStackView!
    @IBOutlet weak var followingNewLowestAskContainer: ExpandableView!
    @IBOutlet weak var followingNewLowestAskSubContainer: UIStackView!
    @IBOutlet weak var askingNewHighestBidContainer: ExpandableView!
    @IBOutlet weak var askingNewHighestBidSubContainer: UIStackView!
    @IBOutlet weak var askingNewLowestAskContainer: ExpandableView!
    @IBOutlet weak var askingNewLowestAskSubContainer: UIStackView!
    @IBOutlet weak var itemSoldContainer: ExpandableView!
    @IBOutlet weak var itemSoldSubContainer: UIStackView!
    
    @IBOutlet weak var lblPayout: UILabel!
    @IBOutlet weak var lblBillingAddress: UILabel!
    @IBOutlet weak var lblShipingAddress: UILabel!
    @IBOutlet weak var lblBuyingPayment: UILabel!
    @IBOutlet weak var lblSellingPayment: UILabel!
    
    
    @IBOutlet weak var lblSellingAddress: UILabel!
    
    @IBOutlet weak var biddingNewLowesAskEmailSwitch: UISwitch!
    @IBOutlet weak var biddingNewLowesAskPushSwitch: UISwitch!
    @IBOutlet weak var biddingNewHighestBidEmailSwitch: UISwitch!
    @IBOutlet weak var biddingNewHighestBidPushSwitch: UISwitch!
    @IBOutlet weak var bidAcceptedEmailSwitch: UISwitch!
    @IBOutlet weak var bidAcceptedPushSwitch: UISwitch!
    @IBOutlet weak var followingNewLowestAskEmailSwitch: UISwitch!
    @IBOutlet weak var followingNewLowestAskPushSwitch: UISwitch!
    @IBOutlet weak var askingNewHighestBidEmailSwitch: UISwitch!
    @IBOutlet weak var askingNewHighestBidPushSwitch: UISwitch!
    @IBOutlet weak var askingNewLowestAskEmailSwitch: UISwitch!
    @IBOutlet weak var askingNewLowestAskPushSwitch: UISwitch!
    @IBOutlet weak var itemSoldEmailSwitch: UISwitch!
    @IBOutlet weak var itemSoldPushSwitch: UISwitch!
    
    @IBOutlet weak var btnEditShipingAddress: UIButton!
    @IBOutlet weak var btnEditBillingAddress: UIButton!
    @IBOutlet weak var btnEditPayout: UIButton!
    @IBOutlet weak var btnEditBuyingPayment: UIButton!
    @IBOutlet weak var btnEditSellingPayment: UIButton!
    
    
    let notiStatusValue = ["bid_new_low_ask",
                           "push_bid_new_low_ask",
                           "bid_new_high_bid",
                           "push_bid_new_high_bid",
                           "bid_accepted",
                           "push_bid_accepted",
                           "fol_new_low_ask",
                           "push_fol_new_low_ask",
                           "ask_new_high_bid",
                           "push_ask_new_high_bid",
                           "ask_new_low_ask",
                           "push_ask_new_low_ask",
                           "ask_item_sold",
                           "push_ask_item_sold"]
    
    var billingAddress: BillingAddress?
    var shipingAddress: ShippingAddress1?
    var payout: Payout?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBarBtns()
        viewsGestures()
        getNotificationStatus()
        payoutlbldefaultString()
        getShipingAddress()
        getBillingAddress()
        getPayout()
        
         
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupBarBtns()
        viewsGestures()
        getNotificationStatus()
        payoutlbldefaultString()
        getShipingAddress()
        getBillingAddress()
        getPayout()
       
    }
    
   func payoutlbldefaultString()
   {
    
            lblBuyingPayment.text = "FestFriends is currently not saving user card data"
        
   
            lblSellingPayment.text = "FestFriends is currently not saving user card data"
        
    }
    
    private func viewsGestures() {
        let biddingNewLowestAskSubContainerTapGesture = UITapGestureRecognizer(target: self, action: #selector(biddingNewLowestAskSubContainerAction(_:)))
        biddingNewLowestAskSubContainer.addGestureRecognizer(biddingNewLowestAskSubContainerTapGesture)
        
        let biddingNewHighestBidSubContainerTapGesture = UITapGestureRecognizer(target: self, action: #selector(biddingNewHighestBidSubContainerAction(_:)))
        biddingNewHighestBidSubContainer.addGestureRecognizer(biddingNewHighestBidSubContainerTapGesture)
        
        let bidAcceptedSubContainerTapGesture = UITapGestureRecognizer(target: self, action: #selector(bidAcceptedSubContainerAction(_:)))
        bidAcceptedSubContainer.addGestureRecognizer(bidAcceptedSubContainerTapGesture)
        
        let followingNewLowestAskSubContainerTapGesture = UITapGestureRecognizer(target: self, action: #selector(followingNewLowestAskSubContainerAction(_:)))
        followingNewLowestAskSubContainer.addGestureRecognizer(followingNewLowestAskSubContainerTapGesture)
        
        let askingNewHighestBidSubContainerTapGesture = UITapGestureRecognizer(target: self, action: #selector(askingNewHighestBidSubContainerAction(_:)))
        askingNewHighestBidSubContainer.addGestureRecognizer(askingNewHighestBidSubContainerTapGesture)
        
        let askingNewLowestAskSubContainerTapGesture = UITapGestureRecognizer(target: self, action: #selector(askingNewLowestAskSubContainerAction(_:)))
        askingNewLowestAskSubContainer.addGestureRecognizer(askingNewLowestAskSubContainerTapGesture)
        
        let itemSoldSubContainerTapGesture = UITapGestureRecognizer(target: self, action: #selector(itemSoldSubContainerAction(_:)))
        itemSoldSubContainer.addGestureRecognizer(itemSoldSubContainerTapGesture)
    }
    
    private func setupBarBtns() {
        
        let signoutBtn = UIBarButtonItem(title: "Sign Out", style: .plain, target: self, action: #selector(barBtnSignupAction(_:)))
        signoutBtn.tintColor = #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)
        navigationItem.leftBarButtonItem = signoutBtn
        
        let doneBtn = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(barBtnDoneAction(_:)))
        doneBtn.tintColor = #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)
        navigationItem.rightBarButtonItem = doneBtn
        
    }
   
    
    private func getPayout() {
         showProgress(on: view)
        APICall.getUserPayout { (response) in
            self.dismissProgress(for: self.view)

            if let response = response {
                if let payout = response.payout {
                    self.payout = payout
                    if let paypalAccountNumber = payout.bankAccountNumber  {
                        self.lblPayout.text = "\(payout.bankAccountName ?? "")\n\(payout.getFormatedAccountNumber())"
                        self.btnEditSellingPayment.isHidden = true
                    } else {
                        self.lblPayout.text = "Add Payout Method"
                        //self.lblSellingPayment.text = "Add Payout Method"
                        self.btnEditSellingPayment.isHidden = true
                    }
                    
                    if payout.cardNumber != nil {
                        //self.lblBuyingPayment.text = payout.getFormatedCardNumber()
                       // self.lblSellingPayment.text = payout.getFormatedCardNumber()
                        //self.lblBuyingPayment.text = "FestFriends is currently not saving user card data"
                        //self.lblSellingPayment.text = "FestFriends is currently not saving user card data"
                        self.btnEditBuyingPayment.isHidden = true
                        
                    } else {
                       // self.lblBuyingPayment.text = "Add Payout Method"
                        self.btnEditBuyingPayment.isHidden = true
                    }
                } else {
                    self.lblPayout.text = "Add Payout Method"
                    //self.lblSellingPayment.text = "Add Payment Method"
                   // self.lblBuyingPayment.text = "Add Payment Method"
                    self.btnEditBuyingPayment.isHidden = true
                    self.btnEditSellingPayment.isHidden = true
                    self.btnEditBuyingPayment.isHidden = true
                    self.payout = nil
                }
            } else {
                self.lblPayout.text = "Add Payout Method"
                //self.lblSellingPayment.text = "Add Payment Method"
                //self.lblBuyingPayment.text = "Add Payment Method"
                self.btnEditSellingPayment.isHidden = true
                self.btnEditBuyingPayment.isHidden = true
                self.payout = nil
            }
        }
    }
    
    private func getBillingAddress() {
         showProgress(on: view)
        APICall.getBillingAddress { (response) in
            self.dismissProgress(for: self.view)

            if let response = response {
                if response.status! {
                    if let address = response.getActiveBillingAddress() {
                        self.lblBillingAddress.text = address.formatedAddress()
                        self.lblSellingAddress.text = address.formatedAddress()
                        self.billingAddress = address
                        self.btnEditBillingAddress.isHidden = true
                    } else {
                        self.lblBillingAddress.text = "Add Billing Address"
                        self.btnEditBillingAddress.isHidden = true
                        self.billingAddress = nil
                    }
                    
                } else {
                    self.lblBillingAddress.text = "Add Billing Address"
                    self.btnEditBillingAddress.isHidden = true
                    self.billingAddress = nil
                }
            } else {
                self.lblBillingAddress.text = "Add Billing Address"
                self.btnEditBillingAddress.isHidden = true
                self.billingAddress = nil
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
                        self.lblShipingAddress.text = address.getFormatedAddress()
                        self.shipingAddress = address
                        self.btnEditShipingAddress.isHidden = true
                    } else {
                        self.lblShipingAddress.text = "Add Shipping Address"
                        self.btnEditShipingAddress.isHidden = true
                        self.shipingAddress = nil
                    }
                    
                } else {
                    self.lblShipingAddress.text = "Add Shipping Address"
                    self.btnEditShipingAddress.isHidden = true
                    self.shipingAddress = nil
                }
            } else {
                self.lblShipingAddress.text = "Add Shipping Address"
                self.btnEditShipingAddress.isHidden = true
                self.shipingAddress = nil
            }
        }
    }
    
    private func getNotificationStatus() {
         showProgress(on: view)
        APICall.getNotoficationStatus { (response) in
            self.dismissProgress(for: self.view)

            if let response = response {
                if response.status! {
                    if let allNotificationState = response.allNotificationList {
                        self.updateNotiStatusSwitch(status: allNotificationState)
                    }
                }
            }
        }
    }
    
    private func updateNotiStatusSwitch(status: AllNotificationList) {
        
        if let biddingNewLowestAsk = status.bidNewLowAsk, !biddingNewLowestAsk.isEmpty {
            if biddingNewLowestAsk.elementsEqual("1") {
                biddingNewLowesAskEmailSwitch.isOn = true
            } else {
                biddingNewLowesAskEmailSwitch.isOn = false
            }
        }  else {
            biddingNewLowesAskEmailSwitch.isOn = false
        }
        
        if let biddingNewLowestAskPush = status.pushBidNewLowAsk, !biddingNewLowestAskPush.isEmpty {
            if biddingNewLowestAskPush.elementsEqual("1") {
                biddingNewLowesAskPushSwitch.isOn = true
            } else {
                biddingNewLowesAskPushSwitch.isOn = false
            }
        }  else {
            biddingNewLowesAskPushSwitch.isOn = false
        }
        
        if let biddingNewHighestBid = status.bidNewHighBid, !biddingNewHighestBid.isEmpty {
            if biddingNewHighestBid.elementsEqual("1") {
                biddingNewHighestBidEmailSwitch.isOn = true
            } else {
                biddingNewHighestBidEmailSwitch.isOn = false
            }
        }  else {
            biddingNewHighestBidEmailSwitch.isOn = false
        }
        
        if let biddingNewHighestBidPush = status.pushBidNewHighBid, !biddingNewHighestBidPush.isEmpty {
            if biddingNewHighestBidPush.elementsEqual("1") {
                biddingNewHighestBidPushSwitch.isOn = true
            } else {
                biddingNewHighestBidPushSwitch.isOn = false
            }
        }  else {
            biddingNewHighestBidPushSwitch.isOn = false
        }
        
        if let bidAccepted = status.bidAccepted, !bidAccepted.isEmpty {
            if bidAccepted.elementsEqual("1") {
                bidAcceptedEmailSwitch.isOn = true
            } else {
                bidAcceptedEmailSwitch.isOn = false
            }
        }  else {
            bidAcceptedEmailSwitch.isOn = false
        }
        
        if let bidAcceptedPush = status.pushBidAccepted, !bidAcceptedPush.isEmpty {
            if bidAcceptedPush.elementsEqual("1") {
                bidAcceptedPushSwitch.isOn = true
            } else {
                bidAcceptedPushSwitch.isOn = false
            }
        }  else {
            bidAcceptedPushSwitch.isOn = false
        }
        
        if let followNewLowestAsk = status.folNewLowAsk, !followNewLowestAsk.isEmpty {
            if followNewLowestAsk.elementsEqual("1") {
                followingNewLowestAskEmailSwitch.isOn = true
            } else {
                followingNewLowestAskEmailSwitch.isOn = false
            }
        }  else {
            followingNewLowestAskEmailSwitch.isOn = false
        }
        
        if let followNewLowestAskPush = status.pushFolNewLowAsk, !followNewLowestAskPush.isEmpty {
            if followNewLowestAskPush.elementsEqual("1") {
                followingNewLowestAskPushSwitch.isOn = true
            } else {
                followingNewLowestAskPushSwitch.isOn = false
            }
        }  else {
            followingNewLowestAskPushSwitch.isOn = false
        }
        
        if let askingNewHighestBid = status.askNewHighBid, !askingNewHighestBid.isEmpty {
            if askingNewHighestBid.elementsEqual("1") {
                askingNewHighestBidEmailSwitch.isOn = true
            } else {
                askingNewHighestBidEmailSwitch.isOn = false
            }
        }  else {
            askingNewHighestBidEmailSwitch.isOn = false
        }
        
        if let askingNewHighestBidPush = status.pushAskNewHighBid, !askingNewHighestBidPush.isEmpty {
            if askingNewHighestBidPush.elementsEqual("1") {
                askingNewHighestBidPushSwitch.isOn = true
            } else {
                askingNewHighestBidPushSwitch.isOn = false
            }
        }  else {
            askingNewHighestBidPushSwitch.isOn = false
        }
        
        if let askingNewLowestAsk = status.askNewLowAsk, !askingNewLowestAsk.isEmpty {
            if askingNewLowestAsk.elementsEqual("1") {
                askingNewLowestAskEmailSwitch.isOn = true
            } else {
                askingNewLowestAskEmailSwitch.isOn = false
            }
        }  else {
            askingNewLowestAskEmailSwitch.isOn = false
        }
        
        if let askingNewLowestAskPush = status.pushAskNewLowAsk, !askingNewLowestAskPush.isEmpty {
            if askingNewLowestAskPush.elementsEqual("1") {
                askingNewLowestAskPushSwitch.isOn = true
            } else {
                askingNewLowestAskPushSwitch.isOn = false
            }
        }  else {
            askingNewLowestAskPushSwitch.isOn = false
        }
        
        if let itemSold = status.askItemSold, !itemSold.isEmpty {
            if itemSold.elementsEqual("1") {
                itemSoldEmailSwitch.isOn = true
            } else {
                itemSoldEmailSwitch.isOn = false
            }
        }  else {
            itemSoldEmailSwitch.isOn = false
        }
        
        if let itemSoldPush = status.askItemSold, !itemSoldPush.isEmpty {
            if itemSoldPush.elementsEqual("1") {
                itemSoldPushSwitch.isOn = true
            } else {
                itemSoldPushSwitch.isOn = false
            }
        }  else {
            itemSoldPushSwitch.isOn = false
        }
        
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "toAddEditShipingAddress":
                let destVC = segue.destination as! AddShipingInfoVC
                
                if let address = shipingAddress {
                    destVC.addressToEdit = address
                } else {
                    destVC.addressToEdit = nil
                }
            case "toEditBillingAddress":
                let destVC = segue.destination as! AddShipingInfoVC
                destVC.isBilling = true
                
                if let address = billingAddress {
                    destVC.billingAddressToEdit = address
                } else {
                    destVC.billingAddressToEdit = nil
                }
            case "toPayOutInfo":
                let destVC = segue.destination as! PayoutInfoVC
                if let info = payout {
                    destVC.payout = info
                }
            
                
            default:
                print("Do nothing")
            }
        }
    }
    
    
    @objc func biddingNewLowestAskSubContainerAction(_ sender: UITapGestureRecognizer) {
        biddingNewLowestAskContainer.expandColapseView(expendedText: "Sent when a new lowest ask is placed on an item you're bidding.")
    }
    
    @objc func biddingNewHighestBidSubContainerAction(_ sender: UITapGestureRecognizer) {
        biddingNewHighestBidContainer.expandColapseView(expendedText: "Sent when a new highest bid is placed on an item you have an active Bid on.")
    }
    
    @objc func bidAcceptedSubContainerAction(_ sender: UITapGestureRecognizer) {
        bidAcceptedContainer.expandColapseView(expendedText: "Your bid has been accepted")
    }
    
    @objc func followingNewLowestAskSubContainerAction(_ sender: UITapGestureRecognizer) {
        followingNewLowestAskContainer.expandColapseView(expendedText: "Sent when a new lowest ask is placed on an item you're following.")
    }
    
    @objc func askingNewHighestBidSubContainerAction(_ sender: UITapGestureRecognizer) {
        askingNewHighestBidContainer.expandColapseView(expendedText: "Sent when a new Lowest Ask is placed on an item you're following")
    }
    
    @objc func askingNewLowestAskSubContainerAction(_ sender: UITapGestureRecognizer) {
        askingNewLowestAskContainer.expandColapseView(expendedText: "Sent when a new Lowest Ask is placed for an item you have an active Ask for.")
    }
    
    @objc func itemSoldSubContainerAction(_ sender: UITapGestureRecognizer) {
       itemSoldContainer.expandColapseView(expendedText: "Your item has been sold.")
    }
    
    @objc func barBtnSignupAction(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Sign Out", message: "Are you sure to Sign Out!", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "No", style: .cancel)
        alert.addAction(cancelAction)
        
        let okAction = UIAlertAction(title: "Yes", style: .default) { (action) in
            LocalPersistance.clearUserDetails()
            if let bundleID = Bundle.main.bundleIdentifier {
                UserDefaults.standard.removePersistentDomain(forName: bundleID)
            }
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    @objc func barBtnDoneAction(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func switchesAction(_ sender: UISwitch) {
        
        let value = sender.isOn ? 1 : 0
        let tag = sender.tag
        sender.isUserInteractionEnabled = false
        
        APICall.changeNotiStatus(statusValue: notiStatusValue[tag], status: value) { (response) in
            sender.isUserInteractionEnabled = true
            if let response = response {
                if response.status! {
                    print("Status changed")
                } else {
                        print("Status Not changed")
                }
            }
        }
    }
    
    @IBAction func editShipingAddress(_ sender: Any) {
        performSegue(withIdentifier: "toAddEditShipingAddress", sender: nil)
    }
    
    @IBAction func editPayout(_ sender: Any) {
        performSegue(withIdentifier: "toPayOutInfo", sender: nil)
    }
    
    @IBAction func editBilingAddress(_ sender: Any) {
        performSegue(withIdentifier: "toEditBillingAddress", sender: nil)
    }
    @IBAction func editPayment(_ sender: Any) {
      //  performSegue(withIdentifier: "toCardIfo", sender: nil)

        
    }
    
}
