//
//  FretboardConfigurations.swift
//  Fret Notes
//
//  Created by luca strazzullo on 30/7/20.
//  Copyright © 2020 Luca Strazzullo. All rights reserved.
//

import Foundation

struct FretboardConfigurations {

    struct OptionItem {
        let fretboard: FretBoard
        let title: String
    }

    let items: [OptionItem]

    init() {
        items = [
            .init(fretboard: FretBoard(tuningType: .standard), title: "Full"),
            .init(fretboard: FretBoard(tuningType: .standard), title: "From 0 to 9th fret"),
            .init(fretboard: FretBoard(tuningType: .standard), title: "From 7th to 12th fret"),
            .init(fretboard: FretBoard(tuningType: .standard), title: "From 12th to 22th fret")
        ]
    }
}
