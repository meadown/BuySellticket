//
//  ViewControllerExtension.swift
//  FestFriend02
//  Copyright © 2019 MySoftheaven BD. All rights reserved.
//

import UIKit
import MBProgressHUD

extension UIViewController {
    
    func showProgress(on view: UIView?) {
        
        var topView = self.view!
        if let view = view {
            topView = view
        }
        
        MBProgressHUD.showAdded(to: topView, animated: true)
    }
    
    func dismissProgress(for view: UIView) {
        MBProgressHUD.hide(for: view, animated: true)
    }
    
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func showDialog(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
  
    
    func setMultilineTitle(title: String) -> UILabel {
        let lblTitle = UILabel(frame: CGRect(x: 0, y: 0, width: 500, height: 50))
        lblTitle.numberOfLines = 0
        lblTitle.backgroundColor = UIColor.clear
        lblTitle.textAlignment = .center
        lblTitle.font = UIFont.boldSystemFont(ofSize: 15.0)
        lblTitle.text = title
        navigationItem.titleView = lblTitle
        
        return lblTitle
    }
}
