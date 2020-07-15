//
//  Game.swift
//  Fret Notes
//
//  Created by luca strazzullo on 15/7/20.
//  Copyright © 2020 Luca Strazzullo. All rights reserved.
//

import Foundation
import Combine

class Game: ObservableObject {

    // MARK: Instance properties

    @Published private(set) var question: Question
    @Published private(set) var attemptedAnswer: Answer?

    private var subscriptions: Set<AnyCancellable> = []

    private let fretboard: FretBoard


    // MARK: Object life cycle

    init() {
        fretboard = FretBoard(tuningType: .standard)
        question = Game.generateRandomQuestion(for: fretboard)
    }


    // MARK: Public methods

    func nextQuestion() {
        attemptedAnswer = nil
        question = Game.generateRandomQuestion(for: fretboard)
    }


    func attempt(answer: Answer) {
        attemptedAnswer = answer
    }


    private static func generateRandomQuestion(for fretboard: FretBoard) -> Question {
        let fret = fretboard.frets.shuffled().first!
        let string = fretboard.strings.shuffled().first!
        let note = fretboard.note(on: fret, string: string)
        return Question(fret: fret, string: string, note: note)
    }
}
