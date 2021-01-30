//
//  QuantityVC.swift
//  FestFriend02
//  Copyright © 2019 MySoftheaven BD. All rights reserved.
//

import UIKit

class QuantityVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var lblHeading: UILabel!
    
    var delegate: QuantityVCDelegate!
    var type: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnDoneAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnAllAction(_ sender: UIButton) {
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: QuantityCVCell.self), for: indexPath) as! QuantityCVCell
        
        cell.lblQuantity.text = "\(indexPath.row + 1)"
        
        if type == 0 {
            cell.lblType.textColor = UIColor.black
            cell.lblType.text = "BID"
        } else {
            cell.lblType.textColor = UIColor.appRedColor
            cell.lblType.text = "ASK"
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width / 2) - 12
        let height = 58
        let size = CGSize(width: Int(width), height: height)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate.quantitySelected(quantity: indexPath.row + 1)
        dismiss(animated: true)
    }
    
}
