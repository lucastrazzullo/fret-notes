//
//  Note.swift
//  Fret Notes
//
//  Created by luca strazzullo on 15/7/20.
//  Copyright © 2020 Luca Strazzullo. All rights reserved.
//

import Foundation

enum Note: CaseIterable {
    case a
    case aSharp
    case b
    case c
    case cSharp
    case d
    case dSharp
    case e
    case f
    case fSharp
    case g
    case gSharp

    var fullName: String {
        if let symbol = symbol {
            return "\(name)\(symbol)"
        } else {
            return name
        }
    }

    var name: String {
        switch self {
        case .a, .aSharp: return "A"
        case .b: return "B"
        case .c, .cSharp: return "C"
        case .d, .dSharp: return "D"
        case .e: return "E"
        case .f, .fSharp: return "F"
        case .g, .gSharp: return "G"
        }
    }

    var symbol: String? {
        switch self {
        case .aSharp, .cSharp, .dSharp, .fSharp, .gSharp:
            return "#"
        default:
            return nil
        }
    }
}
