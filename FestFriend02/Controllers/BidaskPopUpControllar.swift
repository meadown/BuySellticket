//
//  BidaskPopUpControllar.swift
//  FestFriend02
//  Copyright © 2020 MySoftheaven BD. All rights reserved.
//


//Mark:- this vew controler is used to control the popup for current ask in seller side.

    import UIKit

    class BidaskPopUpControllar: UIViewController {
        
        @IBOutlet weak var btnUpdateExisting: UIButton!
        @IBOutlet weak var btnConfirm: UIButton!
        @IBOutlet weak var btnClose: UIButton!
        @IBOutlet weak var bidPlaceTitle: UILabel!
        @IBOutlet weak var bidPlaceTitleDescription: UILabel!

        var bidAskModel: BidAskModel!
        var delegate: BidAskPopupDelegate!
        var BidPlace : Int?

        override func viewDidLoad() {
            super.viewDidLoad()

        }
        
        @IBAction func btnUpdateExistingAction(_ sender: UIButton) {
            dismiss(animated: true)
            delegate.bidasKbtnUpdateExistingClicked()
        }
        
        @IBAction func btnConfirmAction(_ sender: UIButton) {
            dismiss(animated: true)
            delegate.bidasKbtnConfirmClicked()
        }
        
        @IBAction func btnCloseAction(_ sender: UIButton) {
            dismiss(animated: true)
        }

    }

    protocol BidAskPopupDelegate {
        func bidasKbtnUpdateExistingClicked()
        func bidasKbtnConfirmClicked()
    }

    


