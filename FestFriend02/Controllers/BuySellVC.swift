//
//  BuySellVC.swift
//  FestFriend02

//  Copyright © 2019 MySoftheaven BD. All rights reserved.
//

import UIKit
import Stripe


class BuySellVC: UIViewController, ExpirationDaysVCDelegate, CheckCouponCodeDelegate,STPAddCardViewControllerDelegate {
    
    // Mark: - Outlets

    @IBOutlet weak var imgHeader: UIImageView!
    
    @IBOutlet weak var lblBidAsk: UILabel!
    @IBOutlet weak var lblQuantity: UILabel!
    @IBOutlet weak var lblAskBidLabel: UILabel!
    @IBOutlet weak var lblAskBidState: UILabel!
    @IBOutlet weak var lblShipingLabel: UILabel!
    @IBOutlet weak var lblShipingAmount: UILabel!
    @IBOutlet weak var lblAuthenticationLabel: UILabel!
    @IBOutlet weak var lblAuthenticationAmount: UILabel!
    @IBOutlet weak var lblPaymentprocessing: UILabel!
    @IBOutlet weak var lblPaymentprocessingAmount: UILabel!
    @IBOutlet weak var lblAddCouponLabel: UILabel!
    @IBOutlet weak var lblCouponCode: UILabel!
    @IBOutlet weak var lblTotalAskBid: UILabel!
    @IBOutlet weak var lblTotalAskBidAmount: UILabel!
    @IBOutlet weak var lblExpirationDays: UILabel!
    @IBOutlet weak var lblAccountNong: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblAddressIcon: UIImageView!
    
    @IBOutlet weak var billingInfoUnderline: UIView!
    @IBOutlet weak var addpaymentUnderline: UIView!
    
    @IBOutlet weak var paymentMethodImage: UIImageView!
    
    @IBOutlet weak var txtValue: UITextField!
    
    @IBOutlet weak var btnPlaceBidAsk: UIButton!
    @IBOutlet weak var btnBuySell: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    
    @IBOutlet weak var bidPaymentProcessingContainer: UIStackView!
    
    @IBOutlet weak var bidExpirationContainer: UIView!
    @IBOutlet weak var paymentInfoContainer: UIView!
    
    @IBOutlet weak var billingInfoContainer: UIView!
    
    @IBOutlet weak var bidSellButtonsContainer: UIView!
    @IBOutlet weak var topShadowView: UIView!
    
    @IBOutlet weak var InfoConstant: NSLayoutConstraint!
    @IBOutlet weak var bidexpection: NSLayoutConstraint!
    /*------------------------------------------------------------------
    ------------------------------------------------------------------*/
    
    
    // Mark: - Properties
    var nextBtnColorGreen = 0
    var payout: Payout?
    var shippingAdrress: String?
    var buySellStatus : String?
    var lblTitle: UILabel?

    var vcColor: UIColor {
        get {
            
            if bidAskModel.isBid! {
                nextBtnColorGreen = 1
                return UIColor.appGreenColor
            } else {
                nextBtnColorGreen = 0
                return UIColor.appRedColor
            }
        }
    }
    
    var expirationLabelPrefix: String {
        get{
            if bidAskModel.isBid! {
                return "Bid Expiration: "
            } else {
                return "Ask Expiration: "
            }
        }
    }
    
    var bidAskModel: BidAskModel!
    var userBuyingResponse: UserBuyingResponse?
    var userSellingResponse: UserSellingResponse?
    //var vcTitle: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true // Mark :- make taqb bar hidden if have any
        
