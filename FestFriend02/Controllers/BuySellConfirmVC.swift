    //
//  BuySellConfirmVC.swift
//  FestFriend02
//  Copyright © 2019 MySoftheaven BD. All rights reserved.
//

import UIKit

class BuySellConfirmVC: UIViewController {
    
    @IBOutlet weak var lblHeading: UILabel!
    @IBOutlet weak var lblHeadingDetails: UILabel!
    @IBOutlet weak var lblFestivalShortName: UILabel!
    @IBOutlet weak var lblFestivalSubNameYear: UILabel!
    @IBOutlet weak var lblTier: UILabel!
    @IBOutlet weak var lblQuantity: UILabel!
    @IBOutlet weak var lblAskBidLabel: UILabel!
    @IBOutlet weak var lblAskBidValue: UILabel!
    @IBOutlet weak var lblShippingValue: UILabel!
    @IBOutlet weak var lblAuthLabel: UILabel!
    @IBOutlet weak var lblAuthValue: UILabel!
    @IBOutlet weak var lblPaymentProcessingLabel: UILabel!
    @IBOutlet weak var lblPaymentProcessingValue: UILabel!
    @IBOutlet weak var lblCouponLabel: UILabel!
    @IBOutlet weak var lblCouponValue: UILabel!
    @IBOutlet weak var lblTotalAmountLabel: UILabel!
    @IBOutlet weak var lblTotalAmount: UILabel!
    @IBOutlet weak var lblShipingAddress: UILabel!
    @IBOutlet weak var lblPaymentMethod: UILabel!
    @IBOutlet weak var lblIsInOriginalBox: UILabel!
    @IBOutlet weak var btnConfirmAskBid: UIButton!
    @IBOutlet weak var paymentProcessingContainer: UIStackView!
    @IBOutlet weak var imgHeader: UIImageView!
    
    @IBOutlet weak var check1: CheckboxButton!
    @IBOutlet weak var check2: CheckboxButton!
    
    @IBOutlet weak var bottomTextHint: UIStackView!
    
    @IBOutlet weak var termsOne: UILabel!
    @IBOutlet weak var termsTwo: UILabel!
    
    //constraintsoutlate
    @IBOutlet weak var shippingIconConst: NSLayoutConstraint!
    @IBOutlet weak var shippingAddressTitleConst: NSLayoutConstraint!
    
    
    var bidAskModel: BidAskModel!

    var cardlastfour = " "
    var address = " "
    override func viewDidLoad() {
        super.viewDidLoad()
        
        populateData()
        getShipingAddress()
        getPayout()
       
        setupLabelTerms()
        setupLabelTermsTwo()


    }
    
