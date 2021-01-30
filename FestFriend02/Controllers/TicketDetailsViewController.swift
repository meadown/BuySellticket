//
//  TicketDetailsViewController.swift
//  FestFriend02
//
//  Created by MySoftheaven BD on 13/10/18.
//  Copyright © 2018 MySoftheaven BD. All rights reserved.
//

import UIKit

class TicketDetailsViewController: UIViewController {
    
    @IBOutlet weak var bidButton: UIButton!
    @IBOutlet weak var askButton: UIButton!
    @IBOutlet weak var buttonContainerView: UIView!{
        didSet{
            buttonContainerView.layer.cornerRadius = 5.0
            buttonContainerView.layer.borderColor = UIColor.darkGray.cgColor
            buttonContainerView.layer.borderWidth = 0.15
            
        }
    }
    
    @IBOutlet weak var ticketDetailsTableView: UITableView! {
        didSet {

            
            ticketDetailsTableView.register(UINib(nibName: String(describing: TicketBannerTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: TicketBannerTableViewCell.self))
            ticketDetailsTableView.register(UINib(nibName: String(describing: TicketInfoTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: TicketInfoTableViewCell.self))
            ticketDetailsTableView.register(UINib(nibName: String(describing: TicketsShowingTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: TicketsShowingTableViewCell.self))
        }
    }
    
    @IBOutlet weak var backBarButton: UIBarButtonItem!
    @IBOutlet weak var followBarButton: UIBarButtonItem!
    @IBOutlet weak var shareBarBtn: UIBarButtonItem!
    @IBOutlet weak var btnGoToBuyBid: UIButton!
    
    var lblTitle: UILabel?
    
    var ticketId: Int!
    var ticketDetails: TicketDetails?
    var typeFlag: Int!
    var bidAskModel = BidAskModel()
    
    private let btnStates:[UIControlState] = [.normal, .highlighted, .disabled, .selected, .focused, .application, .reserved]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.ticketDetailsTableView.delegate = self
        self.ticketDetailsTableView.dataSource = self
        ticketDetailsTableView.estimatedRowHeight = 150
        ticketDetailsTableView.rowHeight = UITableViewAutomaticDimension
        // to transparent the navigation controller
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        // to remove the border line or shadow image of navigation bar
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.ticketDetailsTableView.contentInset = UIEdgeInsetsMake(-88, 0, 0, 0)
        //self.festivalTableView.scrollIndicatorInsets = UIEdgeInsetsMake(-64, 0, 0, 0)
        
        //MARK:- change the color and the font of the title
        let titleAttributes = [
            NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14 , weight: UIFont.Weight.heavy),
            NSAttributedStringKey.foregroundColor: UIColor.white
        ]
        self.navigationController?.navigationBar.titleTextAttributes = titleAttributes
        lblTitle = setMultilineTitle(title: "")
        lblTitle?.textColor = UIColor.white
        
        self.configureButtons()
        
        
        
        
        getTicketDetails()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //hide the navigationbar
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.barStyle = .blackTranslucent
    }
    
    private func configureButtons() {
        self.bidButton.backgroundColor = UIColor(hex: "76D672")
        self.bidButton.tintColor = UIColor.white
        self.bidButton.layer.cornerRadius = 5.0
        self.askButton.backgroundColor = UIColor(hex: "ffffff")
        self.askButton.layer.cornerRadius = 5.0
        self.askButton.tintColor = UIColor.black
        
        if typeFlag == 0 {
            bidBtnSelectedState()
            
        } else {
            askBtnSelectedState()
        }
        btnGoToBuyBid.makeItFAB()
    }
    
    
    private func getTicketDetails() {
        showProgress(on: view)
        APICall.getTicketDetails(id: ticketId) { (details) in
            DispatchQueue.main.async {
                self.dismissProgress(for: self.view)
                if let details = details {
                    self.ticketDetails = details.ticketDetails
                    //self.title = "\(details.ticketDetails!.festivalShortName!) \(details.ticketDetails!.festivalYear!) - \(details.ticketDetails!.festivalSubName!) \(details.ticketDetails!.ticketTier!)"
                    self.lblTitle?.text = "\(details.ticketDetails!.festivalShortName!) \(details.ticketDetails!.festivalSubName!) - \(details.ticketDetails!.festivalYear!)\n\(details.ticketDetails!.ticketTier!)"
                    
                    self.bidAskModel.headerImgUrl = details.ticketDetails?.imageURL
                    self.bidAskModel.ticketId = self.ticketDetails?.id
                    if let highestBid = details.ticketDetails?.highestBid, !highestBid.isEmpty {
                        self.bidAskModel.highestBid = Int(highestBid)
                    }
                    
                    if let lowestAsk = details.ticketDetails?.lowestAsk, !lowestAsk.isEmpty {
                        self.bidAskModel.lowestAsk = Int(lowestAsk)
                    }
                    
                    self.bidAskModel.shortName = self.ticketDetails?.festivalShortName
                    self.bidAskModel.subname = self.ticketDetails?.festivalSubName
                    self.bidAskModel.year = self.ticketDetails?.festivalYear
                    self.bidAskModel.tier = self.ticketDetails?.ticketTier
                    self.bidAskModel.releaseDate = self.ticketDetails?.releaseDate
                    self.bidAskModel.cutOffDate = self.ticketDetails?.shippingcutoff ?? ""
                   self.bidAskModel.bidasksalescutoff = self.ticketDetails?.bidasksalescutoff ?? ""
                    if self.typeFlag == 0 {
                        self.bidBtnSelectedState()
                    } else {
                        self.askBtnSelectedState()
                    }
                    self.ticketDetailsTableView.reloadData()
                }
            }
        }
    }
    
    @IBAction func placeBidButtonAction(_ sender: Any) {
        bidBtnSelectedState()
    }
    
    private func bidBtnSelectedState() {
        typeFlag = 0
        bidAskModel.isBid = true
        bidButton.backgroundColor = UIColor.appGreenColor
        bidButton.setTitle("Buy or Place Bid", for: .normal)
        bidButton.setTitleColor(UIColor.white, for: .normal)
        btnGoToBuyBid.backgroundColor = UIColor.appGreenColor
        askBtnDeselectedState()
    }
    
    private func bidBtnDeselectedState() {
        bidButton.backgroundColor = UIColor.white
        
        var title = "Highest Bid: $"
        if let highestBid = ticketDetails?.highestBid {
            title.append(highestBid)
        } else {
            title.append("--")
        }
        
        bidButton.setTitle(title, for: .normal)
        bidButton.setTitleColor(UIColor.black, for: .normal)
    }
    
    @IBAction func placeAskButtonAction(_ sender: Any) {
        askBtnSelectedState()
    }
    
    private func askBtnSelectedState() {
        typeFlag = 1
        bidAskModel.isBid = false
        askButton.backgroundColor = UIColor.appRedColor
        askButton.setTitle("Sell or Place Ask", for: .normal)
        askButton.setTitleColor(UIColor.white, for: .normal)
        btnGoToBuyBid.backgroundColor = UIColor.appRedColor
        bidBtnDeselectedState()
    }
    
    private func askBtnDeselectedState() {
        askButton.backgroundColor = UIColor.white
        
        var title = "Lowest Ask: $"
        if let lowestAsk = ticketDetails?.lowestAsk {
           title.append(lowestAsk)
        } else {
            title.append("--")
        }
         askButton.setTitle(title, for: .normal)
        askButton.setTitleColor(UIColor.black, for: .normal)
    }
    
    @IBAction func backBarBtnAction(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnGoToBuyBidAction(_ sender: UIButton) {
        performSegue(withIdentifier: "tobuybid", sender: nil)
    }
    
    @IBAction func btnViewAllAskAction(_ sender: UIButton) {
        showAllSalesAskBids(tag: 2)
    }
    
    @IBAction func btnViewAllBidsAction(_ sender: UIButton) {
        showAllSalesAskBids(tag: 3)
    }
    
    @IBAction func followBtnAction(_ sender: UIBarButtonItem) {
        if let ticketId = ticketDetails?.id {
            makeFavorite(from: self, for: ticketId, type: 1)
        }
    }
    
    @IBAction func shareBtnAction(_ sender: UIBarButtonItem) {
        shareApp(from: self)
    }
    
    private func showAllSalesAskBids(tag: Int) {
//        if LocalPersistance.getUserId() == 0 {
//            showDialog(title: "", message: "You need to log in first to see all Ask and bids")
//        } else {
            performSegue(withIdentifier: "toViewAskOrBids", sender: tag)
        //}
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier!.elementsEqual("toViewAskOrBids") {
            let destVC = segue.destination as! ViewSalesAsksBidsVC
            destVC.selectedOption = sender as! Int
            destVC.ticketId = ticketId
            destVC.quantity = bidAskModel.quantity
            destVC.ticketName = title
        } else if segue.identifier!.elementsEqual("tobuybid") {
            let destVC = segue.destination as! BuySellVC
            destVC.bidAskModel = bidAskModel
            //destVC.vcTitle = title!
        } else if segue.identifier!.elementsEqual("toQuantityVC") {
            let destVC = segue.destination as! QuantityVC
            destVC.delegate = self
            destVC.type = typeFlag
        }
    }

}


extension TicketDetailsViewController : UITableViewDataSource, UITableViewDelegate,
TicketDetailsDelegate, TicketInfoTVCCellDelegate, TicketBannerTVCDelegate, QuantityVCDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if ticketDetails != nil {
            if let products = ticketDetails?.relatedProducts, products.count > 0 {
                return 3
            } else {
                return 2
            }
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            return getTicketBannner(with: indexPath)
        case 1:
            return getTicketInfo(with: indexPath)
        case 2:
            return getRelatedProducts(with: indexPath)
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            let height = tableView.frame.height / 2 
            return height
        case 2:
            return 300
//        case 1:
//            return tableView.frame.height - 64
//        case 2:
//            let height = tableView.frame.height / 2 + 100
//            return height
        default:
            return UITableViewAutomaticDimension
        }
    }
    