        setupViews()
        txtValue.addTarget(self, action: #selector(txtAmountEditing(_:)), for: .editingChanged)
        //txtValue.addDoneOnKeyboard(withTarget: self, action: #selector(doneButtonClicked))
        txtValue.addDoneOnKeyboardWithTarget(self, action: #selector(doneButtonClicked))
        let expirationContainerTap = UITapGestureRecognizer(target: self, action: #selector(expirationDayContainerAction(_:)))
        bidExpirationContainer.addGestureRecognizer(expirationContainerTap)
        let billingInfoContainerTap = UITapGestureRecognizer(target: self, action: #selector(billingInfoContainerAction(_:)))
        billingInfoContainer.addGestureRecognizer(billingInfoContainerTap)
        navigationController?.navigationBar.barStyle = .default
        
        if bidAskModel.isBid! {
            getAllBids()
            getShipingAddress()
        } else {
            getAllAsks()
            getPayout()
        }
    
        UserDefaults.standard.set(nil, forKey: "stripe_id_token")
        ViewSetupForUpdate()
    
        
       
    }
    
    //MARK: Reload data every time view apear
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tabBarController?.tabBar.isHidden = true // Mark :- make taqb bar hidden if have any
               setupViews()
               txtValue.addTarget(self, action: #selector(txtAmountEditing(_:)), for: .editingChanged)
               //txtValue.addDoneOnKeyboard(withTarget: self, action: #selector(doneButtonClicked))
               txtValue.addDoneOnKeyboardWithTarget(self, action: #selector(doneButtonClicked))
               let expirationContainerTap = UITapGestureRecognizer(target: self, action: #selector(expirationDayContainerAction(_:)))
               bidExpirationContainer.addGestureRecognizer(expirationContainerTap)
               let billingInfoContainerTap = UITapGestureRecognizer(target: self, action: #selector(billingInfoContainerAction(_:)))
               billingInfoContainer.addGestureRecognizer(billingInfoContainerTap)
               navigationController?.navigationBar.barStyle = .default
               
               if bidAskModel.isBid! {
                   getAllBids()
                   getShipingAddress()
                self.lblAccountNong.text = "Add Payment Method"
               } else {
                   getAllAsks()
                   getPayout()
               }
           
               UserDefaults.standard.set(nil, forKey: "stripe_id_token")
               ViewSetupForUpdate()
    }
    //Mark:- Setup few view data while comming from update
    func ViewSetupForUpdate()
    {
        if bidAskModel.isEdit == true
        {
             if bidAskModel.isBid!
             {
                btnNext.backgroundColor = UIColor.appGreenColor
                if bidAskModel.authenticationAmount() == 0.0 {
                               lblAuthenticationAmount.text = "Free"
                           } else {
                               lblAuthenticationAmount.text = "-$\(String(format: "%.2f", bidAskModel.authenticationAmount()))"

                           }
                
                if bidAskModel.paymentProcessingAmount() == 0.3 {
                    lblPaymentprocessingAmount.text = "--"
                } else {
                    lblPaymentprocessingAmount.text = "$\(String(format: "%.2f", bidAskModel.paymentProcessingAmount()))"

                }
            }
            else
             {
                btnNext.backgroundColor = UIColor.appRedColor
                if bidAskModel.authenticationAmount() == 0.0 {
                               lblAuthenticationAmount.text = "--"
                           } else {
                               lblAuthenticationAmount.text = "-$\(String(format: "%.2f", bidAskModel.authenticationAmount()))"

                           }
                
                if bidAskModel.paymentProcessingAmount() == 0.3 {
                    lblPaymentprocessingAmount.text = "--"
                } else {
                    lblPaymentprocessingAmount.text = "$\(String(format: "%.2f", bidAskModel.paymentProcessingAmount()))"

                }
            }
        }
    }//Mark:- Setup few view data while comming from update End code
    
    @objc func doneButtonClicked(_ sender: Any) {
        guard let amountText = txtValue.text else {
            return
        }
        
        guard let value = Double(amountText) else {
            return
        }
        bidAskModel.value = value
        if bidAskModel.highestBid != nil {
            if bidAskModel.isBid! {
                
            } else {
                if value <= Double(bidAskModel.highestBid ?? 0) {
                    btnBuySell.backgroundColor = vcColor
                    btnBuySell.setTitleColor(UIColor.white, for: .normal)
                    btnPlaceBidAsk.backgroundColor = UIColor.white
                    btnPlaceBidAsk.setTitleColor(UIColor.black, for: .normal)
                    workInBuyNowButton()
                }
                
            }
        }

        if  (shouldRelese(releaseDate: bidAskModel.bidasksalescutoff!)) {
            let dialogMessage = UIAlertController(title: "Product Unaviailable", message: "This product not aviailable currently.", preferredStyle: .alert)
            
            // Create OK button with action handler
            let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                
                self.navigationController?.popViewController(animated: true)
            })
            
            dialogMessage.addAction(ok)
            
            
            // Present dialog message to user
            self.present(dialogMessage, animated: true, completion: nil)
            
        } else
        if (!shouldRelese(releaseDate: bidAskModel.releaseDate!)) {
            let dialogMessage = UIAlertController(title: "Product Unavailable", message: "This product is not available currently.", preferredStyle: .alert)
            
            // Create OK button with action handler
            let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                
                self.navigationController?.popViewController(animated: true)
            })
            
            dialogMessage.addAction(ok)
            
            
            // Present dialog message to user
            self.present(dialogMessage, animated: true, completion: nil)
            
        }
        
       txtValue.resignFirstResponder()
        
    }
    
    

    private func getAllBids() {
        showProgress(on: view)
        APICall.getAllUserBids { (response) in
            self.dismissProgress(for: self.view)
            
            if let response = response {
                if response.status! {
                    self.userBuyingResponse = response
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
                }
            }
        }
    }
    
    
    @IBAction func backBarBtnAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    // Mark: - VC Methods
    
    private func setupViews() {
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        // to remove the border line or shadow image of navigation bar
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        let titleAttributes = [
            NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14 , weight: UIFont.Weight.heavy),
            NSAttributedStringKey.foregroundColor: UIColor.black
        ]
        self.navigationController?.navigationBar.titleTextAttributes = titleAttributes
        //self.title = bidAskModel.getTitle()
        lblTitle = setMultilineTitle(title: bidAskModel.getTitle())
        lblTitle?.textColor = UIColor.black
//        topShadowView.layer.shadowOpacity = 0.8
//        topShadowView.layer.shadowOffset = CGSize(width: 0, height: 1)
        
        bidSellButtonsContainer.layer.borderWidth = 1
        bidSellButtonsContainer.layer.borderColor = UIColor(red: 118/255, green: 118/255, blue: 118/255, alpha: 0.2).cgColor
        //bidSellButtonsSelectionChanges(selected: btnBuySell)
        
        lblAddCouponLabel.textColor = vcColor
        populateData()
        //before relase date
        //after bid/ask cutoff
        if let shippingCutoff = bidAskModel.cutOffDate, shouldbidsalesCutoff(bidslesCutoff: shippingCutoff) {
            self.lblAddress.text =  "This item is currently only eligible for in person pick-up"
            self.lblAddress.font = self.lblAddress.font.withSize(15)
            self.lblAddress.lineBreakMode = .byWordWrapping
            self.lblAddress.numberOfLines = 2
            self.lblAddressIcon.isHidden = true
            self.billingInfoContainer.isUserInteractionEnabled = false
        }
        
   

        
        if bidAskModel.isBid! {
            btnPlaceBidAsk.setTitle("Place Bid", for: .normal)
            btnBuySell.setTitle("Buy Now", for: .normal)
            bidPaymentProcessingContainer.isHidden = true
            bidAskModel.shippingAmount = 17.70
            lblShipingAmount.text = "+$17.70"
            lblTotalAskBid.text = "Total"
            self.buySellStatus = "buy"
        } else {
            self.buySellStatus = "sell"
            btnPlaceBidAsk.setTitle("Place Ask", for: .normal)
            btnBuySell.setTitle("Sell Now", for: .normal)
            bidAskModel.shippingAmount = 0.0
            lblShipingAmount.text = "Free"
            bidPaymentProcessingContainer.isHidden = false
            lblAuthenticationLabel.text = "Authentication (\(bidAskModel.authenticationRate)%)"
            if(bidAskModel.paymentProcessingRate == nil) {
                lblPaymentprocessing.text = "Payment Processing"
            } else {
                 lblPaymentprocessing.text = "Payment Processing (\(bidAskModel.paymentProcessingRate)% + $.30)"
            }
           
            //payout information
            
            lblTotalAskBid.text = "Net Payout"
            lblAccountNong.text = "Add Payout Method"
            paymentMethodImage.image = UIImage(named: "Payout Method 2")
            billingInfoContainer.alpha = 0

            bidexpection.constant = -50
        }
        
        if bidAskModel.isEdit {
            bidSellButtonsSelectionChanges(selected: btnPlaceBidAsk)
        } else {
            bidSellButtonsSelectionChanges(selected: btnBuySell)
        }
       
    }
    
    private func getPayout() {
        showProgress(on: view)
        APICall.getUserPayout { (response) in
            self.dismissProgress(for: self.view)
            
            if let response = response {
                if let payout = response.payout {
                     self.payout = payout
                    if let paypalAccountNumber = payout.bankAccountNumber  {
                        self.lblAccountNong.text = "\(payout.bankAccountName ?? "") \n\(payout.getFormatedAccountNumber())"
                        self.lblAccountNong.font = self.lblAccountNong.font.withSize(15)
                        self.lblAccountNong.lineBreakMode = .byWordWrapping
                        self.lblAccountNong.numberOfLines = 2
//                        self.btnEditSellingPayment.isHidden = true
                    } else {
                        self.lblAccountNong.text = "Add Payout Method"
//                        self.btnEditSellingPayment.isHidden = true
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
                        self.shippingAdrress = address.getFormatedAddress()
                        if let shippingCutoff = self.bidAskModel.cutOffDate, self.shouldbidsalesCutoff(bidslesCutoff: shippingCutoff) {
                            self.lblAddress.text =  "This item is currently only eligible for in person pick-up"
                            self.lblAddress.font = self.lblAddress.font.withSize(15)
                            self.lblAddress.lineBreakMode = .byWordWrapping
                            self.lblAddress.numberOfLines = 2
                            self.lblAddressIcon.isHidden = true
                            self.billingInfoContainer.isUserInteractionEnabled = false
                        } else {
                            self.lblAddress.text = address.getFormatedAddress()
                            self.lblAddress.font = self.lblAccountNong.font.withSize(15)
                            self.lblAddress.lineBreakMode = .byWordWrapping
                            self.lblAddress.numberOfLines = 2
                        }
                        
                        
//                        self.lblAddress = address
                    } else {
                        if let shippingCutoff = self.bidAskModel.cutOffDate, self.shouldbidsalesCutoff(bidslesCutoff: shippingCutoff) {
                            self.lblAddress.text =  "This item is currently only eligible for in person pick-up"
                            self.lblAddress.font = self.lblAddress.font.withSize(15)
                            self.lblAddress.lineBreakMode = .byWordWrapping
                            self.lblAddress.numberOfLines = 2
                            self.lblAddressIcon.isHidden = true
                            self.billingInfoContainer.isUserInteractionEnabled = false
                        } else {
                            self.lblAddress.text = "Add Shipping Address"
                        }
                    }
                } else {
                    if let shippingCutoff = self.bidAskModel.cutOffDate, self.shouldbidsalesCutoff(bidslesCutoff: shippingCutoff) {
                        self.lblAddress.text =  "This item is currently only eligible for in person pick-up"
                        self.lblAddress.font = self.lblAddress.font.withSize(15)
                        self.lblAddress.lineBreakMode = .byWordWrapping
                        self.lblAddress.numberOfLines = 2
                        self.lblAddressIcon.isHidden = true
                        self.billingInfoContainer.isUserInteractionEnabled = false
                    } else {
                        self.lblAddress.text = "Add Shipping Address"
                    }
                }
            } else {
                if let shippingCutoff = self.bidAskModel.cutOffDate, self.shouldbidsalesCutoff(bidslesCutoff: shippingCutoff) {
                    self.lblAddress.text =  "This item is currently only eligible for in person pick-up"
                    self.lblAddress.font = self.lblAddress.font.withSize(15)
                    self.lblAddress.lineBreakMode = .byWordWrapping
                    self.lblAddress.numberOfLines = 2
                    self.lblAddressIcon.isHidden = true
                    self.billingInfoContainer.isUserInteractionEnabled = false
                } else {
                    self.lblAddress.text = "Add Shipping Address"
                }
            }
        }
    }
    
    private func bidSellButtonsSelectionChanges(selected btn: UIButton) {
        btn.backgroundColor = vcColor
        btn.setTitleColor(UIColor.white, for: .normal)
        
        if btn == btnBuySell {
            if bidAskModel.isBid! {
                bidAskModel.buttonName = "Buy Now"
            } else {
                bidAskModel.buttonName = "Sell Now"
            }
            btnPlaceBidAsk.backgroundColor = UIColor.white
            btnPlaceBidAsk.setTitleColor(UIColor.black, for: .normal)
            workInBuyNowButton()
            self.bidExpirationContainer.alpha = 0
            self.billingInfoUnderline.alpha = 0
            if bidAskModel.isBid! {
                self.addpaymentUnderline.alpha = 1
            } else {
                self.addpaymentUnderline.alpha = 0

                
            }
        } else {
            if bidAskModel.isBid! {
                bidAskModel.buttonName = "Place Bid"

            } else {
                bidAskModel.buttonName = "Place Ask"
            }

            self.bidExpirationContainer.alpha = 1
            self.billingInfoUnderline.alpha = 1
            self.addpaymentUnderline.alpha = 1

            btnBuySell.backgroundColor = UIColor.white
            btnBuySell.setTitleColor(UIColor.black, for: .normal)
            
            txtValue.isEnabled = true
            if bidAskModel.isEdit {
                txtValue.text = "\(Int(bidAskModel.editableValue))"
                bidAskModel.value = bidAskModel.editableValue
            } else {
                txtValue.text = ""
                bidAskModel.value = 0.0
            }
            lblAskBidState.text = ""
            bidAskModel.directBuy = 0
            bidAskModel.directBuy = 0
            
            if bidAskModel.isBid! {
                lblAskBidLabel.text = "ENTER BID"

            } else {
                lblAskBidLabel.text = "ENTER ASK"

                
            }
            lblTotalAskBidAmount.text = bidAskModel.totalAmount == 0.00 ? "--" : "$\(String(format: "%.2f", bidAskModel.totalAmount.roundToTwoDecimal()))"
            
           
            
        }
        
        //Mark:-execute when it is in ask mode it means button btnBidAsk color is red
        if let highestBid = bidAskModel.highestBid, highestBid > 0 {
            
            if bidAskModel.paymentProcessingAmount() == 0.3
            {
                lblPaymentprocessingAmount.text = "--"
            } else {
                lblPaymentprocessingAmount.text = "$\(String(format: "%.2f", bidAskModel.paymentProcessingAmount()))"

            }
            
            if bidAskModel.authenticationAmount() == 0.0
            {
                lblAuthenticationAmount.text = "--"
            } else {
                lblAuthenticationAmount.text = "-$\(String(format: "%.2f", bidAskModel.authenticationAmount()))"

            }
        }
            //Mark:-execute when it is in sell mode it means button btnBuySell color is red
        else
        {
            if btnBuySell.backgroundColor == UIColor.appRedColor
            {
                bidAskModel.value = 0.0
                txtValue.text = ""
            }
            
            if bidAskModel.paymentProcessingAmount() == 0.3
            {
                lblPaymentprocessingAmount.text = "--"
            } else {
                lblPaymentprocessingAmount.text = "$\(String(format: "%.2f", bidAskModel.paymentProcessingAmount()))"

            }
            
            if bidAskModel.authenticationAmount() == 0.0
            {
                lblAuthenticationAmount.text = "--"
            } else {
                lblAuthenticationAmount.text = "-$\(String(format: "%.2f", bidAskModel.authenticationAmount()))"

            }
        }
//
//        else {
//            lblPaymentprocessingAmount.text = "--"
//            lblAuthenticationAmount.text = "--"
//        }
//
        lblTotalAskBidAmount.text = bidAskModel.totalAmount == 0.00 ? "--" : "$\(String(format: "%.2f", bidAskModel.totalAmount.roundToTwoDecimal()))"

       
        
        let paymentTap = UITapGestureRecognizer(target: self, action: #selector(paymentInfoContainerAction(_:)))
        paymentInfoContainer.addGestureRecognizer(paymentTap)
    }
    
    func workInBuyNowButton() {
       
        txtValue.isEnabled = false
        
        if bidAskModel.isBid! {
            lblAskBidLabel.text = "LOWEST ASK"
            bidAskModel.directBuy = 1
            bidAskModel.directBuy = 0
            
            if let lowestAsk = bidAskModel.lowestAsk, lowestAsk > 0 {
                txtValue.text = "\(lowestAsk)"
                lblAskBidState.text = "You’re about to buy this product for $\(lowestAsk)"
                bidAskModel.value = Double(lowestAsk)
            } else {
                txtValue.text = ""
                lblAskBidState.textColor = UIColor.black
                lblAskBidState.text = "NO ASKS AVAILABLE"
                bidAskModel.value = 0.0
            }
            
        } else {
            lblAskBidLabel.text = "HIGHEST BID"
            bidAskModel.directBuy = 0
            bidAskModel.directBuy = 1
            
            if let highestBid = bidAskModel.highestBid, highestBid > 0 {
               // lblAskBidState.textColor = UIColor.appGreenColor
                lblAskBidState.text = "You're about to sell at the highest Bid price"
                txtValue.text = "\(highestBid)"
                bidAskModel.value = Double(highestBid)
                lblTotalAskBidAmount.text = "$\(String(format: "%.2f", bidAskModel.totalAmount.roundToTwoDecimal()))"

            } else {
                lblAskBidState.textColor = UIColor.appRedColor
                lblAskBidState.text = "NO BIDS AVAILABLE"
                txtValue.text = ""
                bidAskModel.value = 0.0
                lblTotalAskBidAmount.text = "--"

            }
        }
        
        
        
        
//        if  ((txtValue.text ?? "").isEmpty){
//            btnNext.backgroundColor = UIColor(hexFromString: "#F0F0F0")
//            btnNext.isUserInteractionEnabled = false
//        } else {
//
//
//
            if (shouldRelese(releaseDate: bidAskModel.releaseDate!)  && !shouldRelese(releaseDate: bidAskModel.bidasksalescutoff!) ) {
                btnNext.backgroundColor = vcColor
                btnNext.isUserInteractionEnabled = true
            } else {
                
                btnNext.backgroundColor = UIColor(hexFromString: "#F0F0F0")
                btnNext.isUserInteractionEnabled = false
                
               
            }
            
       // }
       //
        //Title : Reaease date not match
        // The transaction window for this item has ended, it can no longer be purchased or sold on our platform.
        
        
        //Title : Product Unaviailable
        //This product not aviailable currently.btn
        
        
//        if let releaseDate = bidAskModel.releaseDate, shouldRelese(releaseDate: releaseDate), let bidsalesCutoff = bidAskModel.bidasksalescutoff, shouldRelese(releaseDate: bidsalesCutoff) && ((txtValue.text ?? "").isEmpty){
//            btnNext.backgroundColor = UIColor(hexFromString: "#F0F0F0")
//            btnNext.isUserInteractionEnabled = false
//
//        } else {
//            btnNext.backgroundColor = vcColor
//            btnNext.isUserInteractionEnabled = true
//        }
//
        
       // if let lowestAsk = bidAskModel.lowestAsk, lowestAsk > 0 {
//        } else {
//            lblTotalAskBidAmount.text = "--"
//        }
       
    }
    private func populateData() {
        
        if let urlStr = bidAskModel.headerImgUrl, !urlStr.isEmpty {
            let url = URL(string: urlStr)
            DispatchQueue.main.async {
                self.imgHeader.sd_setImage(with: url)
            }
        }
        
        var bidStr = "Highest Bid: $"
        if let highestBid = bidAskModel.highestBid {
            bidStr.append("\(highestBid) | Lowest Ask: $")
        } else {
            bidStr.append("- | Lowest Ask: $")
        }
        
        if let lowestAsk = bidAskModel.lowestAsk {
            bidStr.append("\(lowestAsk)")
        } else {
            bidStr.append("-")
        }
        
        lblBidAsk.text = bidStr
        lblQuantity.text = "Quantity: \(bidAskModel.quantity)"
        
        if bidAskModel.bidAskExpiraryDay > 1 {
            lblExpirationDays.text = expirationLabelPrefix.appending("\(bidAskModel.bidAskExpiraryDay) days")
        } else {
            lblExpirationDays.text = expirationLabelPrefix.appending("\(bidAskModel.bidAskExpiraryDay) day")
        }
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier.elementsEqual("toExpirationDays") {
                let destVC = segue.destination as! ExpirationDaysVC
                destVC.delegate = self
            } else if identifier.elementsEqual("toConfirmBuySell") {
                let destVC = segue.destination as! BuySellConfirmVC
                destVC.bidAskModel = bidAskModel
            } else if identifier.elementsEqual("toCheckCoupon") {
                let destVC = segue.destination as! AddCouponVC
                destVC.delegate = self
            } else if identifier.elementsEqual("buySellPopup") {
                let destVC = segue.destination as! BuySellPopUpVC
                
                destVC.delegate = self
            }
            else if identifier.elementsEqual("bidaskpopup") {
                let destVC = segue.destination as! BidaskPopUpControllar
                destVC.delegate = self
            }
            else if identifier.elementsEqual("toBuyingSelling") {
                let destVC = segue.destination as! BuyingSellingVC
                let isBuying = bidAskModel.isBid! ? true : false
                destVC.isBuying = isBuying
                destVC.which_view = "BuySellVc"
            }
            else if identifier.elementsEqual("goToAuthentication") {
                let destVC = segue.destination as! SignInVC
                destVC.isForRegister = sender as! Bool
            }
            else if identifier.elementsEqual("toPayoutInfo") {
                let destVC = segue.destination as! PayoutInfoVC
                if let info = payout {
                    destVC.payout = info
                }
                
            }
        }
    }
    
    // Mark: - Actions
    
    @IBAction func btnPlaceBidAskAction(_ sender: UIButton) {
        bidSellButtonsSelectionChanges(selected: sender)
    }
    
    @IBAction func btnBuySellAction(_ sender: UIButton) {
        bidSellButtonsSelectionChanges(selected: sender)
    }
    
    @IBAction func btnNextAction(_ sender: UIButton) {
        
    if LocalPersistance.getUserId() == 0 {
       
        let dialogMessage = UIAlertController(title: "Login Required", message: "You must log in before proceeding", preferredStyle: .alert)
        
        // Create OK button with action handler
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            
            self.login()
        })
        
        // Create Cancel button with action handlder
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
           
        }
        
