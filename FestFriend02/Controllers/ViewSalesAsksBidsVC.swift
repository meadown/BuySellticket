//
//  ViewSalesAsksBidsVC.swift
//  FestFriend02
//  Copyright © 2019 MySoftheaven BD. All rights reserved.
//

import UIKit
import DLRadioButton

class ViewSalesAsksBidsVC: UIViewController {
    
    @IBOutlet weak var lblPriceLabel: UILabel!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var btnSales: DLRadioButton!
    @IBOutlet weak var btnAsks: DLRadioButton!
    @IBOutlet weak var btnBids: DLRadioButton!
    @IBOutlet weak var lblNoDataFound: UILabel!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var headerViewTop: UIView!
    
    
    var ticketId: Int!
    var ticketName: String!
    var selectedOption: Int!
    var quantity: Int!
    
    var selectedOptionsLabels = ["SALE PRICE", "ASK AMOUNT", "BID AMOUNT"]
    
    var allSales: [AskOrSales]?
    var allAsks: [AskOrSales]?
    var allBids: [Bid]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch  selectedOption {
        case 1:
            btnSales.isSelected = true
        case 2:
            btnAsks.isSelected = true
        case 3:
            btnBids.isSelected = true
        default:
            print("Do nothing")
        }
        
        setupViews()
        getAllSalesAsksBids()
    }
    
    private func setupViews() {
        
        let titleAttributes = [
            NSAttributedStringKey.font: UIFont.systemFont(ofSize: 15 , weight: UIFont.Weight.heavy),
            NSAttributedStringKey.foregroundColor: UIColor.black
        ]
        self.navigationController?.navigationBar.titleTextAttributes = titleAttributes
        self.title = ticketName
        
        lblPriceLabel.text = selectedOptionsLabels[selectedOption - 1]
        
        headerView.layer.shadowOpacity = 0.5
        headerView.layer.shadowOffset = CGSize(width: 0, height: 3)
        
        headerViewTop.layer.shadowOpacity = 0.5
        headerViewTop.layer.shadowOffset = CGSize(width: 0, height: 2)
    }
    
    private func getAllSalesAsksBids() {
        showProgress(on: view)
        APICall.getAllSalesAsksBids(ticketId: ticketId, quantity: quantity) { (response) in
            self.dismissProgress(for: self.view)
            if let response = response {
                if response.status! {
                    if let allSales = response.allSales {
                        self.allSales = allSales
                    }
                    
                    if let allAsks = response.allAsks {
                        self.allAsks = allAsks
                    }
                    
                    if let allBids = response.allBids {
                        self.allBids = allBids
                    }
                    
                    self.tableview.reloadData()
                }
            }
        }
    }
    

    @IBAction func btnSalesAction(_ sender: DLRadioButton) {
        selectedOption = sender.tag
        lblPriceLabel.text = selectedOptionsLabels[selectedOption - 1]
        tableview.reloadData()
    }
    
    @IBAction func btnAsksAction(_ sender: DLRadioButton) {
        selectedOption = sender.tag
        lblPriceLabel.text = selectedOptionsLabels[selectedOption - 1]
        tableview.reloadData()
    }
    
    @IBAction func btnBidsAction(_ sender: DLRadioButton) {
        selectedOption = sender.tag
        lblPriceLabel.text = selectedOptionsLabels[selectedOption - 1]
        tableview.reloadData()
    }

    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}



extension ViewSalesAsksBidsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch selectedOption {
        case 1:
            if let allSales = allSales, allSales.count > 0 {
                lblNoDataFound.isHidden = true
                tableView.isHidden = false
                return allSales.count
            } else {
                lblNoDataFound.isHidden = false
                tableView.isHidden = true
                return 0
            }
        case 2:
            if let allAsks = allAsks, allAsks.count > 0 {
                lblNoDataFound.isHidden = true
                tableView.isHidden = false
                return allAsks.count
            } else {
                lblNoDataFound.isHidden = false
                tableView.isHidden = true
                return 0
            }
        case 3:
            if let allBids = allBids, allBids.count > 0 {
                lblNoDataFound.isHidden = true
                tableView.isHidden = false
                return allBids.count
            } else {
                lblNoDataFound.isHidden = false
                tableView.isHidden = true
                return 0
            }
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: String(describing: ViewBidsOrAskTVC.self), for: indexPath) as! ViewBidsOrAskTVC
        
        switch selectedOption {
        case 1:
            if let allSales = allSales {
                cell.configureCell(with: allSales[indexPath.row])
            }
        case 2:
            if let allAsks = allAsks {
               cell.configureCell(with: allAsks[indexPath.row])
            }
        case 3:
            if let allBids = allBids {
                cell.configureCell(with: allBids[indexPath.row])
            }
        default:
            return UITableViewCell()
        }
        
        return cell
    }
    
    
}
