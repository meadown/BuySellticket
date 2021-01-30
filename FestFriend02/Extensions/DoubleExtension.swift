//
//  DoubleExtension.swift
//  FestFriend02
//  Copyright © 2019 MySoftheaven BD. All rights reserved.
//

import Foundation


extension Double {
    func roundToTwoDecimal() -> Double {
        let multiplier = pow(10.0, Double(2))
        return Darwin.round(self * multiplier) / multiplier
    }
}
