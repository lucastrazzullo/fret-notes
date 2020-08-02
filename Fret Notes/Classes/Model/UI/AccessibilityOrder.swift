//
//  AccessibilityOrder.swift
//  Fret Notes
//
//  Created by luca strazzullo on 2/8/20.
//  Copyright © 2020 Luca Strazzullo. All rights reserved.
//

import Foundation

enum AccessibilityOrder: Double {
    case result = 4
    case question = 3
    case answer = 2
    case average = 1
    case options = 0

    var priority: Double {
        return rawValue
    }
}
