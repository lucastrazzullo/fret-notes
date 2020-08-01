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
    @Published private(set) var fretboard: FretBoard
    @Published private(set) var configuration: FretboardConfigurations.ConfigurationItem

    private(set) var configurations: FretboardConfigurations

    private var subscriptions: Set<AnyCancellable> = []


    // MARK: Object life cycle

    init() {
        configurations = FretboardConfigurations()

        let defaultConfiguration = configurations.getDefaultConfigutation()
        let defaultFretboard = FretBoard(tuningType: .standard, frets: defaultConfiguration.frets)
        fretboard = defaultFretboard
        configuration = defaultConfiguration
        question = Challenge.generateRandomQuestion(for: defaultFretboard)
    }


    // MARK: Public methods

    func updateConfiguration(_ item: FretboardConfigurations.ConfigurationItem) {
        configurations.save(defaultConfiguration: item)
        configuration = item

        fretboard = FretBoard(tuningType: .standard, frets: item.frets)
        question = Challenge.generateRandomQuestion(for: fretboard)
    }


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
