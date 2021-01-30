//
//  SeeAllViewController.swift
//  FestFriend02
//
//  Created by MySoftheaven BD on 1/10/18.
//  Copyright © 2018 MySoftheaven BD. All rights reserved.
//

import UIKit

class SeeAllViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    

    @IBOutlet weak var allTicketsCollectionView: UICollectionView! {
        didSet {
            allTicketsCollectionView.register(UINib(nibName: String(describing: SeeAllCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: SeeAllCollectionViewCell.self))
        }
    }
    @IBOutlet weak var lblVCTitle: UILabel!
    
    var festType: String!
    
    var ticketFlag = 0
    var festTypeFlag: Int {
        get {
            if festType.elementsEqual("Upcoming Releases") {
                return 1
            } else {
                return 0
            }
        }
    }
    var festBidData: [NewHighestBid]?
    var festReleaseCalanderData: [ReleaseCalender]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.barStyle = .default
        let titleAttributes = [
            NSAttributedStringKey.font: UIFont.systemFont(ofSize: 15 , weight: UIFont.Weight.heavy),
            NSAttributedStringKey.foregroundColor: UIColor.black
        ]
        self.navigationController?.navigationBar.titleTextAttributes = titleAttributes
        self.navigationItem.title = festType
        
        allTicketsCollectionView.delegate = self
        allTicketsCollectionView.dataSource = self
        
    }
    
 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.barStyle = .default
        let titleAttributes = [
            NSAttributedStringKey.font: UIFont.systemFont(ofSize: 15 , weight: UIFont.Weight.heavy),
            NSAttributedStringKey.foregroundColor: UIColor.black
        ]
        self.navigationController?.navigationBar.titleTextAttributes = titleAttributes
        self.navigationItem.title = festType
        self.navigationController?.isNavigationBarHidden = false

        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }

    //MARK : <UICollectionView Datasource>
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if festTypeFlag == 0 {
            return festBidData!.count
        } else {
            return festReleaseCalanderData!.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = allTicketsCollectionView.dequeueReusableCell(withReuseIdentifier: String(describing: SeeAllCollectionViewCell.self), for: indexPath) as! SeeAllCollectionViewCell
        
        if festTypeFlag == 0 {
            cell.configureCell(with: festBidData![indexPath.row])
        } else {
            cell.configureCell(with: festReleaseCalanderData![indexPath.row])
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width  = collectionView.frame.width / 2 - 5
        
        var height: CGFloat = 0
        if festTypeFlag == 6 {
            height = collectionView.frame.height / 1.9 - 35
        } else {
            height = collectionView.frame.height / 1.9 - 5
        }
        
        print("UICollectionViewLayout")
        return CGSize(width: width, height: height)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        print("minimumLineSpacingForSectionAt")
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let ticketDetailsVC = storyboard.instantiateViewController(withIdentifier: String(describing: TicketDetailsViewController.self)) as! TicketDetailsViewController
        
        var ticketId = 0
        if festTypeFlag == 1 {
            ticketId = festReleaseCalanderData![indexPath.row].id!
        } else {
            ticketId = festBidData![indexPath.row].ticketID!
        }
        
        ticketDetailsVC.ticketId = ticketId
        ticketDetailsVC.typeFlag = ticketFlag
        self.navigationController?.pushViewController(ticketDetailsVC, animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
