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
    @Published private(set) var result: Result?

    private var subscriptions: Set<AnyCancellable> = []


    // MARK: Object life cycle

    init(configuration: Configuration) {
        question = Challenge.makeRandomQuestion(for: configuration.fretboard)

        configuration.$fretboard
            .sink(receiveValue: nextQuestion(for:))
            .store(in: &subscriptions)
    }


    // MARK: Public methods

    func attemptAnswer(with note: Note) {
        result = Result(question: question, attemptedAnswer: Answer(note: note))
    }


    func nextQuestion(for fretboard: Fretboard) {
        result = nil
        question = Challenge.makeRandomQuestion(for: fretboard)
    }


    func resetQuestionTimer() {
        if result == nil {
            question.time = Date()
        }
    }


    // MARK: Private Type methods

    private static func makeRandomQuestion(for fretboard: Fretboard) -> Question {
        let fret = fretboard.frets.shuffled().first!
        let string = fretboard.strings.shuffled().first!
        return Question(fret: fret, string: string, on: fretboard)
    }
}