    fileprivate func setupLabelTerms() {
      
        termsOne.text = "By signing up, you agree to our payment processing partner Stripe's Terms of Service and Privacy Policy."
        let text = (termsOne.text)!
        let underlineAttriString = NSMutableAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor: UIColor.black ,
                                                                                        NSAttributedString.Key.font: UIFont(name: "Helvetica Neue", size: 14) as Any])
        
        let range1 = (text as NSString).range(of: "Stripe's Terms of Service")
        underlineAttriString.addAttribute(NSAttributedStringKey.underlineStyle, value: NSUnderlineStyle.styleSingle.rawValue, range: range1)
        underlineAttriString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.blue, range: range1)
        

        let range2 = (text as NSString).range(of: "Privacy Policy")
        underlineAttriString.addAttribute(NSAttributedStringKey.underlineStyle, value: NSUnderlineStyle.styleSingle.rawValue, range: range2)
        underlineAttriString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.blue, range: range2)
        termsOne.attributedText = underlineAttriString
        termsOne.isUserInteractionEnabled = true
        termsOne.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(tapLabel(gesture:))))
    }
    fileprivate func setupLabelTermsTwo() {
        termsTwo.text = "By clicking Confirm, you agree to sell the designated product at the specified price, in accordance with the FestFriends Terms & Conditions of Use and Seller Policies, which you have reviewed. You certify that you have legitimate ticket(s) which you have agreed to sell, and will ship within the time required. "
        let text = (termsTwo.text)!
        let underlineAttriString = NSMutableAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor: UIColor.black,
                                                                                        NSAttributedString.Key.font: UIFont(name: "Helvetica Neue", size: 14) as Any])
        
        
        let range1 = (text as NSString).range(of:"Terms & Conditions")
        underlineAttriString.addAttribute(NSAttributedStringKey.underlineStyle, value: NSUnderlineStyle.styleSingle.rawValue, range: range1)
        underlineAttriString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.blue, range: range1)
        
        let range2 = (text as NSString).range(of:"Seller Policies")
        underlineAttriString.addAttribute(NSAttributedStringKey.underlineStyle, value: NSUnderlineStyle.styleSingle.rawValue, range: range2)
        underlineAttriString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.blue, range: range2)
        
        termsTwo.attributedText = underlineAttriString
        termsTwo.isUserInteractionEnabled = true
        termsTwo.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(tapLabelTwo(gesture:))))
    }
    @IBAction func tapLabelTwo(gesture: UITapGestureRecognizer) {
        let text = (termsOne.text)!
                let termsRange = (text as NSString).range(of: "Terms & Conditions")
                let privacyRange = (text as NSString).range(of: "Seller Policies")
                
                if gesture.didTapAttributedTextInLabel(label: termsOne, inRange: termsRange) {
                  if let url = URL(string: "https://www.festfriends.app/terms"),
                      UIApplication.shared.canOpenURL(url) {
                     if #available(iOS 10.0, *) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    } else {
                        UIApplication.shared.openURL(url)
                       }
                   }
                } else if gesture.didTapAttributedTextInLabel(label: termsOne, inRange: privacyRange) {
                    if let url = URL(string: "https://www.festfriends.app/privacy"), UIApplication.shared.canOpenURL(url) {
                        if #available(iOS 10.0, *) {
                            UIApplication.shared.open(url, options: [:], completionHandler: nil)
                        } else {
                            UIApplication.shared.openURL(url)
                        }
                    }
                } else {
                    print("Tapped none")
                }
        
    }
    
    
    @IBAction func tapLabel(gesture: UITapGestureRecognizer) {
        let text = (termsOne.text)!
        let termsRange = (text as NSString).range(of: "Stripe's Terms of Service")
        let privacyRange = (text as NSString).range(of: "Privacy Policy")
        
        if gesture.didTapAttributedTextInLabel(label: termsOne, inRange: termsRange) {
//            if let url = URL(string: "https://www.festfriends.app/terms"),
//                UIApplication.shared.canOpenURL(url) {
//                if #available(iOS 10.0, *) {
//                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
//                } else {
//                    UIApplication.shared.openURL(url)
//                }
//            }
        } else if gesture.didTapAttributedTextInLabel(label: termsOne, inRange: privacyRange) {
            if let url = URL(string: "https://www.festfriends.app/privacy"), UIApplication.shared.canOpenURL(url) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(url)
                }
            }
        } else {
            print("Tapped none")
        }
    }
    
    
    private func populateData() {
        
        let titleAttributes = [
            NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14 , weight: UIFont.Weight.heavy),
            NSAttributedStringKey.foregroundColor: UIColor.black
        ]
        self.navigationController?.navigationBar.titleTextAttributes = titleAttributes
        self.setMultilineTitle(title: "\(bidAskModel.shortName!) \(bidAskModel.year!) - \(bidAskModel.subname!)\n\(bidAskModel.tier!)")
        //self.title = "\(bidAskModel.shortName!) \(bidAskModel.year!) - \(bidAskModel.subname!) \(bidAskModel.tier!)"
        
        if let imgStr = bidAskModel.headerImgUrl {
            let url = URL(string: imgStr)
            imgHeader.sd_setImage(with: url)
        }
        
        lblHeading.text = "\(bidAskModel.isAskBidStr) Details"
        
        if bidAskModel.directBuy > 0 {
            lblHeadingDetails.text = "Confirm your Sale details below"
        } else if bidAskModel.directSell > 0 {
            lblHeadingDetails.text = "Sale Now"
        } else {
           lblHeadingDetails.text = "Confirm your \(bidAskModel.isAskBidStr.lowercased()) details below"
        }
        
        lblFestivalShortName.text = bidAskModel.shortName != nil ? bidAskModel.shortName! : ""
        
        if let subName = bidAskModel.subname {
            if let year = bidAskModel.year {
                lblFestivalSubNameYear.text = "\(subName) | \(year)"
            } else {
                lblFestivalSubNameYear.text = subName
            }
        } else {
            lblFestivalSubNameYear.text = ""
        }
        
        lblTier.text = bidAskModel.tier != nil ? bidAskModel.tier! : ""
        lblQuantity.text = "Quantity: \(bidAskModel.quantity)"
        
        if bidAskModel.isAskBidStr == "Sale" || bidAskModel.isAskBidStr == "Ask"
        {
            lblAskBidLabel.text = "Your Ask"
        }
        else
        {
        lblAskBidLabel.text = "Your \(bidAskModel.isAskBidStr)"
        }
        
        
        lblAskBidValue.text = "$\(String(format: "%.2f", bidAskModel.value))"
        lblShippingValue.text = "$\(String(format: "%.2f", bidAskModel.shippingAmount))"
        
        if bidAskModel.isBid! {
            lblAuthLabel.text = "Authentication"
            paymentProcessingContainer.isHidden = true
            lblTotalAmountLabel.text = "Total (USD)"
        } else {
            lblAuthLabel.text = "Authentication (\(bidAskModel.authenticationRate)%)"
//            lblPaymentProcessingLabel.text = "Payment Processing (3%)"
            
            if(bidAskModel.paymentProcessingRate == nil) {
                lblPaymentProcessingLabel.text = "Payment Processing"
            } else {
                lblPaymentProcessingLabel.text = "Payment Processing (\(bidAskModel.paymentProcessingRate)% + $.30)"
            }
            
            lblTotalAmountLabel.text = "Net Payout"
        }
        
        lblAuthValue.text = "-$\(String(format: "%.2f", bidAskModel.authenticationAmount()))"
        lblPaymentProcessingValue.text = "-$\(String(format: "%.2f", bidAskModel.paymentProcessingAmount()))"
        lblTotalAmount.text = "$\(String(format: "%.2f", bidAskModel.totalAmount))"
        
        if bidAskModel.isInOriginalBox {
            lblIsInOriginalBox.text = "In Original Box"
        } else {
            lblIsInOriginalBox.text = "Wrist Band Only"
        }
        
        if bidAskModel.isBid! {
            self.bottomTextHint.alpha = 0
            btnConfirmAskBid.backgroundColor = UIColor.appGreenColor
            
        } else {
            self.bottomTextHint.alpha = 1
            btnConfirmAskBid.backgroundColor = UIColor.appRedColor
        }
        btnConfirmAskBid.setTitle("Confirm \(bidAskModel.isAskBidStr)", for: .normal)
    }
    
    private func getPayout() {
        showProgress(on: view)

        APICall.getUserPayout { (response) in
            if let response = response {
                self.dismissProgress(for: self.view)

                
                if let payout = response.payout {
                    print("got it again")
                 //   if payout.cardNumber != nil {
                        if self.bidAskModel.isAskBidStr == "Bid" || self.bidAskModel.isAskBidStr == "Purchase"
                        {
                            self.lblPaymentMethod.text = "Card ending in \(LocalPersistance.getCardNumberLast4()! as String)"
                            self.cardlastfour = LocalPersistance.getCardNumberLast4()! as String
                        }
                        else if self.bidAskModel.isAskBidStr == "Ask" || self.bidAskModel.isAskBidStr == "Sale"
                        {
                            self.lblPaymentMethod.text = payout.getFormatedAccountNumber()
                        }
                       // self.cardlastfour = String(payout.getlastfourofCardNumber())
                  //  }
                    else {
                        self.lblPaymentMethod.text = "Add Payment Method"
                    }
                }
                else {

                }
            }
            else {
            }
        }
    }
    //shipping cutoff check
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
    
    private func getShipingAddress() {
       // showProgress(on: view)

        //shipping cutoff check
        if let shippingCutoff = bidAskModel.cutOffDate, shouldbidsalesCutoff(bidslesCutoff: shippingCutoff) {
            
            //shippingIconConst.constant = 0
            shippingAddressTitleConst.constant = 0
            self.lblShipingAddress.text =  "This item is currently eligible for in person pick-up"
        }
        else
        {
            print("got it")
       // shippingIconConst.constant = 20
        shippingAddressTitleConst.constant = 120
        showProgress(on: view)
        APICall.getShipingAddresses { (response) in
            if let response = response {
                self.dismissProgress(for: self.view)

                if response.status! {
                    if let address = response.getActiveShipingAddress() {
                        self.lblShipingAddress.text = address.getFormatedAddress()
                        self.address = address.streetAddress! as String

                    } else {
                        self.lblShipingAddress.text = ""
                    }
                    
                } else {
                    self.lblShipingAddress.text = ""

                }
            } else {
                self.lblShipingAddress.text = ""

            }
        }
    
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier.elementsEqual("toLastConfirm") {
                let destVC = segue.destination as! ConfirmViewController
                destVC.bidAskModel = bidAskModel
            }
        }
    }
    
    
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func btnConfirmAction(_ sender: UIButton) {

        //Mark:- Shipping cutoff check
        guard let lblshipingAdd = lblShipingAddress.text, !(lblshipingAdd == "") else {
            showDialog(title: "Add Address", message: "Shipping Address is required.")
            return
        }
    
        var param = ["amount": Int(bidAskModel.value)] as! [String: AnyObject]
        
        //Get Stripe Token that was generate from payment method select options.
        let stripe_token = LocalPersistance.getStripeIdToken()
        param["stripe_token"] = stripe_token as AnyObject
        
        if bidAskModel.isBid! {
            param["user"] = LocalPersistance.getUserId() as! AnyObject //Mark:-Ned both for DirectBuy and BId
            
            if bidAskModel.isAskBidStr == "Purchase"{
                //Mark:- Code satart for Direct buy
        
                param["quantity"] = bidAskModel.quantity as! AnyObject
                param["expireIn"] = bidAskModel.bidAskExpiraryDay as! AnyObject
                param["directBuy"] = 1 as! AnyObject
                param["postFrom"] = 3 as! AnyObject
                param["ticket"] = bidAskModel.ticketId! as! AnyObject
                param["address"] = self.address as! AnyObject
                param["card_no"] = self.cardlastfour as! AnyObject
                
                
                if bidAskModel.isInOriginalBox {
                    param["inOriginalBox"] = 1 as! AnyObject
                } else {
                    param["inOriginalBox"] = 0 as! AnyObject
                }
                
                if let couponCode = bidAskModel.couponCode {
                    param["couponCode"] = couponCode as! AnyObject
                }
                showProgress(on: view)
                APICall.postBid(param: param) { (resp) in
                    //self.dismissProgress(for: self.view)//Mark:- will caled after strip Api Call
                    if let response = resp {
                        if response.status! {
                            guard let bidID = response.bidId else {
                                
                                return
                            }
                            self.Buy_postStrip(bidId: bidID)
                          
                        } else {
                            self.showDialog(title: "Post Bid", message: "Your bid posting is failed")
                        }
                    } else {
                        self.showDialog(title: "Post Bid", message: "Your bid posting is failed")
                    }
                }
            }//Mark:- Code End for direct Buy
            else {
                
               //Mark:- Code start for Bid
                
                param["quantity"] = bidAskModel.quantity as! AnyObject
                param["expireIn"] = bidAskModel.bidAskExpiraryDay as! AnyObject
                param["directBuy"] = bidAskModel.directBuy as! AnyObject
                param["ticket"] = bidAskModel.ticketId! as! AnyObject
                param["address"] = self.address as! AnyObject
                param["card_no"] = self.cardlastfour as! AnyObject
                
                if bidAskModel.isInOriginalBox {
                    param["inOriginalBox"] = 1 as! AnyObject
                } else {
                    param["inOriginalBox"] = 0 as! AnyObject
                }
                
                param["postFrom"] = 3 as! AnyObject
                
                if let couponCode = bidAskModel.couponCode {
                    param["couponCode"] = couponCode as! AnyObject
                }
                showProgress(on: view)
                APICall.postBid(param: param) { (resp) in
                   // self.dismissProgress(for: self.view)//Mark:- will caled after strip Api Call
                    if let response = resp {
                        if response.status! {
                            print("got it finally\(response) \n\n card last 4 : \(self.cardlastfour)")
                            guard let bidID = response.bidId else {
                                print(response)
                                return
                            }
                            self.postStrip(bidId: bidID)
        
                        } else {
                            self.showDialog(title: "Post Bid", message: "Your bid posting is failed")
                        }
                    } else {
                        self.showDialog(title: "Post Bid", message: "Your bid posting is failed")
                    }
                }
            }//Mark:- Code End for Post Bid
        }//Mark:- Code End for Direct Buy and Post Bid
        else {
            param["user_id"] = LocalPersistance.getUserId() as! AnyObject //Mark:-Ned both for Sale and Ask
            
            if bidAskModel.isAskBidStr == "Sale"{
                //Mark:- Code start for Sale
                
                param["quantity"] = bidAskModel.quantity as! AnyObject
                param["expireIn"] = bidAskModel.bidAskExpiraryDay as! AnyObject
                param["directSell"] = 1 as! AnyObject
                param["ticket_id"] = bidAskModel.ticketId! as! AnyObject
                param["address"] = self.address as! AnyObject
                param["card_no"] = self.cardlastfour as! AnyObject
                
                
                if bidAskModel.isInOriginalBox {
                    param["inOriginalBox"] = 1 as! AnyObject
                } else {
                    param["inOriginalBox"] = 0 as! AnyObject
                }
                
                param["postFrom"] = 3 as! AnyObject
                
                if let couponCode = bidAskModel.couponCode {
                    param["couponCode"] = couponCode as! AnyObject
                }
                if check1.isChecked , check2.isChecked {
                    showProgress(on: view)
                    APICall.postAsk(param: param) { (resp) in
                        self.dismissProgress(for: self.view)
                        if let response = resp {
                            if response.status! {
                                self.performSegue(withIdentifier: "toLastConfirm", sender: self)
                            } else {
                                self.showDialog(title: "Place Ask", message: "Your ask posting is failed")
                            }
                        } else {
                            self.showDialog(title: "Place Ask", message: "Your ask posting is failed")
                        }
                    }
                } else {
                    showDialog(title: "Confirm Sale", message: "Please agree to the Terms and Conditions.")

                }
               
            } //Mark:-Code End for sale
            else if bidAskModel.isAskBidStr == "Ask"{
                //Mark:- COde Start for Ask
                
                param["quantity"] = bidAskModel.quantity as! AnyObject
                param["expireIn"] = bidAskModel.bidAskExpiraryDay as! AnyObject
                param["directSell"] = bidAskModel.directBuy as! AnyObject
                param["ticket_id"] = bidAskModel.ticketId! as! AnyObject
                param["address"] = self.address as! AnyObject
                param["card_no"] = self.cardlastfour as! AnyObject
                
                if bidAskModel.isInOriginalBox {
                    param["inOriginalBox"] = 1 as! AnyObject
                } else {
                    param["inOriginalBox"] = 0 as! AnyObject
                }
                
                param["postFrom"] = 3 as! AnyObject
                
                if let couponCode = bidAskModel.couponCode {
                    param["couponCode"] = couponCode as! AnyObject
                }
                if check1.isChecked , check2.isChecked {
                    showProgress(on: view)
                    APICall.postAsk(param: param) { (resp) in
                        self.dismissProgress(for: self.view)
                        if let response = resp {
                            if response.status! {
                                self.performSegue(withIdentifier: "toLastConfirm", sender: self)
                            } else {
                                self.showDialog(title: "Place Ask", message: "Your ask posting is failed")
                            }
                        } else {
                            self.showDialog(title: "Place Ask", message: "Your ask posting is failed")
                        }
                    }
                } else {
                    showDialog(title: "Place Ask", message: "Please agree to the Terms and Conditions.")

                }
              
            }//Mark: Code end for post Ask
            
        }//Mark:- Code End for Sale and Post Ask
        
    }
    
     //Mark:- For Authorized buy stripe call
    fileprivate func postStrip(bidId : Int){
        guard let userName = LocalPersistance.getUserName() else {
           return
        }
        
        let stripe_token = LocalPersistance.getStripeIdToken()
        var param = [
            "amount": bidAskModel.totalAmount] as! [String: AnyObject]
        param["stripe_token"] = stripe_token as AnyObject
        param["cvvNumber"] = "123" as AnyObject
        param["ccExpiryYear"] = "2021" as AnyObject
        param["ccExpiryMonth"] = "11" as AnyObject
        param["card_no"] = "411111111111111" as AnyObject
        param["customer_name"] = userName as AnyObject
        param["festival_name"] = stripe_token as AnyObject
        param["bid_id"] = bidId as AnyObject

        APICall.stripAuthorize(param: param) { (response) in
           // print("need to work here")
            if response?.status == true
           {
           // print(response?.status)
            self.dismissProgress(for: self.view)
            self.performSegue(withIdentifier: "toLastConfirm", sender: self)
            }
            else
            {
                //print(response?.status)
                //print(response?.msg)
                self.dismissProgress(for: self.view)
                
                let dialogMessage = UIAlertController(title: "Place Bid Failed!!", message: response?.msg ?? "Please Check your Payment Card Details.", preferredStyle: .alert)
                
                // Create OK button with action handler for back to the view from where it is comming from
                let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                    
                    self.navigationController?.popViewController(animated: true)
                })
                
                dialogMessage.addAction(ok)
            
                // Present dialog message to user
                self.present(dialogMessage, animated: true, completion: nil)
                
                
                
                
            }
           
                                            }
        
    }//Mark:- For Authorized buy stripe call code End
    
    
    //Mark:- For direct buy stripe call
    fileprivate func Buy_postStrip(bidId : Int){
            guard let userName = LocalPersistance.getUserName() else {
               return
            }
            
            let stripe_token = LocalPersistance.getStripeIdToken()
            var param = [
                "amount": bidAskModel.totalAmount] as! [String: AnyObject]
            param["stripe_token"] = stripe_token as AnyObject
            param["cvvNumber"] = "123" as AnyObject
            param["ccExpiryYear"] = "2021" as AnyObject
            param["ccExpiryMonth"] = "11" as AnyObject
            param["card_no"] = "411111111111111" as AnyObject
            param["customer_name"] = userName as AnyObject
            param["festival_name"] = stripe_token as AnyObject
            param["bid_id"] = bidId as AnyObject
            

            APICall.stripDirectBuy(param: param) { (response) in
                // print("need to work here")
            if response?.status == true
            {
                //print(response?.status)
                self.dismissProgress(for: self.view)
                self.performSegue(withIdentifier: "toLastConfirm", sender: self)
            }
            else
            {
                //print(response?.status)
                //print(response?.msg)
                self.dismissProgress(for: self.view)
                
                let dialogMessage = UIAlertController(title: "Purchase Failed!!", message: response?.msg ?? "Please Check your Payment Card Details.", preferredStyle: .alert)
                
                // Create OK button with action handler for back to the view from where it is comming from
                let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                                   
                    self.navigationController?.popViewController(animated: true)
                })
                               
                dialogMessage.addAction(ok)
                           
                // Present dialog message to user
                    self.present(dialogMessage, animated: true, completion: nil)
            }
                                                }
        
        } //Mark:- For direct buy stripe call code End
    
    

}
    
