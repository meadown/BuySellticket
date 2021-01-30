//
//  ProfileVC.swift
//  FestFriend02
//
//  Created by Kazi Abdullah Al Mamun on 27/1/19.
//

import UIKit

class ProfileVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var authAskContainer: UIView!
    @IBOutlet weak var btnLogIn: UIButton!
    @IBOutlet weak var btnRegister: UIButton!
  //  @IBOutlet weak var barBtnSettings: UIBarButtonItem!
    
    let tableViewData = [("Name", #imageLiteral(resourceName: "ic_buying")),
                         ("Buying", #imageLiteral(resourceName: "ic_buying")),
                         ("Selling", #imageLiteral(resourceName: "Selling-1")),
                         ("Following", #imageLiteral(resourceName: "Following")),
                         ("Settings", #imageLiteral(resourceName: "ic_settings")),
                         ("About", #imageLiteral(resourceName: "FAQ")),
                         ("Log Out", #imageLiteral(resourceName: "logout_new")),]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if LocalPersistance.getUserId() == 0 {
            tableView.isHidden = true
            authAskContainer.isHidden = false
          //  barBtnSettings.isEnabled = false
           // barBtnSettings.tintColor = UIColor.clear
        } else {
            tableView.reloadData()
            tableView.isHidden = false
            authAskContainer.isHidden = true
           // barBtnSettings.isEnabled = true
          //  barBtnSettings.tintColor = UIColor.black
        }
    }
    
    private func setupViews() {
        btnLogIn.layer.cornerRadius = 3
        btnLogIn.layer.borderWidth = 1
        btnLogIn.layer.borderColor = UIColor.gray.cgColor
        
        btnRegister.layer.cornerRadius = 3
        btnRegister.layer.borderWidth = 1
        btnRegister.layer.borderColor = UIColor.gray.cgColor
    }
    

    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "toBuySell":
                let destVC = segue.destination as! BuyingSellingVC
                let isBuying = sender as! Bool
                destVC.isBuying = isBuying
            case "goToAuthentication":
                let destVC = segue.destination as! SignInVC
                destVC.isForRegister = sender as! Bool
            default:
                print("Doing nothing")
            }
        }
     }
    
    // Marh: - Actions
    
    @IBAction func btnLogInAction(_ sender: UIButton) {
        performSegue(withIdentifier: "goToAuthentication", sender: false)
    }
    
    @IBAction func btnRegisterAction(_ sender: UIButton) {
        performSegue(withIdentifier: "goToAuthentication", sender: true)
    }
    

}

extension ProfileVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ProfileNameTVC.self), for: indexPath) as! ProfileNameTVC
            if let name = LocalPersistance.getUserName() {
                cell.lblName.text = name
            } else {
                cell.lblName.text = ""
            }
            return cell
        case 6:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ProfileLogoutTVC.self), for: indexPath) as! ProfileLogoutTVC
            cell.delegate = self
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ProfileGeneralTVC.self), for: indexPath) as! ProfileGeneralTVC
            cell.lblTitle.text = tableViewData[indexPath.row].0
            cell.img.image = tableViewData[indexPath.row].1
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        switch indexPath.row {
        case 0:
            performSegue(withIdentifier: "toProfileInfo", sender: self)
        case 1:
            performSegue(withIdentifier: "toBuySell", sender: true)
        case 2:
            performSegue(withIdentifier: "toBuySell", sender: false)
        case 3:
            performSegue(withIdentifier: "goToFollowingVC", sender: self)
        case 4:
            performSegue(withIdentifier: "showSettings", sender: self)
        case 5:
            performSegue(withIdentifier: "aboutInfo", sender: self)
            


        default:
            print("Profile cell clicked")
        }
    }
    
    func logoutAction() {
        let alert = UIAlertController(title: "Log Out", message: "Thanks for using FestFriends", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "CANCEL", style: .cancel)
        alert.addAction(cancelAction)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            LocalPersistance.clearUserDetails()
            self.tableView.isHidden = true
            self.authAskContainer.isHidden = false
           // self.barBtnSettings.isEnabled = false
          //  self.barBtnSettings.tintColor = UIColor.clear
        }
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
    }
    
}
