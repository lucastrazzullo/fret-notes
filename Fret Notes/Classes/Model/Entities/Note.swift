//
//  Note.swift
//  Fret Notes
//
//  Created by luca strazzullo on 15/7/20.
//  Copyright © 2020 Luca Strazzullo. All rights reserved.
//

import Foundation

enum Note: Int, CaseIterable, Codable {
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
        case .a, .aSharp: return "a"
        case .b: return "b"
        case .c, .cSharp: return "c"
        case .d, .dSharp: return "d"
        case .e: return "e"
        case .f, .fSharp: return "f"
        case .g, .gSharp: return "g"
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

    var symbolExtended: String? {
        switch self {
        case .aSharp, .cSharp, .dSharp, .fSharp, .gSharp:
            return "Sharp"
        default:
            return nil
        }
    }
}