        //Add OK and Cancel button to dialog message
        dialogMessage.addAction(ok)
        dialogMessage.addAction(cancel)
        
        // Present dialog message to user
        self.present(dialogMessage, animated: true, completion: nil)
        
    }
    else {
       
        
//        \(bidAskModel.isAskBidStr) -changed by meadown
        if bidAskModel.value < 1.0 {
        showDialog(title: "", message: " Amount Required")
        }
//            \(bidAskModel.isAskBidStr)
         if bidAskModel.value < 10.0  {
            showDialog(title: "", message: " You need to \(bidAskModel.isAskBidStr) at least $10")
            
        }
            
         else if bidAskModel.isBid! {
            if let shippingCutoff = self.bidAskModel.cutOffDate, !self.shouldbidsalesCutoff(bidslesCutoff: shippingCutoff) {
                guard let lblshipingAdd = shippingAdrress, !(lblshipingAdd == "") else {
                    showDialog(title: "Add Address", message: "Shipping Address is required.")
                    return
                    
                }
            }
            
            guard let paymentMethod = LocalPersistance.getStripeIdToken() , !(paymentMethod == "") else {
                showDialog(title: "Add Payment Method", message: "Payment Method is required.")
                return
            }
            
            if bidAskModel.isEdit  && btnBuySell.backgroundColor == UIColor.white{
               
             update()
                
            }
            else
            
            {
            
            var param = [String: AnyObject]()
            param["status"] = self.buySellStatus as? AnyObject
            param["user_id"] = LocalPersistance.getUserId() as? AnyObject
            param["ticketId"] = bidAskModel.ticketId! as? AnyObject
            
            APICall.activeAskBid(param: param) { (response) in
                if let response = response {
                    if response.status! {
                        guard let flagId = response.flag else {
                            return
                        }
                        
                        if flagId == 0 {
                        
                            if let buying = self.userBuyingResponse, buying.isBidedPreviously(id: self.bidAskModel.ticketId!) {
                                self.performSegue(withIdentifier: "buySellPopup", sender: self)
                            } else {
                                self.performSegue(withIdentifier: "toConfirmBuySell", sender: self)
                            }
                            
                            
                        } else if flagId == 1 {
                            
                            if self.buySellStatus == "buy" {
                                self.showDialog(title: "Unable to Place Bid", message: "You are unable to place a Bid because you currently have an active Ask on the same item. Please go to Account and cancel your Ask in order to place a Bid.")
                                
                            } else {
                                self.showDialog(title: "Unable to Place Ask", message: "You are unable to place an Ask because you currently have an active Bid on the same item. Please go to Account and cancel your Bid in order to place an Ask.")
                                
                            }
                        }
                        
                    }
                    
                }
                
            }
        }//Mark:- if not from update then called End
        }
         
        else {
            
            //Mark:- if coomming from update then called Start
        if bidAskModel.isEdit && btnBuySell.backgroundColor == UIColor.white
        {
               
             update()
            } //Mark:- if not from update then called End
           
        else
            {
             //Mark:- if not from update then called Start
            var param = [String: AnyObject]()
            param["status"] = self.buySellStatus as? AnyObject
            param["user_id"] = LocalPersistance.getUserId() as? AnyObject
            param["ticketId"] = bidAskModel.ticketId! as? AnyObject
            
            APICall.activeAskBid(param: param) { (response) in
                if let response = response {
                    if response.status! {
                        guard let flagId = response.flag else {
                            return
                        }
                        
                        if flagId == 0 {
                            
                            if let selling = self.userSellingResponse, selling.isAskedPreviously(id: self.bidAskModel.ticketId!) {
                                self.performSegue(withIdentifier: "bidaskpopup", sender: self)
                            } else {
                                self.performSegue(withIdentifier: "toConfirmBuySell", sender: self)
                            }
                            
                            
                        } else if flagId == 1 {
                            
                            if self.buySellStatus == "buy" {
                                self.showDialog(title: "Unable to Place Bid", message: "You are unable to place a Bid because you currently have an active Ask on the same item. Please go to Account and cancel your Ask in order to place a Bid.")
                                
                            } else {
                                self.showDialog(title: "Unable to Place Ask", message: "You are unable to place an Ask because you currently have an active Bid on the same item. Please go to Account and cancel your Bid in order to place an Ask.")
                                
                            }
                        }
                        
                    }
                    
                }
                
            }
            
        } //Mark:- if not from update then called End
        }
        
    }
        
