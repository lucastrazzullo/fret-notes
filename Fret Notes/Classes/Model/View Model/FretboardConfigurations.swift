//
//  FretboardConfigurations.swift
//  Fret Notes
//
//  Created by luca strazzullo on 30/7/20.
//  Copyright © 2020 Luca Strazzullo. All rights reserved.
//

import Foundation

struct FretboardConfigurations {

    struct ConfigurationItem: Identifiable {
        let id: String = UUID().uuidString
        let fretboard: FretBoard
        let title: String
    }

    let items: [ConfigurationItem]

    init(tuningType: TuningType) {
        items = [
            .init(fretboard: FretBoard(tuningType: tuningType), title: "Full fretboard"),
            .init(fretboard: FretBoard(tuningType: tuningType, frets: 0...9), title: "From 0 to 9th fret"),
            .init(fretboard: FretBoard(tuningType: tuningType, frets: 7...12), title: "From 7th to 12th fret"),
            .init(fretboard: FretBoard(tuningType: tuningType, frets: 12...22), title: "From 12th to 22th fret")
        ]
    }
}
