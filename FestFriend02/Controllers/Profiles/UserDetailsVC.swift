//
//  UserDetailsVC.swift
//  FestFriend02
//
//  Created by Kazi Abdullah Al Mamun on 6/2/19.
//  Copyright © 2019 MySoftheaven BD. All rights reserved.
//

import UIKit

class UserDetailsVC: UIViewController {
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var lblShortName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblAge: UILabel!
    @IBOutlet weak var lblCountry: UILabel!
    @IBOutlet weak var lblState: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        getDetails()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getDetails() 
    }
    
    private func getDetails() {
        showProgress(on: view)
        
        APICall.getUserDetails { (response) in
            self.dismissProgress(for: self.view)
            
            if let response = response, let details = response.userDetails {
                self.lblShortName.text = details.name != nil ? details.name! : ""
                self.lblEmail.text = details.email != nil ? details.email! : ""
                self.lblAge.text = details.age != nil ? details.age! : ""
                self.lblCountry.text = details.country != nil ? details.country! : ""
                self.lblState.text = details.state != nil ? details.state! : ""
                
                if let imgStr = details.image {
                    let url = URL(string: imgStr)
                    self.userImage.sd_setImage(with: url)
                }
            }
        }
    }

    @IBAction func backButtonAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