//        if bidAskModel.isEdit {
//          update()
//        } else {
//
//            performSegue(withIdentifier: "buySellPopup", sender: self)
        
//            if bidAskModel.value > 10.0 {
//                performSegue(withIdentifier: "toConfirmBuySell", sender: self)
//            } else {
//                showDialog(title: "", message: "\(bidAskModel.isAskBidStr) Value can't be empty or 0")
//            }
//     }
        
      
    }
    
   fileprivate func login()
    {
        performSegue(withIdentifier: "goToAuthentication", sender: false)
    }
    
    @IBAction func lblAddCouponAction(_ sender: Any) {
        if LocalPersistance.getUserId() > 0 {
            performSegue(withIdentifier: "toCheckCoupon", sender: nil)
        }
    }
    
    
    
    @objc func billingInfoContainerAction(_ sender: UITapGestureRecognizer) {
        if nextBtnColorGreen != 1 {
            performSegue(withIdentifier: "cardInfo", sender: self)
        }
        else {
            performSegue(withIdentifier: "cardInfo", sender: self)
            print("toPayoutInfoGreen")
        }
        
    }
    
    
    
    @objc func paymentInfoContainerAction(_ sender: UITapGestureRecognizer) {
        if nextBtnColorGreen != 1 {
            performSegue(withIdentifier: "toPayoutInfo", sender: self)
        }
        else {
            

            let addCardViewController = STPAddCardViewController();
            addCardViewController.delegate = self
            
            let navigationController = UINavigationController(rootViewController: addCardViewController)
            
            present(navigationController,animated: true)
            
            
            
        }
        
    }
    
    /************ Stripe Payment Method Implementation ******/
 
    func addCardViewControllerDidCancel(_ addCardViewController: STPAddCardViewController) {
        dismiss(animated: true)
    }
    
    func addCardViewController(_ addCardViewController: STPAddCardViewController, didCreateToken token: STPToken, completion: @escaping STPErrorBlock) {
        
        dismiss(animated: true)
        
        print("Stripe Payment: \(token.allResponseFields)\n\n\n")
        print("Card Info Brand: \(token.card)\n\n\n")
        let brand = STPCard.string(from: (token.card?.brand)!)
        let last4 = token.card?.last4
        LocalPersistance.setCardNumberLast4(card: last4!)
        lblAccountNong.text = "Card ending in "+last4!
        
        
        
        print("Brand: "+brand)
        
        print("Card Info Last 4: \(token.card?.last4)\n\n\n")
        
        print("Stripe Token id :"+token.tokenId)
        
        
        LocalPersistance.setStripeIdToken(id: token.tokenId)
        
 
    }
    
    /************ End Stripe Payment Method Implementation ******/

  
    
    @objc func txtAmountEditing(_ sender: UITextField) {
        if let text = sender.text, !text.isEmpty {
            let value = Double(text)!
            bidAskModel.value = value
        
        if bidAskModel.lowestAsk != nil {
            if bidAskModel.isBid! {
                if value >= Double(bidAskModel.lowestAsk ?? 0) ?? 0.00{
                    btnBuySell.backgroundColor = vcColor
                    btnBuySell.setTitleColor(UIColor.white, for: .normal)
                    btnPlaceBidAsk.backgroundColor = UIColor.white
                    btnPlaceBidAsk.setTitleColor(UIColor.black, for: .normal)
                    workInBuyNowButton()
                }
            }
        }
 
//        if let releaseDate = bidAskModel.releaseDate, shouldRelese(releaseDate: releaseDate), let bidsalesCutoff = bidAskMode bidAskModel.releaseDate !shouldRelese(releaseDate: bidsalesCutoff) && ((txtValue.text ?? "").isEmpty){
//                btnNext.backgroundColor = UIColor(hexFromString: "#F0F0F0")
//                btnNext.isUserInteractionEnabled = false
//
//            } else {
//                btnNext.backgroundColor = vcColor
//                btnNext.isUserInteractionEnabled = true
//            }
         if bidAskModel.isBid! {
                
                let highestBid = bidAskModel.highestBid != nil ? Double(bidAskModel.highestBid!) : 0.0
                
                if bidAskModel.value > highestBid {
                    lblAskBidState.textColor = UIColor.appGreenColor
                    lblAskBidState.text = "You are about to be the highest bidder."
                } else {
                    lblAskBidState.textColor = UIColor.appRedColor
                    lblAskBidState.text = "You are not highest bidder."
                }
                
            } else {
                let lowesAsk = bidAskModel.lowestAsk != nil ? Double(bidAskModel.lowestAsk!) : 0.0
            
            if lowesAsk == 0 {
                lblAskBidState.text = ""
            } else {
                if bidAskModel.value > lowesAsk {
                    lblAskBidState.textColor = UIColor.appGreenColor
                    lblAskBidState.text = "You are about to be the lowest ask."
                } else {
                    lblAskBidState.text = ""
                }
            }
        
            }
        } else {
            bidAskModel.value = 0.0
            lblAskBidState.text = ""
            //lblShipingAmount.text = "--"

        }
        
        lblShipingAmount.text = bidAskModel.shippingAmount == 0.00 ? "Free" : "+$\(String(format: "%.2f", bidAskModel.shippingAmount))"
        
//        if bidAskModel.authenticationRate <= 0 {
//            lblAuthenticationAmount.text = "--"
//        } else {
//            lblAuthenticationAmount.text = "-$\(String(format: "%.2f", bidAskModel.authenticationAmount()))"
//        }
        
//        if let highestBid = bidAskModel.highestBid, highestBid > 0 {
        print(txtValue.text)
        print (bidAskModel.value)
        print(bidAskModel.authenticationAmount())
        print(bidAskModel.paymentProcessingAmount())
        
           lblPaymentprocessingAmount.text = bidAskModel.paymentProcessingAmount() == 0.30 ? "--" : "$\(String(format: "%.2f", bidAskModel.paymentProcessingAmount()))"
            lblAuthenticationAmount.text = bidAskModel.authenticationAmount() == 0.00 ? "--" :"-$\(String(format: "%.2f", bidAskModel.authenticationAmount()))"
    //    }
//        else {
//            lblPaymentprocessingAmount.text = "--"
//            lblAuthenticationAmount.text = "--"
//        }
//
//
        
      
        lblCouponCode.text = bidAskModel.couponAmount == 0.00 ? "--" : "$\(String(format: "%.2f", bidAskModel.couponAmount))"

        
        //using ternary operation
//
        print("Paichi",bidAskModel.totalAmount)
        lblTotalAskBidAmount.text = bidAskModel.totalAmount == 0.00 ? "--" : "$\(String(format: "%.2f", bidAskModel.totalAmount))"
    }
    
    @objc func expirationDayContainerAction(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "toExpirationDays", sender: self)
    }
    
    /*------------------------------------------------------------------
     ------------------------------------------------------------------*/
    
    func expirationDaysChoosed(days: Int) {
        
        bidAskModel.bidAskExpiraryDay = days
        var bidOrAsk = expirationLabelPrefix
        
        if days > 1 {
            lblExpirationDays.text = bidOrAsk.appending("\(days) days")
        } else {
            lblExpirationDays.text = bidOrAsk.appending("\(days) day")
        }
    }
    
    private func shouldRelese(releaseDate: String) -> Bool {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        
        let releaseDate = dateFormatter.date(from: releaseDate)
        
        if let date = releaseDate {
            if currentDate > date {
                return true
            } else {
                return false
            }
        } else {
            return false
        }
        
    }
    
    private func shouldbidsalesCutoff(bidslesCutoff: String) -> Bool {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
    
        let releaseDate = dateFormatter.date(from: bidslesCutoff)
//        let subReleaseDate = releaseDate?.add()
        if let date = releaseDate {
            if currentDate > date {
                return true
            } else {
                return false
            }
        } else {
            return false
        }

    }
    
    func validCouponCode(amount: Double) {
        
        bidAskModel.couponAmount = amount
        
        lblShipingAmount.text = "$\(String(format: "%.2f", bidAskModel.shippingAmount))"
        
//        if bidAskModel.authenticationRate <= 0 {
//            lblAuthenticationAmount.text = "--"
//        } else {
//            lblAuthenticationAmount.text = "-$\(String(format: "%.2f", bidAskModel.authenticationAmount()))"
//        }
        
        if let highestBid = bidAskModel.highestBid, highestBid > 0 {
            lblPaymentprocessingAmount.text = "$\(String(format: "%.2f", bidAskModel.paymentProcessingAmount()))"
            lblAuthenticationAmount.text = "-$\(String(format: "%.2f", bidAskModel.authenticationAmount()))"
        }
//        else {
//            lblPaymentprocessingAmount.text = "--"
//            lblAuthenticationAmount.text = "--"
//        }
//
        
        
        lblCouponCode.text = "$\(String(format: "%.2f", bidAskModel.couponAmount))"
        
        lblTotalAskBidAmount.text = bidAskModel.totalAmount == 0.00 ? "--" : "$\(String(format: "%.2f", bidAskModel.totalAmount.roundToTwoDecimal()))"
        
    }
    
    private func update() {
        showProgress(on: view)
        
        var param = [
            "amount": Int(bidAskModel.value)] as! [String: AnyObject]
        
        
        //Get Stripe Token that was generate from payment method select options.
        let stripe_token = LocalPersistance.getStripeIdToken()
        param["stripe_token"] = stripe_token as AnyObject
        
            param["user_id"] = LocalPersistance.getUserId() as! AnyObject
            if bidAskModel.isBid! {
                
                //(user_id,ask_id,amount,qty,expire,directSell,inOriginalBox
                param["qty"] = bidAskModel.quantity as! AnyObject
                param["expire"] = bidAskModel.bidAskExpiraryDay as! AnyObject
                param["directBuy"] = bidAskModel.directBuy as! AnyObject
                param["bid_id"] = bidAskModel.askBidId! as! AnyObject
                param["postFrom"] = 3 as! AnyObject
                
                if bidAskModel.isInOriginalBox {
                    param["inOriginalBox"] = 1 as! AnyObject
                } else {
                    param["inOriginalBox"] = 0 as! AnyObject
                }
                
                if let couponCode = bidAskModel.couponCode {
                    param["couponCode"] = couponCode as! AnyObject
                }
                
                
                
                
                
                
                APICall.updateBid(param: param) { (response) in
                    self.dismissProgress(for: self.view)
                    if let response = response {
                        if response.status! {
                            self.navigationController?.popViewController(animated: true)
                        } else {
                            self.showDialog(title: "Update Bid", message: "Your bid update is failed")
                        }
                    } else {
                        self.showDialog(title: "Update Bid", message: "Your bid update is failed")
                    }
                }
            } else {
                    param["qty"] = bidAskModel.quantity as! AnyObject
                    param["expire"] = bidAskModel.bidAskExpiraryDay as! AnyObject
                    param["directSell"] = bidAskModel.directBuy as! AnyObject
                    param["ask_id"] = bidAskModel.askBidId! as! AnyObject
                    param["postFrom"] = 3 as! AnyObject
                    
                    if bidAskModel.isInOriginalBox {
                        param["inOriginalBox"] = 1 as! AnyObject
                    } else {
                        param["inOriginalBox"] = 0 as! AnyObject
                    }
                    
                    if let couponCode = bidAskModel.couponCode {
                        param["couponCode"] = couponCode as! AnyObject
                    }
                    
                    APICall.updateAsk(param: param) { (resp) in
                        self.dismissProgress(for: self.view)
                        if let response = resp {
                            if response.status! {
                                self.navigationController?.popViewController(animated: true)
                            } else {
                                self.showDialog(title: "Update Ask", message: "Your ask update is failed")
                            }
                        } else {
                            self.showDialog(title: "Update Ask", message: "Your ask update is failed")
                        }
                    }
        }
    }

}

