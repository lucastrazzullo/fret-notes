//
//  Question.swift
//  Fret Notes
//
//  Created by luca strazzullo on 15/7/20.
//  Copyright © 2020 Luca Strazzullo. All rights reserved.
//

import Foundation

struct Question {
    let time: Date = Date()
    let fret: Int
    let string: Int
    let note: Note

    init(fret: Int, string: Int, on fretboard: FretBoard) {
        self.fret = fret
        self.string = string
        self.note = fretboard.note(on: fret, string: string)
    }
}
