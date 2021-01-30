//
//  CurrentAsksBidsVC.swift
//  FestFriend0
//  Copyright © 2019 MySoftheaven BD. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class CurrentAsksBidsVC: UIViewController, IndicatorInfoProvider {
    
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    
    @IBOutlet weak var tableview: UITableView!

    var isBuying = false
    
    var currentAsks: [CurrentAsk]?
    var currentBids: [CurrentBid]?
    
     var ticketDetails: TicketDetails?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = false // Mark :- make taqb bar show if have any
        if isBuying {
            lblAmount.text = "BID AMNT"
            lblDate.text = "BID EXP"
        } else {
            lblAmount.text = "ASK AMNT"
            lblDate.text = "ASK EXP"
        }
        DispatchQueue.main.async {
            self.tableview.reloadData()
        }
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "toBuySellVC":
                let indexpath = sender as! IndexPath
                var bidAskModel = BidAskModel()
                let destVC = segue.destination as! BuySellVC
                
                if isBuying {
                    let currentBid = currentBids![indexpath.row]
                    bidAskModel = prepareBidAskModel(with: currentBid)
                } else {
                    let currentAsk = currentAsks![indexpath.row]
                    bidAskModel = prepareBidAskModel(with: currentAsk)
                }
                bidAskModel.isEdit = true
                destVC.bidAskModel = bidAskModel
            case "toBidAskDetails":
                let indexPath = sender as! IndexPath
                
                if isBuying {
                    let currentBid = currentBids![indexPath.row]
                    let destVC = segue.destination as! AskBidDetailsVC
                    destVC.currentBid = currentBid
                } else {
                    let currentAsk = currentAsks![indexPath.row]
                    let destVC = segue.destination as! AskBidDetailsVC
                    destVC.currentAsk = currentAsk
                }
            default:
                print("")
            }
        }
    }
    
    private func prepareBidAskModel(with bid: CurrentBid) -> BidAskModel {
        let bidAskModel = BidAskModel()
        
        bidAskModel.askBidId = bid.bidId
        bidAskModel.isBid = true
        bidAskModel.editableValue = Double(bid.bidAmount!)!
        bidAskModel.bidAskExpiraryDay = Int(bid.expireIn!)!
        bidAskModel.headerImgUrl = bid.imageUrl
        bidAskModel.ticketId = Int(bid.ticketId!)// i need it
        bidAskModel.highestBid = Int(bid.highestBidAll!)
        bidAskModel.lowestAsk = Int(bid.lowestAskAll!)
        bidAskModel.shortName = bid.festivalShortName
        bidAskModel.subname = bid.festivalSubName
        bidAskModel.year = bid.festivalYear
        bidAskModel.tier = bid.festivaltire
        bidAskModel.value = Double(bid.bidAmount!)!
        
        //Mark:- Code for dates0
        
        APICall.getTicketDetails(id: Int(bid.ticketId!) ?? 0) { (details) in
                   DispatchQueue.main.async {
            if let details = details {
               self.ticketDetails = details.ticketDetails
                bidAskModel.releaseDate = self.ticketDetails?.releaseDate
                bidAskModel.bidasksalescutoff = self.ticketDetails?.shippingcutoff ?? ""
                
                    }
            }
        }
        
        if bid.inOriginalBox!.elementsEqual("1") {
            bidAskModel.isInOriginalBox = true
        } else {
            bidAskModel.isInOriginalBox = false
        }
        
        return bidAskModel
    }
    
    private func prepareBidAskModel(with ask: CurrentAsk) -> BidAskModel {
        let bidAskModel = BidAskModel()
        
        bidAskModel.askBidId = ask.askId
        bidAskModel.isBid = false
        bidAskModel.editableValue = Double(ask.askAmount!)!
        bidAskModel.bidAskExpiraryDay = Int(ask.expireIn!)!
        bidAskModel.headerImgUrl = ask.imageUrl
        bidAskModel.ticketId = Int(ask.ticketId!)
        bidAskModel.highestBid = Int(ask.highestBidAll!)
        bidAskModel.lowestAsk = Int(ask.lowestAskAll!)
        bidAskModel.shortName = ask.festivalShortName
        bidAskModel.subname = ask.festivalSubName
        bidAskModel.year = ask.festivalYear
        bidAskModel.tier = ask.festivaltire
        bidAskModel.value = Double(ask.askAmount!)!
        
        //Mark:- Code for dates Edited

        APICall.getTicketDetails(id: Int(ask.ticketId!) ?? 0) { (details) in
                   DispatchQueue.main.async {
            
            if let details = details {
                self.ticketDetails = details.ticketDetails
                bidAskModel.releaseDate = self.ticketDetails?.releaseDate
                bidAskModel.bidasksalescutoff = self.ticketDetails?.shippingcutoff ?? ""
                
                    }
            }
        }
        if ask.inOriginalBox!.elementsEqual("1") {
            bidAskModel.isInOriginalBox = true
        } else {
            bidAskModel.isInOriginalBox = false
        }
        
        return bidAskModel
    }
    
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        if isBuying {
            return "Current Bids"
        } else {
            return "Current Asks"
        }
    }

}

