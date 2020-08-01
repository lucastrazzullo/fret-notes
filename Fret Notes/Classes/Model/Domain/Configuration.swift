//
//  Configuration.swift
//  Fret Notes
//
//  Created by luca strazzullo on 30/7/20.
//  Copyright © 2020 Luca Strazzullo. All rights reserved.
//

import Foundation

class Configuration: ObservableObject {

    enum FretSection: Int, CaseIterable {
        case full
        case startBoard
        case middleBoard
        case endBoard

        var frets: ClosedRange<Int> {
            switch self {
            case .full:
                return Fretboard.defaultFretsRange
            case .startBoard:
                return 0...9
            case .middleBoard:
                return 7...12
            case .endBoard:
                return 12...22
            }
        }
    }


    // MARK: Type properties

    private static let userDefaultsKey: String = "configuration.fretboard"
    private static let defaultTuning: Tuning.Default = .standard


    // MARK: Instance properties

    @Published private(set) var fretboard: Fretboard


    // MARK: Object life cycle

    init(fretboard: Fretboard) {
        self.fretboard = fretboard
    }


    convenience init(with fretSection: FretSection = FretSection.full) {
        self.init(fretboard: Fretboard(Configuration.defaultTuning, frets: fretSection.frets))
    }


    // MARK: Public methods

    func update(with fretSection: FretSection) {
        objectWillChange.send()
        fretboard.frets = fretSection.frets
        store()
    }


    // MARK: Storage

    static func stored() -> Configuration? {
        guard let data = UserDefaults.standard.object(forKey: Configuration.userDefaultsKey) as? Data else {
            return nil
        }
        guard let fretboard = try? JSONDecoder().decode(Fretboard.self, from: data) else {
            return nil
        }
        return Configuration(fretboard: fretboard)
    }


    private func store() {
        if let data = try? JSONEncoder().encode(fretboard) {
            UserDefaults.standard.setValue(data, forKey: Configuration.userDefaultsKey)
            UserDefaults.standard.synchronize()
        }
    }
}
