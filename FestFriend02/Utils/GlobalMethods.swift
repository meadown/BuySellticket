//
//  GlobalMethods.swift
//  FestFriend02
//  Copyright © 2019 MySoftheaven BD. All rights reserved.
//

import Foundation
import UIKit


func isValidEmail(email: String) -> Bool {
    // here, `try!` will always succeed because the pattern is valid
    let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
    return regex.firstMatch(in: email, options: [], range: NSRange(location: 0, length: email.count)) != nil
}

func getBidAskExpiraryFormatedDate(dateStr: String) -> String {
    
    let formatter = DateFormatter()
    formatter.dateFormat = "YYYY-MM-dd"
    let date = formatter.date(from: dateStr)
    formatter.dateFormat = "MM/dd/YYYY"
    return formatter.string(from: date!)
}

func getPurchaseCanceledFormatedDate(dateStr: String) -> String {
    
    let formatter = DateFormatter()
    formatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
    let date = formatter.date(from: dateStr)
    formatter.dateFormat = "MM/dd/YYYY"
    return formatter.string(from: date!)
}

func shareApp(from vc: UIViewController) {
    
    let activityVC = UIActivityViewController(activityItems: ["FestFriend"], applicationActivities: nil)
    vc.present(activityVC, animated: true, completion: nil)
}

func makeFavorite(from vc: UIViewController, for id: Int, type: Int) {
    
    let userId = LocalPersistance.getUserId()
    
    if userId > 0 {
        vc.showProgress(on: vc.view)
        
        let param = ["user_id": userId,
                     "favorite_id": id,
                     "type": type] as! [String: AnyObject]
        
        APICall.addFavorite(param: param) { (response) in
            vc.dismissProgress(for: vc.view)
            
            if let response = response {
                if response.status! {
                    if type == 1
                    {
                        // for follow product
                    vc.showDialog(title: "Product Followed", message: "You are now following this product.")
                    }
                    else if type == 2
                    {// for follow festival
                         vc.showDialog(title: "Festival Followed", message: "You are now following this festival.")
                    }
                    else
                    {// for generel follow
                         vc.showDialog(title: "Festival Followed", message: "This item successfully added to your favorite.")
                    }
                
                }
                else {
                    vc.showDialog(title: "Festival Followed", message: "Something went wrong. Please try again later")
                }
            } else {
                vc.showDialog(title: "Festival Followed", message: "Something went wrong. Please try again later")
            }
        }
    } else {
        
        if type == 1
        {
            // for follow product
        vc.showDialog(title: "Log-In Required", message: "Please log in to follow this product.")
        }
        else if type == 2
        {// for follow festival
             vc.showDialog(title: "Log-In Required", message: "Please log in to follow this festival.")
        }
        else
        {// for generel follow
             vc.showDialog(title: "Log-In Required", message: "Please login to add this itema as favorite.")
        }
        
        
    }
    
}
