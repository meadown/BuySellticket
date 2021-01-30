//
//  FollowingVC.swift
//  FestFriend02
//
//  Created by Kazi Abdullah Al Mamun on 29/1/19.
//  Copyright © 2019 MySoftheaven BD. All rights reserved.
//

import UIKit

class FollowingVC: UIViewController {
    
    @IBOutlet weak var tableview: UITableView!
    
    var sections = [String]()
    var favorites: FavouriteLis?

    override func viewDidLoad() {
        super.viewDidLoad()

        getFestivalList()
        tableview.delegate = self
        tableview.dataSource = self
    }
    
    private func getFestivalList() {
        showProgress(on: view)
        APICall.getFavoriteList { (response) in
            self.dismissProgress(for: self.view)
            if let response = response {
                self.sections = response.getSections()
                self.favorites = response
                self.tableview.reloadData()
            }
        }
    }

}


extension FollowingVC: UITableViewDataSource, UITableViewDelegate, FollowingTVCDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionLabel = sections[section]
        
        if sectionLabel.elementsEqual(FavouriteLis.festivalLabel) {
            let festivals = favorites!.favFestivals!
            return festivals.count
        } else if sectionLabel.elementsEqual(FavouriteLis.ticketLabel) {
            let tickts = favorites!.favTickets!
            return tickts.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: String(describing: FollowingTVC.self), for: indexPath) as! FollowingTVC
        cell.delegate = self
        
        let sectionLabel = sections[indexPath.section]
        
        if sectionLabel.elementsEqual(FavouriteLis.festivalLabel) {
            let festival = favorites!.favFestivals![indexPath.row]
            cell.configureCell(with: festival)
        } else if sectionLabel.elementsEqual(FavouriteLis.ticketLabel) {
            let ticket = favorites!.favTickets![indexPath.row]
            cell.configureCell(with: ticket)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "   \(sections[section])"
        label.backgroundColor = UIColor.white
        return label
    }
    
    func btnUnFollowTapped(cell: UITableViewCell) {
        showProgress(on: view)
        let indexPath = tableview.indexPath(for: cell)
        var type = 0
        var params: [String: AnyObject] = Dictionary()
        params["user_id"] = LocalPersistance.getUserId() as! AnyObject
        
        if sections[indexPath!.section].elementsEqual(FavouriteLis.festivalLabel) {
            type = 2
            let festival = favorites!.favFestivals![indexPath!.row]
            params["favorite_id"] = Int(festival.festivalID!) as! AnyObject
            params["type"] = type as! AnyObject
        } else {
            type = 1
            let ticket = favorites!.favTickets![indexPath!.row]
            params["favorite_id"] = Int(ticket.ticketID!) as! AnyObject
            params["type"] = type as! AnyObject
        }
        
        APICall.removeFavorite(params: params) { (response) in
            self.dismissProgress(for: self.view)
            if let response = response {
                if response.status! {
                    if type == 1 {
                        self.favorites!.favTickets!.remove(at: indexPath!.row)
                    } else {
                        self.favorites!.favFestivals!.remove(at: indexPath!.row)
                    }
                    
                    self.tableview.deleteRows(at: [indexPath!], with: .automatic)
                } else {
                    self.showDialog(title: "RemoveFavorite", message: "Something went wrong")
                }
            } else {
                self.showDialog(title: "RemoveFavorite", message: "Something went wrong")
            }
        }
    }
    
}
