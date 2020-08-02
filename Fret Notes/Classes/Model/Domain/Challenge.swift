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
    @Published var result: Result?

    private(set) var fretboard: Fretboard
    private(set) var average: Average

    private var subscriptions: Set<AnyCancellable> = []


    // MARK: Object life cycle

    init(fretboard: Fretboard, average: Average) {
        self.question = Challenge.makeRandomQuestion(for: fretboard)
        self.fretboard = fretboard
        self.average = average
    }


    // MARK: Public methods

    func nextQuestion() {
        result = nil
        question = Challenge.makeRandomQuestion(for: fretboard)
    }


    func resetQuestionTimer() {
        if result == nil {
            question.time = Date()
        }
    }


    func attemptAnswer(with note: Note) {
        result = Result(question: question, attemptedAnswer: Answer(note: note))

        if let result = result, result.isCorrect {
            average.add(timing: result.timing)
        }
    }


    func update(fretboard: Fretboard) {
        self.fretboard = fretboard
        self.nextQuestion()
    }


    // MARK: Private Type methods

    private static func makeRandomQuestion(for fretboard: Fretboard) -> Question {
        let fret = fretboard.frets.shuffled().first!
        let string = fretboard.strings.shuffled().first!
        return Question(fret: fret, string: string, on: fretboard)
    }
}
