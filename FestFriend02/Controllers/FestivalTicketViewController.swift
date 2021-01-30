//
//  FestivalTicketViewController.swift
//  FestFriend02

//  Copyright © 2019 MySoftheaven BD. All rights reserved.
//

import UIKit

class FestivalTicketViewController: UIViewController {
    
    typealias sectionTuple = (String, [FestivalTicket])
    
    @IBOutlet weak var ticketsTableView: UITableView!
    
    var festivalId: Int!
    var festivalName: String!
    
    var festivalTicketsResp: FestivalTicketsResponse?
    var sections: [Int: sectionTuple]?

    override func viewDidLoad() {
        super.viewDidLoad()
        getFestTickets()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        prepareNavBar()
    }
    
    private func getFestTickets() {
        showProgress(on: view)
        APICall.getFestivalTickets(id: festivalId) { (festivalResponse) in
            DispatchQueue.main.async {
                self.dismissProgress(for: self.view)
                if let festResponse = festivalResponse {
                    self.festivalTicketsResp = festResponse
                    self.sections = festResponse.getSections()
                    self.ticketsTableView.reloadData()
                }
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    private func prepareNavBar() {
        
        navigationController?.navigationBar.tintColor = UIColor.black
        navigationController?.navigationBar.barStyle = .default
        
        let textAttributes = [ NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14 , weight: UIFont.Weight.bold),
                                 NSAttributedStringKey.foregroundColor: UIColor.black]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationItem.title = festivalName
        
        let leftBarBtn = UIBarButtonItem(image: UIImage(named: "cancel.png"), style: .plain, target: self, action: #selector(backBtnAction(_:)))
        navigationItem.leftBarButtonItem = leftBarBtn
       
        
        let followBtn = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_follow_white"), style: .plain, target: self, action: #selector(followBtnAction(_:)))
        navigationItem.rightBarButtonItem = followBtn
    }
    
    @objc func followBtnAction(_ sender: UIBarButtonItem) {
        makeFavorite(from: self, for: festivalId, type: 2)
    }

    @objc func backBtnAction(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
}


extension FestivalTicketViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if let sections = self.sections {
            return sections.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionData = self.sections![section]
        if let festivalTickets = sectionData?.1 {
            return festivalTickets.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "festTicketCell", for: indexPath) as! FestivalTicketTableViewCell
        
        let sectionData = sections![indexPath.section]!
        let festivalTickets = sectionData.1
        cell.configureCell(festivalTicket: festivalTickets[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.backgroundColor = UIColor.white
        label.textColor = UIColor.gray
        label.font = label.font.withSize(15)
        label.text = "    \(self.sections![section]!.0)"
        return label
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let ticketDetailsVC = storyboard.instantiateViewController(withIdentifier: String(describing: TicketDetailsViewController.self)) as! TicketDetailsViewController
        
        let festival = sections![indexPath.section]!.1[indexPath.row]
        ticketDetailsVC.ticketId = festival.ticketID!
        ticketDetailsVC.typeFlag = 1
        navigationController?.pushViewController(ticketDetailsVC, animated: true)
    }
}
