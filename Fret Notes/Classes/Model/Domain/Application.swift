//
//  Application.swift
//  Fret Notes
//
//  Created by luca strazzullo on 21/7/20.
//  Copyright © 2020 Luca Strazzullo. All rights reserved.
//

import Foundation
import Combine

class Application {

    let configuration: Configuration
    let challenge: Challenge
    let average: Average

    private let userActivity: NSUserActivity
    private var subscriptions: Set<AnyCancellable> = []


    // MARK: Object life cycle

    init() {
        userActivity = Application.buildChallengeActivity()

        average = Average()
        configuration = Configuration.stored() ?? Configuration()
        challenge = Challenge(fretboard: configuration.fretboard, average: average)

        configuration.$fretboard
            .sink(receiveValue: { [weak challenge] fretboard in
                challenge?.update(fretboard: fretboard)
            })
            .store(in: &subscriptions)
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