    func getTicketBannner(with indexpath: IndexPath) -> TicketBannerTableViewCell {
        let cell  = ticketDetailsTableView.dequeueReusableCell(withIdentifier: String(describing: TicketBannerTableViewCell.self), for: indexpath) as! TicketBannerTableViewCell
        cell.delegate = self
        
        if let imgUrl = ticketDetails?.imageURL, let url = URL(string: imgUrl)  {
            cell.ticketImageView.sd_setImage(with: url)
        }
        return cell
    }
    
    func getTicketInfo(with indexpath: IndexPath) -> TicketInfoTableViewCell {
        let cell  = ticketDetailsTableView.dequeueReusableCell(withIdentifier: String(describing: TicketInfoTableViewCell.self), for: indexpath) as! TicketInfoTableViewCell
        cell.delegate = self
        cell.configureCell(with: ticketDetails!)
        return cell
    }
    
    func getRelatedProducts(with indexPath: IndexPath) -> TicketsShowingTableViewCell {
        let releaseCalendarCell = ticketDetailsTableView.dequeueReusableCell(withIdentifier: String(describing: TicketsShowingTableViewCell.self), for: indexPath) as! TicketsShowingTableViewCell
        releaseCalendarCell.selectionStyle = .none
        releaseCalendarCell.sectionHeaderLabel.text = "Related Products"
        releaseCalendarCell.mTicketDetailsDelegate = self
        releaseCalendarCell.seeAllButton.isHidden = true
        releaseCalendarCell.configureCell(with: ticketDetails!.relatedProducts!)
        return releaseCalendarCell
    }
    
    
    //heere is the main issue for the nav bar aspps
    
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
//        if scrollView == self.ticketDetailsTableView {
//            print(scrollView.contentOffset.y)
//            print("rregre \(scrollView.frame.height / 2 - 65)")
//            if scrollView.contentOffset.y <= scrollView.frame.height / 2 - 100
//            {
//                // to transparent the navigation controller
//                self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//                self.navigationController?.navigationBar.isTranslucent = true
//                // to remove the border line or shadow image of navigation bar
//                self.navigationController?.navigationBar.shadowImage = UIImage()
//                let titleAttributes = [
//                    NSAttributedStringKey.font: UIFont.systemFont(ofSize: 15 , weight: UIFont.Weight.heavy),
//                    NSAttributedStringKey.foregroundColor: UIColor.white
//                ]
//                self.navigationController?.navigationBar.titleTextAttributes = titleAttributes
//                lblTitle?.textColor = UIColor.white
//                navigationController?.navigationBar.barStyle = .blackTranslucent
//                backBarButton.tintColor = UIColor.white
//                followBarButton.tintColor = UIColor.white
//                shareBarBtn.tintColor = UIColor.white
//            }
//            else {
//                self.navigationController?.navigationBar.setBackgroundImage(UIImage.imageWithColor(color: UIColor.white), for: .default)
//                self.navigationController?.navigationBar.isTranslucent = true
//                let titleAttributes = [
//                    NSAttributedStringKey.font: UIFont.systemFont(ofSize: 15 , weight: UIFont.Weight.bold),
//                    NSAttributedStringKey.foregroundColor: UIColor.black
//                ]
//                self.navigationController?.navigationBar.titleTextAttributes = titleAttributes
//                lblTitle?.textColor = UIColor.black
//                navigationController?.navigationBar.barStyle = .default
//                backBarButton.tintColor = UIColor.black
//                followBarButton.tintColor = UIColor.black
//                shareBarBtn.tintColor = UIColor.black
//            }
//
//        }
        
        
        if scrollView == self.ticketDetailsTableView {
            print(scrollView.contentOffset.y)
            print("rregre \(scrollView.frame.height / 2 + 100 - 65)")
            if scrollView.contentOffset.y <= 200
            {
                // to transparent the navigation controller
                self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
                self.navigationController?.navigationBar.isTranslucent = true
                // to remove the border line or shadow image of navigation bar
                //self.navigationController?.navigationBar.shadowImage = UIImage()
                let titleAttributes = [
                    NSAttributedStringKey.font: UIFont.systemFont(ofSize: 15 , weight: UIFont.Weight.heavy),
                    NSAttributedStringKey.foregroundColor: UIColor.white
                ]
                self.navigationController?.navigationBar.titleTextAttributes = titleAttributes
                navigationController?.navigationBar.barStyle = .blackTranslucent
                lblTitle?.textColor = UIColor.white
                backBarButton.tintColor = UIColor.white
                followBarButton.tintColor = UIColor.white
                shareBarBtn.tintColor = UIColor.white
            }
            else {
                self.navigationController?.navigationBar.setBackgroundImage(UIImage.imageWithColor(color: UIColor(hex: "ffffff")), for: .default)
                self.navigationController?.navigationBar.isTranslucent = false
                let titleAttributes = [
                    NSAttributedStringKey.font: UIFont.systemFont(ofSize: 15 , weight: UIFont.Weight.bold),
                    NSAttributedStringKey.foregroundColor: UIColor.black
                ]
                self.navigationController?.navigationBar.titleTextAttributes = titleAttributes
                self.navigationController?.navigationBar.barStyle = .default
                lblTitle?.textColor = UIColor.black
                backBarButton.tintColor = UIColor.black
                followBarButton.tintColor = UIColor.black
                shareBarBtn.tintColor = UIColor.black
            }
            
        }
        
    }
    
    func relatedProductsTapped(cell: UITableViewCell, indexPath: IndexPath) {
        self.ticketId = self.ticketDetails?.relatedProducts![indexPath.row].ticketID!
        getTicketDetails()
    }
    
    func viewAllSalesTapped() {
        showAllSalesAskBids(tag: 1)
    }
    
    func lblConditionTapped(cell: TicketInfoTableViewCell) {
        
        let alert = UIAlertController(title: "Condition", message: "", preferredStyle: .actionSheet)
        
        let inOriginalBoxAction = UIAlertAction(title: "In Original Box", style: .default) { (action) in
            cell.lblCondition.text = "Condition: In Original Box"
            self.bidAskModel.isInOriginalBox = true
        }
        alert.addAction(inOriginalBoxAction)
        
        let wristbandOnlyAction = UIAlertAction(title: "Wrist Band Only", style: .default) { (action) in
            cell.lblCondition.text = "Condition: Wrist Band Only"
            self.bidAskModel.isInOriginalBox = false
        }
        alert.addAction(wristbandOnlyAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
    func btnSelectQuantityTapped(cell: UITableViewCell) {
        performSegue(withIdentifier: "toQuantityVC", sender: self)
    }
    
    func lblNameYearTapped() {
        
        var festDetailsVC: FestivalViewController?
        
        for vc in (navigationController?.viewControllers)! {
            if vc is FestivalViewController {
                festDetailsVC = vc as! FestivalViewController
                break
            }
        }
        
        if festDetailsVC != nil {
            navigationController?.popToViewController(festDetailsVC!, animated: true)
        } else {
            print("Should implement")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let festivalVC = storyboard.instantiateViewController(withIdentifier: String(describing: FestivalViewController.self)) as! FestivalViewController
            festivalVC.festivalId = ticketId
            self.navigationController?.pushViewController(festivalVC, animated: true)
        }
        
    }
    
    func quantitySelected(quantity: Int) {
        let cell = ticketDetailsTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! TicketBannerTableViewCell
        cell.selectQunatityButtton.setTitle("Select Quantity: \(quantity)", for: .normal)
        bidAskModel.quantity = quantity
    }
    
}



protocol TicketDetailsDelegate {
    func relatedProductsTapped(cell: UITableViewCell, indexPath: IndexPath)
}
