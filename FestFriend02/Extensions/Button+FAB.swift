//
//  Button+FAB.swift
//  FestFriend02
//  Copyright © 2019 MySoftheaven BD. All rights reserved.
//

import UIKit

extension UIButton {
    
    func makeItFAB() {
        layer.cornerRadius = frame.height / 2
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 0, height: 5)
    }
}
