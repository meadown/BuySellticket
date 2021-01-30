//
//  AboutVC.swift
//  FestFriend02
//
//  Created by Biswajit Banik on 1/12/19.
//  Copyright © 2019 MySoftheaven BD. All rights reserved.
//

import UIKit
import SafariServices

class AboutVC: UIViewController {

    @IBOutlet weak var termsAndService: UILabel!
    @IBOutlet weak var privacyAndPolicy: UILabel!
    @IBOutlet weak var careersAndPartnership: UILabel!
    @IBOutlet weak var howItWorks: UILabel!
    
    @IBOutlet weak var facebookShare: UIImageView!
    @IBOutlet weak var twitterShare: UIImageView!
    @IBOutlet weak var instragramShare: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.tabBarController?.tabBar.isHidden = true
        let terms = UITapGestureRecognizer(target: self, action: #selector(AboutVC.tapTerms))
        let privacy = UITapGestureRecognizer(target: self, action: #selector(AboutVC.tapPrivacy))
         let careers = UITapGestureRecognizer(target: self, action: #selector(AboutVC.tapcareersAndPartnership))
        let works = UITapGestureRecognizer(target: self, action: #selector(AboutVC.taphowItWorks))
        
        let facebookAction = UITapGestureRecognizer(target: self, action: #selector(AboutVC.tapFacebook))
        let twitterAction = UITapGestureRecognizer(target: self, action: #selector(AboutVC.taptwitter))
       let instragramAction = UITapGestureRecognizer(target: self, action: #selector(AboutVC.tapInstragram))
        
        
        termsAndService.isUserInteractionEnabled = true
        privacyAndPolicy.isUserInteractionEnabled = true
        careersAndPartnership.isUserInteractionEnabled = true
        howItWorks.isUserInteractionEnabled = true
      
        facebookShare.isUserInteractionEnabled = true
        twitterShare.isUserInteractionEnabled = true
        instragramShare.isUserInteractionEnabled = true

        
        
        termsAndService.addGestureRecognizer(terms)
        privacyAndPolicy.addGestureRecognizer(privacy)
        careersAndPartnership.addGestureRecognizer(careers)
        howItWorks.addGestureRecognizer(works)
        
        facebookShare.addGestureRecognizer(facebookAction)
        twitterShare.addGestureRecognizer(twitterAction)
        instragramShare.addGestureRecognizer(instragramAction)
        
    
        
    }

    @objc func tapTerms(sender:UITapGestureRecognizer) {
        performSegue(withIdentifier: "aboutView", sender: false)
       
    }
    @objc func tapPrivacy(sender:UITapGestureRecognizer) {
       performSegue(withIdentifier: "aboutView", sender: false)
        
    }
    @objc func tapcareersAndPartnership(sender:UITapGestureRecognizer) {
        performSegue(withIdentifier: "aboutView", sender: false)
        
    }
    @objc func taphowItWorks(sender:UITapGestureRecognizer) {
        performSegue(withIdentifier: "aboutView", sender: false)
        
    }
    
    @objc func tapFacebook(sender:UITapGestureRecognizer) {
        print("Facebook")
        showSafriVC(for: "https://www.facebook.com/FestFriendsApp/")
       
        
    }
    @objc func tapInstragram(sender:UITapGestureRecognizer) {
         showSafriVC(for: "https://www.instagram.com/festfriends.app/")
    }
    @objc func taptwitter(sender:UITapGestureRecognizer) {
       showSafriVC(for: "https://twitter.com/festfriends_app")

    }
    
    func showSafriVC(for url: String) {
        guard let url = URL(string: url) else {
            return
        }
        let safariVC = SFSafariViewController(url: url)
        present(safariVC , animated: true)
    }


    
}
