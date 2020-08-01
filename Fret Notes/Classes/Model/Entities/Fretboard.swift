//
//  FretBoard.swift
//  Fret Notes
//
//  Created by luca strazzullo on 15/7/20.
//  Copyright © 2020 Luca Strazzullo. All rights reserved.
//

import Foundation

struct Fretboard: Codable, Equatable {

    static let defaultFretsRange = 0...24


    // MARK: Instance properties

    let frets: ClosedRange<Int>
    let strings: ClosedRange<Int>

    private let tuning: Tuning


    // MARK: Object life cycle

    init(_ default: Tuning.Default, frets: ClosedRange<Int> = defaultFretsRange, strings: ClosedRange<Int> = 1...6) {
        self.frets = frets
        self.strings = strings
        self.tuning = Tuning(with: `default`)
    }


    // MARK: Public methods

    func note(on fret: Int, string: Int) -> Note {
        let allNotes = Note.allCases
        let firstNoteOnString = tuning.firstNote(on: string)
        let firstNotePosition = allNotes.firstIndex(of: firstNoteOnString)!
        let index = (firstNotePosition + fret) % allNotes.count
        return allNotes[index]
    }
}
