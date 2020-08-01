//
//  FretBoard.swift
//  Fret Notes
//
//  Created by luca strazzullo on 15/7/20.
//  Copyright © 2020 Luca Strazzullo. All rights reserved.
//

import Foundation

struct FretBoard {

    let tuning: Tuning

    let frets: ClosedRange<Int>
    let strings: ClosedRange<Int>


    // MARK: Object life cycle

    init(tuningType: TuningType, frets: ClosedRange<Int> = 0...24, strings: ClosedRange<Int> = 1...6) {
        self.frets = frets
        self.strings = strings
        self.tuning = tuningType.tuning
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
