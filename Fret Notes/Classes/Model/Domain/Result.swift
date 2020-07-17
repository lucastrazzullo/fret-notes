//
//  Result.swift
//  Fret Notes
//
//  Created by luca strazzullo on 17/7/20.
//  Copyright © 2020 Luca Strazzullo. All rights reserved.
//

import Foundation

struct Result: Identifiable {
    let id = UUID()

    let question: Question
    let attemptedAnswer: Answer

    var isCorrect: Bool {
        return attemptedAnswer.note == question.note
    }

    var timing: TimeInterval {
        let answerTime = attemptedAnswer.time.timeIntervalSinceNow
        let questionTime = question.time.timeIntervalSinceNow
        return abs(questionTime - answerTime)
    }
}