extension BuySellVC: BuySellPopupDelegate {
    func btnUpdateExistingClicked() {
        
        performSegue(withIdentifier: "toBuyingSelling", sender: nil)
    }
    
    func btnConfirmClicked() {
        if bidAskModel.value > 10.0 {
            performSegue(withIdentifier: "toConfirmBuySell", sender: self)
        } else {
            showDialog(title: "", message: "\(bidAskModel.isAskBidStr) Value can't be empty or 0")
        }
    }
}


extension BuySellVC: BidAskPopupDelegate {
    func bidasKbtnUpdateExistingClicked() {
        
        performSegue(withIdentifier: "toBuyingSelling", sender: nil)
    }
    
    func bidasKbtnConfirmClicked() {
        if bidAskModel.value > 10.0 {
            performSegue(withIdentifier: "toConfirmBuySell", sender: self)
        } else {
            showDialog(title: "", message: "\(bidAskModel.isAskBidStr) Value can't be empty or 0")
        }
    }
    
    
    //Mark:- Any action can be done here while the view contrtollar will be disapper.
    override func viewWillDisappear(_ animated: Bool)
    {
        //Mark:- when going to CurrentAskBidVc it will make the tab bar active for the vc
        if bidAskModel.isEdit == true{
            self.tabBarController?.tabBar.isHidden = false
        }
        
        
    } //Mark:- End of vieDisapear function
    
}



extension UIColor {
    convenience init(hexFromString:String, alpha:CGFloat = 1.0) {
        var cString:String = hexFromString.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        var rgbValue:UInt32 = 10066329 //color #999999 if string has wrong format
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) == 6) {
            Scanner(string: cString).scanHexInt32(&rgbValue)
        }
        
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
}

extension Date {
    
    /// Returns a Date with the specified amount of components added to the one it is called with
    func add(years: Int = 0, months: Int = 0, days: Int = 0, hours: Int = 0, minutes: Int = 0, seconds: Int = 0) -> Date? {
        let components = DateComponents(year: years, month: months, day: days, hour: hours, minute: minutes, second: seconds)
        return Calendar.current.date(byAdding: components, to: self)
    }
    
    /// Returns a Date with the specified amount of components subtracted from the one it is called with
    func subtract(years: Int = 0, months: Int = 0, days: Int = 0, hours: Int = 0, minutes: Int = 0, seconds: Int = 0) -> Date? {
        return add(years: -years, months: -months, days: -days, hours: -hours, minutes: -minutes, seconds: -seconds)
    }
    
}
