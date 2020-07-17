//
//  Challenge.swift
//  Fret Notes
//
//  Created by luca strazzullo on 15/7/20.
//  Copyright © 2020 Luca Strazzullo. All rights reserved.
//

import Foundation
import Combine

class Challenge: ObservableObject {

    // MARK: Instance properties

    @Published private(set) var question: Question

    private var subscriptions: Set<AnyCancellable> = []

    private let fretboard: FretBoard


    // MARK: Object life cycle

    init() {
        fretboard = FretBoard(tuningType: .standard)
        question = Challenge.generateRandomQuestion(for: fretboard)
    }


    // MARK: Public methods

    func nextQuestion() {
        question = Challenge.generateRandomQuestion(for: fretboard)
    }


    func result(for note: Note) -> Result {
        let answer = Answer(note: note)
        return Result(question: question, attemptedAnswer: answer)
    }


    private static func generateRandomQuestion(for fretboard: FretBoard) -> Question {
        let fret = fretboard.frets.shuffled().first!
        let string = fretboard.strings.shuffled().first!
        return Question(fret: fret, string: string, on: fretboard)
    }
}
