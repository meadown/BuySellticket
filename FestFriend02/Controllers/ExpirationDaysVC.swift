//
//  ExpirationDaysVC.swift
//  FestFriend02

//  Copyright © 2019 MySoftheaven BD. All rights reserved.
//

import UIKit

class ExpirationDaysVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let expirationDays = [1, 3, 5, 7]
    
    @IBOutlet weak var tableview: UITableView!
    
    var delegate: ExpirationDaysVCDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return expirationDays.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dayCell", for: indexPath)
        let day = expirationDays[indexPath.row]
        
        if day > 1 {
            cell.textLabel?.text = "\(day) days"
        } else {
            cell.textLabel?.text = "\(day) day"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let days = expirationDays[indexPath.row]
        delegate.expirationDaysChoosed(days: days)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func dismissVCAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