extension CurrentAsksBidsVC: UITableViewDataSource, UITableViewDelegate, AsksBidsTVCDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isBuying {
            if currentBids == nil || currentBids!.count == 0 {
                return 0
            } else {
                return currentBids!.count
            }
        } else {
            if currentAsks == nil || currentAsks!.count == 0 {
                return 0
            } else {
                return currentAsks!.count
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AskBidCell", for: indexPath) as! AsksBidsTvc
        cell.delegate = self
        
        if isBuying {
            let currentBid = currentBids![indexPath.row]
            cell.configure(with: currentBid)
        } else {
            let currentAsk = currentAsks![indexPath.row]
            cell.configure(with: currentAsk)
        }
        
        return cell
    }
    
    func deleteTapped(cell: UITableViewCell) {
        let indexPath = tableview.indexPath(for: cell)
        var param = ["user_id": LocalPersistance.getUserId()] as! [String: AnyObject]
        
        var bidAsk = isBuying ? "Bid" : "Ask"
        
        let alert = UIAlertController(title: "Delete \(bidAsk)", message: "Are you sure to cancel this \(bidAsk)?", preferredStyle: .alert)
        
        let yesAction = UIAlertAction(title: "Yes", style: .default) { (action) in
            if self.isBuying {
                let bid = self.currentBids![indexPath!.row]
                param["bid_id"] = bid.bidId! as! AnyObject
                self.showProgress(on: self.view)
                APICall.deleteUserBid(param: param) { (response) in
                    self.dismissProgress(for: self.view)
                    if let response = response {
                        if response.status! {
                            self.currentBids?.remove(at: indexPath!.row)
                            self.tableview.deleteRows(at: [indexPath!], with: .automatic)
                        }
                    }
                }
            } else {
                let ask = self.currentAsks![indexPath!.row]
                param["ask_id"] = ask.askId! as! AnyObject
                self.showProgress(on: self.view)
                APICall.deleteUserAsk(param: param) { (response) in
                    self.dismissProgress(for: self.view)
                    if let response = response {
                        if response.status! {
                            self.currentAsks?.remove(at: indexPath!.row)
                            self.tableview.deleteRows(at: [indexPath!], with: .automatic)
                        }
                    }
                }
            }
        }
        
        alert.addAction(yesAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(cancelAction)
        present(alert, animated: true)
        
    }
    
    func editTapped(cell: UITableViewCell) {
        let indexPath = tableview.indexPath(for: cell)!
        performSegue(withIdentifier: "toBuySellVC", sender: indexPath)
        print("Edit tapped")
    }
    
    func detailsTapped(cell: UITableViewCell) {
        
        let indexPath = tableview.indexPath(for: cell)
        performSegue(withIdentifier: "toBidAskDetails", sender: indexPath)
        print("Details tapped")
    }
}


