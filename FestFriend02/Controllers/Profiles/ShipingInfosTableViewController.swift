//
//  ShipingInfosTableViewController.swift
//  FestFriend02
//
//  Created by Kazi Abdullah Al Mamun on 3/2/19.
//  Copyright © 2019 MySoftheaven BD. All rights reserved.
//

import UIKit

class ShipingInfosTableViewController: UITableViewController, ShipingTVCDelegate {
    
    var adresses = [ShippingAddress1]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getShipingAddresses()
    }
    
    private func setupViews() {
        let addBtn = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addAddressBarBtnTapped(_:)))
        navigationItem.rightBarButtonItem = addBtn
    }
    
    @objc func addAddressBarBtnTapped(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "toAddShipingInfo", sender: nil)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return adresses.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ShippingAddressTVCell.self), for: indexPath) as! ShippingAddressTVCell
        cell.delegate = self
        cell.configureCell(with: adresses[indexPath.row], index: indexPath.row)
        return cell
    }
    
    func editBtnTapped(cell: UITableViewCell) {
        let indexpath = tableView.indexPath(for: cell)
        let address = adresses[indexpath!.row]
        performSegue(withIdentifier: "toAddShipingInfo", sender: address)
    }

    private func getShipingAddresses() {
        showProgress(on: view)
        APICall.getShipingAddresses { (response) in
            self.dismissProgress(for: self.view)
            if let response = response {
                if response.status! {
                    if let addresses = response.shippingAddresses {
                        self.adresses = addresses
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier?.elementsEqual("toAddShipingInfo"))! {
            let dest = segue.destination as! AddShipingInfoVC
            if let address = sender {
                dest.addressToEdit = address as! ShippingAddress1
            }
        }
    }

}
