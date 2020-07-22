//
//  Average.swift
//  Fret Notes
//
//  Created by luca strazzullo on 22/7/20.
//  Copyright © 2020 Luca Strazzullo. All rights reserved.
//

import Foundation

class Average: ObservableObject {

    private static let userDefaultsKey: String = "latestTimings"
    private static let latestTimingsLimit: Int = 10


    // MARK: Instance properties

    @Published private(set) var value: Double?

    private var latestTimings: [Double]


    // MARK: Object life cycle

    init() {
        latestTimings = UserDefaults.standard.array(forKey: Average.userDefaultsKey) as? [Double] ?? []
        updateValue()
    }


    init(timings: [Double]) {
        latestTimings = timings
        updateValue()
    }


    // MARK: Public methods

    func add(timing: Double) {
        append(timing: timing)
        updateValue()

        UserDefaults.standard.setValue(latestTimings, forKey: Average.userDefaultsKey)
    }


    func reset() {
        latestTimings.removeAll()
        updateValue()

        UserDefaults.standard.setValue(latestTimings, forKey: Average.userDefaultsKey)
    }


    // MARK: Private helper methods

    private func updateValue() {
        if latestTimings.count > 0 {
            value = latestTimings.reduce(0, +) / Double(latestTimings.count)
        } else {
            value = nil
        }
    }


    private func append(timing: Double) {
        latestTimings.append(timing)

        if latestTimings.count > Average.latestTimingsLimit {
            latestTimings.removeFirst()
        }
    }
}
