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
    @Published private(set) var fretboard: Fretboard
    @Published private(set) var configuration: Configuration.ConfigurationItem

    let tuning: TuningType = .standard
    let configurations: Configuration

    private var subscriptions: Set<AnyCancellable> = []


    // MARK: Object life cycle

    init() {
        configurations = Configuration()

        let defaultConfiguration = configurations.default()
        let defaultFretboard = Fretboard(tuningType: tuning, frets: defaultConfiguration.frets)
        fretboard = defaultFretboard
        configuration = defaultConfiguration
        question = Challenge.generateRandomQuestion(for: defaultFretboard)
    }


    // MARK: Public methods

    func updateConfiguration(_ item: Configuration.ConfigurationItem) {
        configurations.save(defaultConfiguration: item)
        configuration = item

        fretboard = Fretboard(tuningType: tuning, frets: item.frets)
        question = Challenge.generateRandomQuestion(for: fretboard)
    }


    func attemptAnswer(with note: Note) {
        let answer = Answer(note: note)
        result = Result(question: question, attemptedAnswer: answer)
    }


    func nextQuestion() {
        result = nil
        question = Challenge.generateRandomQuestion(for: fretboard)
    }


    func resetQuestionTimer() {
        if result == nil {
            question.time = Date()
        }
    }


    private static func generateRandomQuestion(for fretboard: Fretboard) -> Question {
        let fret = fretboard.frets.shuffled().first!
        let string = fretboard.strings.shuffled().first!
        return Question(fret: fret, string: string, on: fretboard)
    }
}
