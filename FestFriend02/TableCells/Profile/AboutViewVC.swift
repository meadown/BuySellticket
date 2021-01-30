//
//  AboutViewVC.swift
//  FestFriend02
//
//  Created by Biswajit Banik on 1/12/19.
//  Copyright © 2019 MySoftheaven BD. All rights reserved.
//

import UIKit

class AboutViewVC: UIViewController {

    @IBOutlet weak var aboutWebView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let url = URL (string: "https://www.festfriends.app/terms")
        let request = URLRequest(url: url!)
        aboutWebView.loadRequest(request)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
