//
//  ExpandableView.swift
//  FestFriend02
//  Copyright © 2019 MySoftheaven BD. All rights reserved.
//

import UIKit

class ExpandableView: UIView {
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    private var isExpended = false
    private let expendedHeight = CGFloat(integerLiteral: 145)
    private let colapsedHeight = CGFloat(integerLiteral: 52)
    
    func expandColapseView(expendedText: String) {
        
        if let heightConstraint = heightConstraint {
            
            if isExpended {
                isExpended = false
                headingLabel.text = "Email, Push"
                UIView.animate(withDuration: 0.2) {
                    heightConstraint.constant = self.colapsedHeight
                    self.superview!.layoutIfNeeded()
                }
            } else {
                isExpended = true
                headingLabel.text = expendedText
                UIView.animate(withDuration: 0.2) {
                    heightConstraint.constant = self.expendedHeight
                    self.superview!.layoutIfNeeded()
                }
            }
        }
    }
    
    private var headingLabel: UILabel {
        get {
            let firstSubview = self.subviews[0] as! UIStackView
            let headingLabel = firstSubview.subviews[1] as! UILabel
            return headingLabel
        }
    }
    
    private var heightConstraint: NSLayoutConstraint? {
        get {
            let constraints = self.constraints
            for constraint in constraints {
                if let identifier = constraint.identifier, identifier.elementsEqual("heightConstraint") {
                    return constraint
                }
            }
            return nil
        }
    }

}
