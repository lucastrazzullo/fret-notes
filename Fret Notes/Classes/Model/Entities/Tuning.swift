//
//  Tuning.swift
//  Fret Notes
//
//  Created by luca strazzullo on 15/7/20.
//  Copyright © 2020 Luca Strazzullo. All rights reserved.
//

import Foundation

protocol Tuning {
    var notes: [Note] { get }
}


extension Tuning {

    func firstNote(on string: Int) -> Note {
        return notes.reversed()[string - 1]
    }
}


// MARK: - Tunings

struct StandardTuning: Tuning {
    let notes: [Note] = [.e, .a, .d, .g, .b, .e]
}


enum TuningType {
    case standard

    var tuning: Tuning {
        switch self {
        case .standard: return StandardTuning()
        }
    }
}
