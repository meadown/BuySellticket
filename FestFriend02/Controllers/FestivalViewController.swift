//
//  FestivalViewController.swift
//  FestFriend02
//
//  Created by MySoftheaven BD on 10/10/18.
//  Copyright © 2018 MySoftheaven BD. All rights reserved.
//

import UIKit
import SimpleImageViewer

class FestivalViewController: UIViewController {
    
    @IBOutlet weak var backBarButton: UIBarButtonItem!
    
    @IBOutlet weak var followBarButton: UIBarButtonItem!
    @IBOutlet weak var shareBarBtn: UIBarButtonItem!
    @IBOutlet weak var viewProductsButton: UIButton! {
        didSet {
            viewProductsButton.layer.cornerRadius = 5.0
            viewProductsButton.layer.masksToBounds = true
        }
    }
    
    @IBOutlet weak var festivalTableView: UITableView! {
        didSet {
            festivalTableView.register(UINib(nibName: String(describing:festivalbannerTableViewCell.self ), bundle: nil), forCellReuseIdentifier: String(describing:festivalbannerTableViewCell.self ))
            festivalTableView.register(UINib(nibName: String(describing:festivalInformationTableViewCell.self ), bundle: nil), forCellReuseIdentifier: String(describing:festivalInformationTableViewCell.self ))
            festivalTableView.register(UINib(nibName: String(describing:FestivalDescriptionTableViewCell.self ), bundle: nil), forCellReuseIdentifier: String(describing:FestivalDescriptionTableViewCell.self ))
            festivalTableView.register(UINib(nibName: String(describing: TicketsShowingTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: TicketsShowingTableViewCell.self))
            
        }
    }
    @IBOutlet weak var lblAvailableProductCount: UILabel!
    
    var festivalId: Int!
    var festivalDetails: FestivalDetails?
    
    var lblTitle: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        festivalTableView.delegate = self
        festivalTableView.dataSource = self
        festivalTableView.estimatedRowHeight = 150
        festivalTableView.rowHeight = UITableViewAutomaticDimension
        // to transparent the navigation controller
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.isTranslucent = true
        // to remove the border line or shadow image of navigation bar
        self.navigationController?.navigationBar.shadowImage = UIImage()
        //self.festivalTableView.contentInset = UIEdgeInsetsMake(-64, 0, 0, 0)
        //self.festivalTableView.scrollIndicatorInsets = UIEdgeInsetsMake(-64, 0, 0, 0)
        
        //MARK:- change the color and the font of the title
        let titleAttributes = [
            NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14 , weight: UIFont.Weight.heavy),
            NSAttributedStringKey.foregroundColor: UIColor.white
        ]
        self.navigationController?.navigationBar.titleTextAttributes = titleAttributes
        lblTitle = setMultilineTitle(title: "")
        lblTitle?.textColor = UIColor.white
//        lblTitle?.textAlignment = .center
        //self.title = ""
        getFestivalDetails()

    }

    override func viewWillAppear(_ animated: Bool) {
        //hide the navigationbar
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.barStyle = .blackTranslucent
    }
    
    private func getFestivalDetails() {
        
        showProgress(on: view)
        APICall.getFestDetails(id: festivalId) { (details) in
            
            DispatchQueue.main.async {
                self.dismissProgress(for: self.view)
                if let details = details?.festivalDetails {
                    print("FestDetails got")
                    DispatchQueue.main.async {
                        self.festivalDetails = details
                        //self.title = "\(details.festivalName!) \(details.festivalYear!) - \(details.festivalSubName!)"
                        if details.festivalSubName == "" {
                            self.lblTitle?.text = "\(details.festivalShortName!) \(details.festivalYear!)"
                        } else {
                            self.lblTitle?.text = "\(details.festivalShortName!) \(details.festivalYear!)\n \(details.festivalSubName!)"

                        }
                        self.festivalTableView.reloadData()
                        
                        if let availableProducts = details.totalProduct, availableProducts > 0 {
                            self.lblAvailableProductCount.text = "\(availableProducts) Available Products"
                            self.viewProductsButton.isEnabled = true
                            self.viewProductsButton.isUserInteractionEnabled = true
                        } else {
                            self.lblAvailableProductCount.text = "0 Available Products"
                            self.viewProductsButton.isEnabled = false
                            self.viewProductsButton.isUserInteractionEnabled = false
                        }
                    }
                    
                } else {
                    print("FestDetails missed")
                }
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func backButtonTapped(_ sender: Any) {
         self.navigationController?.popViewController(animated: true)
      //   self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnViewProductsAction(_sender: UIButton) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: String(describing: FestivalTicketViewController.self)) as! FestivalTicketViewController
        vc .festivalId = festivalId
        
        
        vc.festivalName = "\(festivalDetails!.festivalShortName!) \(festivalDetails!.festivalYear!) - \(festivalDetails!.festivalSubName!)"
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func followBtnAction(_ sender: UIBarButtonItem) {
            makeFavorite(from: self, for: festivalId , type: 2)
    }
    
    @IBAction func shareBtnAction(_ sender: UIBarButtonItem) {
        shareApp(from: self)
    }
}


extension FestivalViewController : UITableViewDataSource, UITableViewDelegate, FestivalViewDelegate, SubFestivalCellDelegate, FestivalDetailsDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var rows = 3
        if let festivalDetails = festivalDetails {
            if let relatedFestivals = festivalDetails.relatedFestival {
                if relatedFestivals.count > 0 {
                    rows = rows + 1
                }
            }
            return rows
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            print("Get Festival called")
            return getfestivalBanner(with: indexPath)
        case 1:
            return getfestivalInformation(with: indexPath)
        case 2:
            return getFestivalDescription(with: indexPath)
        case 3:
            return getRelatedFestivals(index: indexPath)
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
//            let height = tableView.frame.height / 2 + 80
            let height = tableView.bounds.width - 120
            return height
//        case 1:
//            return 110
//        case 2:
//            let height = tableView.frame.height - 200
//            return height
        case 3:
            return 300
        default:
            return UITableViewAutomaticDimension
        }
    }
    
    func getfestivalBanner(with indexPath: IndexPath) -> festivalbannerTableViewCell {
        let cell = self.festivalTableView.dequeueReusableCell(withIdentifier: String(describing: festivalbannerTableViewCell.self), for: indexPath) as! festivalbannerTableViewCell
        
        cell.delegate = self
        if let urlStr = festivalDetails?.headerImage {
            let url = URL(string: urlStr)
            cell.festivalImageView.sd_setImage(with: url)
        }
        
        cell.lblAskValue.text = "$ \(festivalDetails!.highestBid!)"
        cell.lblBidValue.text = "$ \(festivalDetails!.lowestAsk!)"
        
        return cell
    }
    
    func getfestivalInformation(with indexPath: IndexPath) -> festivalInformationTableViewCell {
        let cell = self.festivalTableView.dequeueReusableCell(withIdentifier: String(describing: festivalInformationTableViewCell.self), for: indexPath) as! festivalInformationTableViewCell
        
        var cityYear = ""
        
        if let subname = festivalDetails?.festivalSubName {
            cityYear.append("\(subname) | ")
        }
        
        if let date = festivalDetails?.startAndEndDate {
            cityYear.append(date)
        }
        cell.lblCityYear.text = cityYear
        cell.lblFestName.text = self.festivalDetails!.festivalName!
        let a = "\u{10A51}"
        cell.lblAddress.text = "\(self.festivalDetails!.venue!) \(a.lowercased()) \(self.festivalDetails!.city!), \(self.festivalDetails!.state!)"
        
        return cell
    }
    
    func getFestivalDescription(with indexPath: IndexPath) -> FestivalDescriptionTableViewCell {
        let cell = self.festivalTableView.dequeueReusableCell(withIdentifier: String(describing: FestivalDescriptionTableViewCell.self), for: indexPath) as! FestivalDescriptionTableViewCell
        cell.delegate = self
        
        if let urlStr = self.festivalDetails!.lineUpPoster {
            let url = URL(string: urlStr)
            cell.imgPoster.sd_setImage(with: url)
        }
        
        /**if let description = self.festivalDetails?.description {
            cell.lblDescription.text = description
        } else {
            cell.lblDescription.text = ""
        }**/
        
        if let description = self.festivalDetails?.description {
            do {
                let descData = description.data(using: String.Encoding.unicode)
                let font = UIFont.systemFont(ofSize: 15.0)
                let attrDesc = try NSAttributedString(data: descData!, options: [.documentType: NSAttributedString.DocumentType.html , .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
                let attr = NSMutableAttributedString(attributedString: attrDesc)
                attr.addAttribute(.font, value: font, range: NSRange(location: 0, length: attrDesc.length))
                cell.lblDescription.attributedText = attr
            } catch {
                cell.lblDescription.text = self.festivalDetails?.description ?? ""
                print(error.localizedDescription)
            }
        }
        
        if let artists = self.festivalDetails?.artist {
            cell.lblArtistHeader.isHidden = false
            cell.lblArtists.isHidden = false
            cell.lblArtists.text = artists
        } else {
            cell.lblArtistHeader.isHidden = true
            cell.lblArtists.isHidden = true
        }
        
        if let generes = self.festivalDetails?.genre, !generes.isEmpty {
            cell.lblGenresHeader.isHidden = false
            cell.lblGenres.isHidden = false
            cell.lblGenres.text = generes
        } else {
            cell.lblGenresHeader.isHidden = true
            cell.lblGenres.isHidden = true
        }
        
        return cell
    }
    
    func getRelatedFestivals(index: IndexPath) -> TicketsShowingTableViewCell {
        let releaseCalendarCell = festivalTableView.dequeueReusableCell(withIdentifier: String(describing: TicketsShowingTableViewCell.self), for: index) as! TicketsShowingTableViewCell
        releaseCalendarCell.selectionStyle = .none
        releaseCalendarCell.sectionHeaderLabel.text = "Related Festivals"
        releaseCalendarCell.festivalDelegate = self
        releaseCalendarCell.seeAllButton.isHidden = true
        releaseCalendarCell.configureCell(with: festivalDetails!.relatedFestival!)
        return releaseCalendarCell
    }
    
    func relatedFestClicked(in indexPath: IndexPath) {
        let festival = festivalDetails!.relatedFestival![indexPath.row]
        let id = festival.festivalID!
        self.festivalId = id
        getFestivalDetails()
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        if scrollView == self.festivalTableView {
            print(scrollView.contentOffset.y)
            print("rregre \(scrollView.frame.height / 2 + 100 - 65)")
            if scrollView.contentOffset.y <= 200
            {
                // to transparent the navigation controller
                self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
                self.navigationController?.navigationBar.isTranslucent = true
                // to remove the border line or shadow image of navigation bar
                //self.navigationController?.navigationBar.shadowImage = UIImage()
                let titleAttributes = [
                    NSAttributedStringKey.font: UIFont.systemFont(ofSize: 15 , weight: UIFont.Weight.heavy),
                    NSAttributedStringKey.foregroundColor: UIColor.white
                ]
                self.navigationController?.navigationBar.titleTextAttributes = titleAttributes
                navigationController?.navigationBar.barStyle = .blackTranslucent
                lblTitle?.textColor = UIColor.white
                backBarButton.tintColor = UIColor.white
                followBarButton.tintColor = UIColor.white
                shareBarBtn.tintColor = UIColor.white
            }
            else {
            self.navigationController?.navigationBar.setBackgroundImage(UIImage.imageWithColor(color: UIColor(hex: "ffffff")), for: .default)
                self.navigationController?.navigationBar.isTranslucent = false
                let titleAttributes = [
                    NSAttributedStringKey.font: UIFont.systemFont(ofSize: 15 , weight: UIFont.Weight.bold),
                    NSAttributedStringKey.foregroundColor: UIColor.black
                ]
                self.navigationController?.navigationBar.titleTextAttributes = titleAttributes
                navigationController?.navigationBar.barStyle = .default
                lblTitle?.textColor = UIColor.black
                backBarButton.tintColor = UIColor.black
                followBarButton.tintColor = UIColor.black
                shareBarBtn.tintColor = UIColor.black
            }
            
        }
        
        
    }
    
    func bidOrAskedViewTapped(cell: UIView, flag: Int) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let ticketDetailsVC = storyboard.instantiateViewController(withIdentifier: String(describing: TicketDetailsViewController.self)) as! TicketDetailsViewController
        
        if case TicketID.integer(let int) = festivalDetails!.ticketID! {
            ticketDetailsVC.ticketId = int
            ticketDetailsVC.typeFlag = flag
            navigationController?.pushViewController(ticketDetailsVC, animated: true)
        }
    }
    
    func posterImgClicked(viewer: ImageViewerController) {
        self.present(viewer, animated: true)
    }
    
}


protocol FestivalViewDelegate {
    func relatedFestClicked(in indexPath: IndexPath)
}


extension UIImage {
    class func imageWithColor(color: UIColor, size: CGSize=CGSize(width: 1, height: 1)) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(CGRect(origin: CGPoint.zero, size: size))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}




