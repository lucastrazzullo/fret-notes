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
    @Published private(set) var configuration: Configuration

    private var subscriptions: Set<AnyCancellable> = []


    // MARK: Object life cycle

    init() {
        let defaultConfiguration = Configuration.stored() ?? Configuration()
        configuration = defaultConfiguration
        question = Challenge.makeRandomQuestion(for: defaultConfiguration.fretboard)
    }


    // MARK: Public methods

    func updateConfiguration(_ newConfiguration: Configuration) {
        configuration = newConfiguration
        configuration.store()
        question = Challenge.makeRandomQuestion(for: configuration.fretboard)
    }


    func attemptAnswer(with note: Note) {
        result = Result(question: question, attemptedAnswer: Answer(note: note))
    }


    func nextQuestion() {
        result = nil
        question = Challenge.makeRandomQuestion(for: configuration.fretboard)
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
