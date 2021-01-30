//
//  HomeViewController.swift
//  FestFriend02
//
//  Created by MySoftheaven BD on 26/9/18.
//  Copyright © 2018 MySoftheaven BD. All rights reserved.
//

import UIKit
import QuartzCore
class HomeViewController: UIViewController {

    @IBOutlet weak var mainFestFriendTable: UITableView! {
        didSet {
            mainFestFriendTable.register(UINib(nibName: String(describing: BannerTableViewCell.self), bundle: nil), forCellReuseIdentifier: "BannerTableViewCell")
            mainFestFriendTable.register(UINib(nibName: String(describing: CommonTableViewCell.self), bundle: nil), forCellReuseIdentifier: "commonCellID")
            mainFestFriendTable.register(UINib(nibName: String(describing: CommonSecondTableViewCell.self) , bundle: nil), forCellReuseIdentifier: "commonSecondCellID")
            mainFestFriendTable.register(UINib(nibName: String(describing: TicketsShowingTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: TicketsShowingTableViewCell.self))
            
//            mainFestFriendTable.estimatedRowHeight = 150.0
//            mainFestFriendTable.rowHeight = UITableViewAutomaticDimension
        }
    }
    
    var listArray = [ "",
                     "Upcoming Festivals",
                     "Popular Festivals",
                     "Recent Sales",
                     "New Lowest Asks",
                     "New Highest Bids",
                     "Upcoming Releases"
                     ]
    
    var homeviewInfo: HomeViewInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       //self.DarkModaeCheck()
        
        mainFestFriendTable.delegate = self
        mainFestFriendTable.dataSource = self
        mainFestFriendTable.contentInsetAdjustmentBehavior = .never
        mainFestFriendTable.estimatedRowHeight = 150
        mainFestFriendTable.rowHeight = UITableViewAutomaticDimension
        // to transparent the navigation controller
//    self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        self.navigationController?.navigationBar.isTranslucent = true
//        // to remove the border line or shadow image of navigation bar
//        self.navigationController?.navigationBar.shadowImage = UIImage()
//        
        self.removeTabbarItemsText()
        showProgress(on: view)
        DispatchQueue.global().async {
            APICall.getAllHomeInformation { (allInfo) in
                DispatchQueue.main.async {
                    self.dismissProgress(for: self.view)
                    self.homeviewInfo = allInfo
                    self.mainFestFriendTable.reloadData()
                }
            }
        }
//          navigationController?.navigationBar.barStyle = .blackTranslucent
//        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    
    func removeTabbarItemsText() {
        if let items = tabBarController?.tabBar.items {
            for item in items {
                item.title = ""
                item.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
            }
        }
    }

   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        showProgress(on: view)
        DispatchQueue.global().async {
            APICall.getAllHomeInformation { (allInfo) in
                DispatchQueue.main.async {
                    self.dismissProgress(for: self.view)
                    self.homeviewInfo = allInfo
                    self.mainFestFriendTable.reloadData()
                }
            }
        }
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
   
  
    
   
//
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(true)
//        navigationController?.setNavigationBarHidden(false, animated: false)
//    }
//
//    override func viewDidDisappear(_ animated: Bool) {
//
//
//    }
    
    //MARK: to hide the status bar (battery, network etc)
//    override var prefersStatusBarHidden: Bool {
//        return true
//    }
    
//    override func viewWillDisappear(_ animated: Bool) {
//        // keep showing the nav bar in the subsequent view controller
//        self.navigationController?.setNavigationBarHidden(false, animated: false)
//    }
//

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        if scrollView == self.mainFestFriendTable {
            print(scrollView.contentOffset.y)
            print("rregre \(scrollView.frame.height / 2 - 65)")
            if scrollView.contentOffset.y <= scrollView.frame.height / 2 - 100
            {
                if #available(iOS 13.0, *) {
                    // Running iOS 11 OR NEWER
                } else {
                    // Earlier version of iOS
                    UIApplication.statusBarBackgroundColor = .clear
                    navigationController?.navigationBar.barStyle = .blackTranslucent
                }
                

            }
            else {
                print("scroll korse so white hobe")
                if #available(iOS 13.0, *) {
                    // Running iOS 11 OR NEWER
                } else {
                    // Earlier version of iOS
                    UIApplication.statusBarBackgroundColor = .white
                    navigationController?.navigationBar.barStyle = .default
                }
                
                


            }
            
        }
        
        
    }
    
    /*
    //Mark: - dark mode check
    //dark mode check start
    func DarkModaeCheck()
    {
        if #available(iOS 12.0, *) {
                   switch traitCollection.userInterfaceStyle {
                   case .light, .unspecified:
                       // light mode detected
                       break
                   case .dark:
                       self.showDialog(title: "Dark Mode", message: "App Not Available in Dark Mode please turn off Dark mode to use the application smoothly.")
                       // Mark :- force to light mode
                    if #available(iOS 13.0, *) {
                        overrideUserInterfaceStyle = .light
                    } else {
                        // Fallback on earlier versions
                    }
                       break
                      
                   }
               } else {
                   // Fallback on earlier versions
               }
    }
    //dark mode check end*/
        
}
extension UIApplication {
    class var statusBarBackgroundColor: UIColor? {
        get {
            return (shared.value(forKey: "statusBar") as? UIView)?.backgroundColor
        } set {
            (shared.value(forKey: "statusBar") as? UIView)?.backgroundColor = newValue
        }
    }
}
