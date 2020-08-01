//
//  Tuning.swift
//  Fret Notes
//
//  Created by luca strazzullo on 15/7/20.
//  Copyright © 2020 Luca Strazzullo. All rights reserved.
//

import Foundation

struct Tuning: Codable, Equatable {

    enum Default: Int, Codable {
        case standard

        var notes: [Note] {
            switch self {
            case .standard:
                return [.e, .a, .d, .g, .b, .e]
            }
        }
    }

    let notes: [Note]

    init(with default: Default) {
        notes = `default`.notes
    }

    func firstNote(on string: Int) -> Note {
        return notes.reversed()[string - 1]
    }
}
