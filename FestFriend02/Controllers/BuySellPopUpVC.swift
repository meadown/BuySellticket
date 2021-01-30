//
//  BuySellPopUpVC.swift
//  FestFriend02
//  Copyright © 2019 MySoftheaven BD. All rights reserved.
//

//Mark:- this vew controler is used to control the popup for current Bid in Buyer side.
import UIKit

class BuySellPopUpVC: UIViewController {
    
    @IBOutlet weak var btnUpdateExisting: UIButton!
    @IBOutlet weak var btnConfirm: UIButton!
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var bidPlaceTitle: UILabel!
    @IBOutlet weak var bidPlaceTitleDescription: UILabel!

    var bidAskModel: BidAskModel!
    var delegate: BuySellPopupDelegate!
    var BidPlace : Int?

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func btnUpdateExistingAction(_ sender: UIButton) {
        dismiss(animated: true)
        delegate.btnUpdateExistingClicked()
    }
    
    @IBAction func btnConfirmAction(_ sender: UIButton) {
        dismiss(animated: true)
        delegate.btnConfirmClicked()
    }
    
    @IBAction func btnCloseAction(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
}

protocol BuySellPopupDelegate {
    func btnUpdateExistingClicked()
    func btnConfirmClicked()
}
