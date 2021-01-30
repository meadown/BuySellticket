//
//  SearchViewController.swift
//  FestFriend02
//
//  Created by MySoftheaven BD on 30/9/18.
//  Copyright © 2018 MySoftheaven BD. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchResultTvc: UITableView!
    @IBOutlet weak var searchListTableView: UITableView!
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var searchListContainer: UIView!
    @IBOutlet weak var navigationContainer: UIView!
    
    var searchListdata = [String]()
    var searchResultData = [TicketFestival]()

    override func viewDidLoad() {
        super.viewDidLoad()

        txtSearch.addTarget(self, action: #selector(txtSearchTextChange(_:)), for: .editingChanged)
        txtSearch.addTarget(self, action: #selector(txtSearchTouched(_:)), for: .allTouchEvents)
        
        navigationContainer.layer.shadowOpacity = 0.5
        navigationContainer.layer.shadowOffset = CGSize(width: 1, height: 1)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func backBtnAction(_ sender: Any) {
        searchListContainer.isHidden = true
        //txtSearch.textAlignment = .center
        txtSearch.resignFirstResponder()
    }
    
    @objc func txtSearchTextChange(_ sender: UITextField) {
        let text = sender.text
        
        if text!.count > 1 {
            getSearchResult(for: text!)
        }
    }
    
    @objc func txtSearchTouched(_ sender: UITextField) {
       searchListContainer.isHidden = false
        //sender.textAlignment = .left
    }
    
    private func getSearchResult(for text: String) {
        APICall.search(for: text) { (response) in
            if let response  = response {
                if response.status! {
                    if let ticketFestivals = response.ticketFestival {
                        if ticketFestivals.count > 0 {
                            let searchList = self.prepareSearchListData(from: ticketFestivals)
                            if searchList.count > 0 {
                                self.searchListdata = searchList
                                self.searchListTableView.reloadData()
                                self.searchResultData = ticketFestivals
                            }
                        }
                    }
                }
            }
        }
    }
    
    private func prepareSearchListData(from ticketFests: [TicketFestival]) -> [String] {
        var festList = [String] ()
        
        for ticketFest in ticketFests {
            if let tickets = ticketFest.tickets {
                for ticket in tickets {
                    festList.append(ticket.festivalName!)
                }
            } else {
                if let fests = ticketFest.festivals {
                    for fest in fests {
                        festList.append(fest.festivalName!)
                    }
                }
            }
        }
        
        return festList
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == searchListTableView {
            return 1
        } else {
            return searchResultData.count
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == searchListTableView {
            return searchListdata.count
        } else {
            switch section {
            case 0:
                if let tickets = searchResultData[section].tickets {
                    return tickets.count
                } else {
                    return 0
                }
            case 1:
                if let festivals = searchResultData[section].festivals {
                    return festivals.count
                } else {
                    return 0
                }
            default:
                return 0
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == searchListTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SearchListTVC.self), for: indexPath) as! SearchListTVC
            let data = searchListdata[indexPath.row]
            cell.lblName.text = data
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SearchResultTVC.self), for: indexPath) as! SearchResultTVC
            
            switch indexPath.section {
            case 0:
                if let ticket = searchResultData[0].tickets?[indexPath.row] {
                    if let name = ticket.festivalShortName {
                        cell.lblShortName.text = name
                    } else {
                        cell.lblShortName.text = ""
                    }
                    
                    if let subName = ticket.festivalSubName {
                        if let year = ticket.year {
                            cell.lblSubnameYear.text = "\(subName) | \(year)"
                        } else {
                            cell.lblSubnameYear.text = subName
                        }
                    } else {
                        cell.lblSubnameYear.text = ""
                    }
                    
                    if let tier = ticket.ticketTier {
                        cell.lblTier.text = tier
                    } else {
                        cell.lblTier.text = ""
                    }
                    
                    if let url = ticket.imageUrl {
                        let url = URL(string: url)
                        cell.festivalImage.sd_setImage(with: url)
                    }
                }
            case 1:
                if let festival = searchResultData[1].festivals?[indexPath.row] {
                    if let name = festival.festivalShortName {
                        cell.lblShortName.text = name
                    } else {
                        cell.lblShortName.text = ""
                    }
                    
                    if let subName = festival.festivalSubName {
                        if let year = festival.year {
                            cell.lblSubnameYear.text = "\(subName) | \(year)"
                        } else {
                            cell.lblSubnameYear.text = subName
                        }
                    } else {
                        cell.lblSubnameYear.text = ""
                    }
                    
                    cell.lblTier.text = ""
                    
                    if let url = festival.imageUrl {
                        let url = URL(string: url)
                        cell.festivalImage.sd_setImage(with: url)
                    }
                }
            default:
                print("Do Nothing")
            }
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if tableView == searchListTableView {
            searchListContainer.isHidden = true
            searchResultTvc.reloadData()
            txtSearch.resignFirstResponder()
        } else {
            print("Result TV")
            let sb = UIStoryboard(name: "Main", bundle: nil)
            switch indexPath.section {
            case 0:
                let ticket = searchResultData[0].tickets![indexPath.row]
                let destVC = sb.instantiateViewController(withIdentifier: "TicketDetailsViewController") as! TicketDetailsViewController
                destVC.ticketId = ticket.id!
                destVC.typeFlag = 0
                self.navigationController?.pushViewController(destVC, animated: true)
            case 1:
                let festival = searchResultData[1].festivals![indexPath.row]
                let destVC = sb.instantiateViewController(withIdentifier: "FestivalViewController") as! FestivalViewController
                destVC.festivalId = festival.id!
                self.navigationController?.pushViewController(destVC, animated: true)
            default:
                print("Do Nothing")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if tableView == searchResultTvc {
            
            switch section {
            case 0:
                return "Tickets"
            default:
                return "Products"
            }
        } else {
            return nil
        }
    }
}
