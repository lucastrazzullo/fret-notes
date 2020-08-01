//
//  Application.swift
//  Fret Notes
//
//  Created by luca strazzullo on 21/7/20.
//  Copyright © 2020 Luca Strazzullo. All rights reserved.
//

import Foundation

class Application {

    let challenge: Challenge
    let average: Average

    private let userActivity: NSUserActivity


    // MARK: Object life cycle

    init() {
        challenge = Challenge()
        average = Average()
        userActivity = Application.buildChallengeActivity()
    }


    // MARK: Public methods

    func resume() {
        challenge.resetQuestionTimer()
        userActivity.becomeCurrent()
    }


    func pause() {
        userActivity.resignCurrent()
    }


    // MARK: Private type methods

    private static func buildChallengeActivity() -> NSUserActivity {
        let activity = NSUserActivity(activityType: "com.lucastrazzullo.Fret-Notes.challenge")
        activity.isEligibleForSearch = true
        activity.isEligibleForHandoff = true
        activity.isEligibleForPrediction = true
        activity.isEligibleForPublicIndexing = true

        activity.title = "Fret Notes Challenge"
        activity.keywords = ["Fret", "Fretnotes", "Note", "Tuning", "Fretboard", "Fret board", "Guitar"]

        return activity
    }
}
