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
    @Published private(set) var configuration: FretboardConfigurations.ConfigurationItem

    private(set) var configurations: FretboardConfigurations

    private var subscriptions: Set<AnyCancellable> = []


    // MARK: Object life cycle

    init() {
        configurations = FretboardConfigurations(tuningType: .standard)

        let currentConfiguration = configurations.items[0]
        configuration = currentConfiguration
        question = Challenge.generateRandomQuestion(for: currentConfiguration.fretboard)
    }


    // MARK: Public methods

    func updateConfiguration(_ item: FretboardConfigurations.ConfigurationItem) {
        configuration = item
        question = Challenge.generateRandomQuestion(for: configuration.fretboard)
    }


    func nextQuestion() {
        question = Challenge.generateRandomQuestion(for: configuration.fretboard)
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
